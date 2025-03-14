// lib/domain/usecases/calculate_combat.dart
import 'dart:math';
import '../models/regiment.dart';
import '../models/combat_simulation.dart';
import '../models/probability_distribution.dart';

class CalculateCombat {
  final Random _random = Random();

  // Calculate expected result based on probabilities
  CombatSimulation calculateExpectedResult({
    required Regiment attacker,
    required int numAttackerStands,
    required Regiment defender,
    required int numDefenderStands,
    bool isCharge = false,
    bool isImpact = false,
    bool isFlank = false,
    bool isRear = false,
    bool isVolley = false,
    bool isWithinEffectiveRange = false, // Changed default to false
    Map<String, bool> specialRulesInEffect = const {},
    Map<String, int> impactValues = const {},
  }) {
    // 1. Calculate total attacks and hit target
    int totalAttacks;
    int hitTarget;

    if (isVolley) {
      // For volley actions, use barrage value
      totalAttacks = _calculateTotalVolleys(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        isWithinEffectiveRange: isWithinEffectiveRange,
        specialRulesInEffect: specialRulesInEffect,
      );

      // Set base hit target and apply aimed modifier
      hitTarget = attacker.volley;
      if (specialRulesInEffect['aimed'] == true ||
          attacker.hasSpecialRule('deadshots')) {
        // Aimed shot adds +1 to Volley characteristic
        hitTarget += 1;

        // If aimed would raise Volley to 5+, use re-roll instead
        if (hitTarget >= 5) {
          hitTarget = attacker.volley; // Reset to base value
          // The re-roll effect is simulated in _calculateTotalVolleys
          specialRulesInEffect['aimedReroll'] = true;
        }
      }
    } else if (isImpact) {
      // For impact attacks, use the clash value and apply modifiers
      hitTarget = attacker.clash;
      if (isCharge && attacker.hasSpecialRule('glorious charge')) {
        hitTarget += 1; // Glorious Charge adds +1 to Clash for Impact Attacks
      }

      totalAttacks = _calculateTotalAttacks(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        isCharge: isCharge,
        isImpact: isImpact,
        specialRulesInEffect: specialRulesInEffect,
        impactValues: impactValues,
      );
    } else {
      // For clash attacks, use the base clash value with potential modifier bonuses
      hitTarget = attacker.clash;

      // Apply Inspired bonus to Clash
      if (specialRulesInEffect['inspired'] == true) {
        hitTarget += 1;

        // If Inspired would raise Clash to 5+, use re-roll instead
        if (hitTarget >= 5) {
          hitTarget = attacker.clash; // Reset to base value
          specialRulesInEffect['inspiredReroll'] = true;
        }
      }

      // Apply Shock bonus when charging
      if (isCharge && attacker.hasSpecialRule('shock')) {
        hitTarget += 1;
      }

      totalAttacks = _calculateTotalAttacks(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        isCharge: isCharge,
        isImpact: isImpact,
        specialRulesInEffect: specialRulesInEffect,
        impactValues: impactValues,
      );
    }

    // 2. Calculate hit probability distribution
    ProbabilityDistribution hitDistribution;

    // Handle re-roll special cases
    if (specialRulesInEffect['aimedReroll'] == true ||
        specialRulesInEffect['inspiredReroll'] == true ||
        specialRulesInEffect['flurry'] == true) {
      // For re-rolls, we simulate by increasing the hit probability
      // This is a simplified approach - could be more precise with a custom distribution
      hitDistribution = _calculateDistributionWithRerolls(
          dice: totalAttacks, target: hitTarget, rerollFails: true);
    } else {
      hitDistribution = ProbabilityDistribution.binomial(
        dice: totalAttacks,
        targetValue: hitTarget,
      );
    }

    // For backward compatibility with the old system
    DiceResult hitRoll = DiceResult.fromRoll(
      dice: totalAttacks,
      target: hitTarget,
    );

    // 3. Calculate defense parameters
    int defenseTarget = max(defender.defense, defender.evasion);

    // Adjust for special rules affecting defense
    int effectiveDefense = defenseTarget;

    // Apply armor piercing for volleys
    if (isVolley && attacker.armorPiercing) {
      effectiveDefense = max(defenseTarget - attacker.armorPiercingValue, 0);
    }
    // Apply cleave for melee attacks
    else if (!isVolley &&
        (attacker.getCleave() > 0 || specialRulesInEffect['cleave'] == true)) {
      // Get cleave value either from regiment or special rules
      int cleaveValue =
          specialRulesInEffect['cleaveValue'] as int? ?? attacker.getCleave();
      effectiveDefense = max(defenseTarget - cleaveValue, 0);
    }
    // Apply brutal impact for impact attacks
    else if (isImpact &&
        (attacker.getBrutalImpact() > 0 ||
            specialRulesInEffect['brutalImpact'] == true)) {
      int brutalImpactValue =
          specialRulesInEffect['brutalImpactValue'] as int? ??
              attacker.getBrutalImpact();
      effectiveDefense = max(defenseTarget - brutalImpactValue, 0);
    }

    // Adjust for flanking/rear attack - ignore shield
    if (isFlank || isRear) {
      if (defender.hasSpecialRule('shield') || defender.shield) {
        effectiveDefense = max(effectiveDefense - 1, 0);
      }
    }

    // 4. Calculate wounds distribution based on defense
    ProbabilityDistribution woundDistribution =
        _calculateWoundDistribution(hitDistribution, effectiveDefense);

    // For backward compatibility
    DiceResult defenseRoll = DiceResult.fromRoll(
      dice: hitRoll.successes,
      target: effectiveDefense,
    );

    // 5. Calculate resolve test distribution
    int resolveTarget = defender.getResolve();

    // Apply special rules affecting Resolve
    bool hasAnimateVessel = defender.hasSpecialRule('animate vessel');
    bool hasIndomitable = defender.getIndomitable() > 0;

    if (hasAnimateVessel) {
      // Animate Vessel units auto-pass resolve tests
      resolveTarget = 6; // Will always succeed
    }

    // Apply Indomitable effect
    int indomitableValue = defender.getIndomitable();

    // Adjust for flanking/rear attack
    if (isFlank || isRear) {
      // Units attacked from flank/rear must re-roll successful resolve tests
      resolveTarget =
          max(resolveTarget - 1, 0); // Simulate re-rolls by reducing target
    }

    // Calculate morale wound distribution based on wounds already suffered
    ProbabilityDistribution resolveDistribution = _calculateResolveDistribution(
        woundDistribution, resolveTarget, indomitableValue);

    // For backward compatibility
    DiceResult resolveRoll = DiceResult.fromRoll(
      dice: defenseRoll.failures,
      target: resolveTarget,
    );

    // 6. Calculate total damage distribution by combining wounds and resolve failures
    ProbabilityDistribution totalDamageDistribution =
        _calculateTotalDamageDistribution(
            woundDistribution, resolveDistribution);

    // 7. Return complete simulation
    return CombatSimulation(
      attacker: attacker,
      numAttackerStands: numAttackerStands,
      defender: defender,
      numDefenderStands: numDefenderStands,
      isCharge: isCharge,
      isImpact: isImpact,
      isFlank: isFlank,
      isRear: isRear,
      isVolley: isVolley,
      isWithinEffectiveRange: isWithinEffectiveRange,
      specialRulesInEffect: specialRulesInEffect,
      hitRoll: hitRoll,
      defenseRoll: defenseRoll,
      resolveRoll: resolveRoll,
      hitDistribution: hitDistribution,
      woundDistribution: woundDistribution,
      resolveDistribution: resolveDistribution,
      totalDamageDistribution: totalDamageDistribution,
    );
  }

  // New method to calculate distribution with rerolls
  ProbabilityDistribution _calculateDistributionWithRerolls({
    required int dice,
    required int target,
    bool rerollFails = false,
    bool rerollOnes = false,
  }) {
    // Calculate base success probability
    double pSuccess = target / 6.0;

    // Calculate adjusted probability with rerolls
    double adjustedProbability;

    if (rerollFails) {
      // Probability after rerolling failures:
      // P' = P + (1-P)*P = P(2-P)
      adjustedProbability = pSuccess + (1 - pSuccess) * pSuccess;
    } else if (rerollOnes) {
      // Probability after rerolling only 1s:
      // P' = P + (1/6)*P
      adjustedProbability = pSuccess + (1 / 6) * pSuccess;
    } else {
      adjustedProbability = pSuccess;
    }

    // Use standard binomial with adjusted probability
    // This is an approximation since true reroll distribution is more complex
    double mean = dice * adjustedProbability;
    double variance = dice * adjustedProbability * (1 - adjustedProbability);
    double stdDev = sqrt(variance);

    // Generate approximate probability distribution
    List<double> probabilities = List<double>.filled(dice + 1, 0.0);
    for (int k = 0; k <= dice; k++) {
      probabilities[k] = _binomialProbability(dice, k, adjustedProbability);
    }

    return ProbabilityDistribution(
      probabilities: probabilities,
      mean: mean,
      standardDeviation: stdDev,
      diceCount: dice,
      targetValue: target,
    );
  }

  // Helper for binomial probability mass function
  double _binomialProbability(int n, int k, double p) {
    if (k < 0 || k > n) return 0.0;
    if (p == 0.0) return (k == 0) ? 1.0 : 0.0;
    if (p == 1.0) return (k == n) ? 1.0 : 0.0;

    // Calculate binomial coefficient
    double coefficient = 1.0;
    for (int i = 0; i < k; i++) {
      coefficient *= (n - i) / (i + 1);
    }

    // Calculate probability
    return coefficient * pow(p, k) * pow(1 - p, n - k);
  }

  // Calculate wound distribution based on hit distribution and defense target
  ProbabilityDistribution _calculateWoundDistribution(
      ProbabilityDistribution hitDistribution, int defenseTarget) {
    // Calculate probability of failing a defense roll
    double defenseProbability = defenseTarget / 6.0;
    double failProbability = 1.0 - defenseProbability;

    // For each possible hit outcome, calculate wound distribution
    List<ProbabilityDistribution> woundDistributions = [];

    for (int hits = 0; hits < hitDistribution.probabilities.length; hits++) {
      // Skip if probability is effectively zero
      if (hitDistribution.probabilities[hits] < 0.00001) continue;

      // Create binomial distribution for defense rolls
      ProbabilityDistribution defenseDistribution =
          ProbabilityDistribution.binomial(
        dice: hits,
        targetValue: 6 - defenseTarget, // Invert for failures
      );

      // Scale by probability of getting this many hits
      List<double> scaledProbs = defenseDistribution.probabilities
          .map((p) => p * hitDistribution.probabilities[hits])
          .toList();

      // Create a distribution for this outcome
      woundDistributions.add(ProbabilityDistribution(
        probabilities: scaledProbs,
        mean: defenseDistribution.mean * hitDistribution.probabilities[hits],
        standardDeviation: defenseDistribution.standardDeviation *
            hitDistribution.probabilities[hits],
        diceCount: hits,
        targetValue: 6 - defenseTarget,
      ));
    }

    // Combine all distributions
    if (woundDistributions.isEmpty) {
      // Return empty distribution if no hits
      return ProbabilityDistribution(
        probabilities: [1.0],
        mean: 0.0,
        standardDeviation: 0.0,
        diceCount: 0,
        targetValue: 0,
      );
    }

    // Start with first distribution
    ProbabilityDistribution result = woundDistributions[0];

    // Combine with rest
    for (int i = 1; i < woundDistributions.length; i++) {
      result = _combineProbabilityDistributions(result, woundDistributions[i]);
    }

    return result;
  }

  // Calculate resolve test distribution based on wound distribution
  ProbabilityDistribution _calculateResolveDistribution(
      ProbabilityDistribution woundDistribution,
      int resolveTarget,
      int indomitableValue) {
    // Calculate probability of failing a resolve test
    double resolveProbability = resolveTarget / 6.0;
    double failProbability = 1.0 - resolveProbability;

    // For each wound outcome, calculate morale wound distribution
    List<ProbabilityDistribution> moraleDistributions = [];

    for (int wounds = 0;
        wounds < woundDistribution.probabilities.length;
        wounds++) {
      // Skip if probability is effectively zero
      if (woundDistribution.probabilities[wounds] < 0.00001) continue;

      // Create binomial distribution for resolve rolls
      ProbabilityDistribution resolveDistribution =
          ProbabilityDistribution.binomial(
        dice: wounds,
        targetValue: 6 - resolveTarget, // Invert for failures
      );

      // Apply Indomitable effect - convert some failures to successes
      if (indomitableValue > 0) {
        // This is a simplified approximation - indomitable lets you ignore X failed tests
        List<double> adjustedProbs =
            List<double>.from(resolveDistribution.probabilities);

        // Shift probability distribution to account for indomitable
        for (int i = indomitableValue; i < adjustedProbs.length; i++) {
          // Move some probability from i to i-indomitableValue
          double probToMove = adjustedProbs[i] * (indomitableValue / i);
          adjustedProbs[i] -= probToMove;
          adjustedProbs[i - indomitableValue] += probToMove;
        }

        // Create adjusted distribution
        resolveDistribution = ProbabilityDistribution(
          probabilities: adjustedProbs,
          mean: resolveDistribution.mean - indomitableValue.toDouble(),
          standardDeviation: resolveDistribution.standardDeviation,
          diceCount: resolveDistribution.diceCount,
          targetValue: resolveDistribution.targetValue,
        );
      }

      // Scale by probability of this wound outcome
      List<double> scaledProbs = resolveDistribution.probabilities
          .map((p) => p * woundDistribution.probabilities[wounds])
          .toList();

      // Create a distribution for this outcome
      moraleDistributions.add(ProbabilityDistribution(
        probabilities: scaledProbs,
        mean:
            resolveDistribution.mean * woundDistribution.probabilities[wounds],
        standardDeviation: resolveDistribution.standardDeviation *
            woundDistribution.probabilities[wounds],
        diceCount: wounds,
        targetValue: 6 - resolveTarget,
      ));
    }

    // Combine all distributions
    if (moraleDistributions.isEmpty) {
      // Return empty distribution if no wounds
      return ProbabilityDistribution(
        probabilities: [1.0],
        mean: 0.0,
        standardDeviation: 0.0,
        diceCount: 0,
        targetValue: 0,
      );
    }

    // Start with first distribution
    ProbabilityDistribution result = moraleDistributions[0];

    // Combine with rest
    for (int i = 1; i < moraleDistributions.length; i++) {
      result = _combineProbabilityDistributions(result, moraleDistributions[i]);
    }

    return result;
  }

  // Calculate total damage by combining wound and resolve distributions
  ProbabilityDistribution _calculateTotalDamageDistribution(
      ProbabilityDistribution woundDistribution,
      ProbabilityDistribution resolveDistribution) {
    return _combineProbabilityDistributions(
        woundDistribution, resolveDistribution);
  }

  // Helper method to combine two probability distributions
  ProbabilityDistribution _combineProbabilityDistributions(
      ProbabilityDistribution dist1, ProbabilityDistribution dist2) {
    int maxOutcome =
        dist1.probabilities.length + dist2.probabilities.length - 1;
    List<double> combined = List<double>.filled(maxOutcome, 0.0);

    // Discrete convolution
    for (int i = 0; i < dist1.probabilities.length; i++) {
      for (int j = 0; j < dist2.probabilities.length; j++) {
        combined[i + j] +=
            (dist1.probabilities[i] * dist2.probabilities[j]).toDouble();
      }
    }

    // Calculate combined mean and stddev
    double mean = dist1.mean + dist2.mean;
    double variance = (dist1.standardDeviation * dist1.standardDeviation) +
        (dist2.standardDeviation * dist2.standardDeviation);
    double standardDeviation = sqrt(variance);

    return ProbabilityDistribution(
      probabilities: combined,
      mean: mean,
      standardDeviation: standardDeviation,
      diceCount: dist1.diceCount + dist2.diceCount,
      targetValue: max(dist1.targetValue, dist2.targetValue),
    );
  }

  int _calculateTotalVolleys({
    required Regiment attacker,
    required int numAttackerStands,
    required bool isWithinEffectiveRange,
    required Map<String, bool> specialRulesInEffect,
  }) {
    if (!attacker.hasBarrage()) {
      return 0; // No barrage capability
    }

    int totalVolleys = attacker.getBarrage() * numAttackerStands;

    // Apply special rules for volleys
    if (attacker.hasSpecialRule('rapid volley') ||
        specialRulesInEffect['rapidVolley'] == true) {
      // Rapid volley grants an additional hit on rolls of 1
      // Simulate by increasing expected hits by 1/6 of the total shots
      double rapidVolleyBonus = totalVolleys * (1.0 / 6.0);
      totalVolleys += rapidVolleyBonus.round();
    }

    if (attacker.hasSpecialRule('torrential fire') ||
        specialRulesInEffect['torrentialFire'] == true) {
      // Torrential fire grants an additional hit for every 2 hits
      // Simulate by increasing expected hits by half the success rate
      double successRate = attacker.volley / 6.0;
      double torrentialFireBonus = totalVolleys * successRate * 0.5;
      totalVolleys += torrentialFireBonus.round();
    }

    // Apply aimed re-rolls for failed hits
    if (specialRulesInEffect['aimedReroll'] == true) {
      // Similar effect to flurry for melee
      double missRate = (6.0 - attacker.volley) / 6.0;
      double rerollSuccessRate = missRate * (attacker.volley / 6.0);
      double aimedBonus = totalVolleys * rerollSuccessRate;
      totalVolleys += aimedBonus.round();
    }

    // Apply deadshots special rule (always under effects of aimed special rule)
    if (attacker.hasSpecialRule('deadshots')) {
      // This is handled in hit target adjustment, not in volley count
      specialRulesInEffect['aimed'] = true;
    }

    // Apply sureshot (ignores obscuring terrain penalties)
    if (attacker.hasSpecialRule('sureshot') ||
        specialRulesInEffect['sureshot'] == true) {
      // This doesn't affect volley count directly, but affects other calculations
      specialRulesInEffect['sureshot'] = true;
    }

    // Penalize for being outside effective range - halved shots
    if (!isWithinEffectiveRange) {
      totalVolleys = (totalVolleys * 0.5).round();
    }

    return totalVolleys;
  }

  int _calculateTotalAttacks({
    required Regiment attacker,
    required int numAttackerStands,
    required bool isCharge,
    required bool isImpact,
    required Map<String, bool> specialRulesInEffect,
    required Map<String, int> impactValues,
    Map<String, int> specialRuleValues = const {},
  }) {
    int totalAttacks;

    if (isImpact) {
      // For impact attacks, get the impact value
      // First try to get from the Regiment's impact field
      int impactValue = attacker.getImpact();

      // If that's zero, check impactValues map (for backward compatibility)
      if (impactValue == 0) {
        impactValue = impactValues['impactValue'] ?? 0;
      }

      totalAttacks = impactValue * numAttackerStands;

      // Apply glorious charge - updates the clash but not number of attacks
      if (isCharge && attacker.hasSpecialRule('glorious charge')) {
        specialRulesInEffect['gloriousCharge'] = true;
      }

      // Apply brutal impact - updates the defense reduction but not number of attacks
      if (attacker.getBrutalImpact() > 0) {
        specialRulesInEffect['brutalImpact'] = true;
        specialRuleValues['brutalImpactValue'] = attacker.getBrutalImpact();
      }
    } else {
      // For regular clash, use the attacks characteristic
      totalAttacks = attacker.attacks * numAttackerStands;

      // Calculate support attacks from unengaged stands
      // Simplified model: we'll assume half stands are engaged, half provide support
      int engagedStands = (numAttackerStands / 2).ceil();
      int supportingStands = numAttackerStands - engagedStands;

      // Get support value from Regiment's support field
      int supportValue = attacker.getSupport();

      // If no support value is defined, default to 1
      if (supportValue == 0) {
        supportValue = 1;
      }

      int supportAttacks = supportingStands * supportValue;

      // Add engaged attacks and support attacks
      totalAttacks = (engagedStands * attacker.attacks) + supportAttacks;
    }

    // Apply special rules modifications
    if (attacker.hasSpecialRule('flurry') ||
        specialRulesInEffect['flurry'] == true) {
      // Flurry allows re-rolling failed hits
      // Let this be handled by our reroll-aware hit calculation instead
      specialRulesInEffect['flurry'] = true;
    }

    // Apply shock special rule - impacts clash characteristic, not attack count
    if (isCharge && attacker.hasSpecialRule('shock')) {
      specialRulesInEffect['shock'] = true;
    }

    // Apply inspired rerolls - impacts the hit probability calculation
    if (specialRulesInEffect['inspired'] == true && attacker.clash >= 4) {
      specialRulesInEffect['inspiredReroll'] = true;
    }

    return totalAttacks;
  }
}
