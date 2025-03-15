// lib/domain/usecases/calculate_combat.dart
import 'dart:math' as math;
import '../models/regiment.dart';
import '../models/combat_simulation.dart';
import '../models/probability_distribution.dart';

class CalculateCombat {
  final math.Random _random = math.Random();

  // Calculate expected result based on probabilities
  // Update the calculateExpectedResult method in the CalculateCombat class

  CombatSimulation calculateExpectedResult({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter, // Add character parameters
    required Regiment defender,
    required int numDefenderStands,
    Regiment? defenderCharacter, // Add character parameters
    bool isCharge = false,
    bool isImpact = false,
    bool isFlank = false,
    bool isRear = false,
    bool isVolley = false,
    bool isWithinEffectiveRange = false,
    Map<String, bool> specialRulesInEffect = const {},
    Map<String, int> impactValues = const {},
  }) {
    // Create mutable copies of the maps to avoid modifying unmodifiable maps
    final Map<String, bool> mutableSpecialRules =
        Map<String, bool>.from(specialRulesInEffect);
    final Map<String, int> mutableImpactValues =
        Map<String, int>.from(impactValues);

    // 1. Calculate total attacks and hit target
    int totalAttacks;
    int hitTarget;

    // Calculate effective stand counts with characters
    int effectiveAttackerStands =
        numAttackerStands + (attackerCharacter != null ? 1 : 0);
    int effectiveDefenderStands =
        numDefenderStands + (defenderCharacter != null ? 1 : 0);

    if (isVolley) {
      // For volley actions, use barrage value
      totalAttacks = _calculateTotalVolleys(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        attackerCharacter: attackerCharacter, // Add character
        isWithinEffectiveRange: isWithinEffectiveRange,
        specialRulesInEffect: mutableSpecialRules,
      );

      // Set base hit target and apply aimed modifier
      hitTarget = attacker.volley;
      if (mutableSpecialRules['aimed'] == true ||
          attacker.hasSpecialRule('deadshots')) {
        // Aimed shot adds +1 to Volley characteristic
        hitTarget += 1;

        // If aimed would raise Volley to 5+, use re-roll instead
        if (hitTarget >= 5) {
          hitTarget = attacker.volley; // Reset to base value
          mutableSpecialRules['aimedReroll'] = true;
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
        attackerCharacter: attackerCharacter, // Add character
        isCharge: isCharge,
        isImpact: isImpact,
        specialRulesInEffect: mutableSpecialRules,
        impactValues: mutableImpactValues,
      );
    } else {
      // For clash attacks, use the base clash value with potential modifier bonuses
      hitTarget = attacker.clash;

      // Apply Inspired bonus to Clash
      if (mutableSpecialRules['inspired'] == true) {
        hitTarget += 1;

        // If Inspired would raise Clash to 5+, use re-roll instead
        if (hitTarget >= 5) {
          hitTarget = attacker.clash; // Reset to base value
          mutableSpecialRules['inspiredReroll'] = true;
        }
      }

      // Apply Shock bonus when charging
      if (isCharge && attacker.hasSpecialRule('shock')) {
        hitTarget += 1;
      }

      totalAttacks = _calculateTotalAttacks(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        attackerCharacter: attackerCharacter, // Add character
        isCharge: isCharge,
        isImpact: isImpact,
        specialRulesInEffect: mutableSpecialRules,
        impactValues: mutableImpactValues,
      );
    }

    // 2. Calculate hit probability distribution
    ProbabilityDistribution hitDistribution;

    // Check for opportunists special rule (reroll fails when attacking flank/rear)
    bool hasOpportunists = attacker.hasSpecialRule('opportunists');
    bool opportunistsActive =
        hasOpportunists && (isFlank || isRear) && !isImpact;

    // Handle re-roll special cases
    if (mutableSpecialRules['aimedReroll'] == true ||
        mutableSpecialRules['inspiredReroll'] == true ||
        mutableSpecialRules['flurry'] == true ||
        opportunistsActive) {
      // For re-rolls, we simulate by increasing the hit probability
      // Note: Opportunists doesn't stack with flurry (can only reroll once)
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
    int defenseTarget = math.max(defender.defense, defender.evasion);

    // Adjust for special rules affecting defense
    int effectiveDefense = defenseTarget;

    // Apply armor piercing for volleys
    if (isVolley && attacker.hasArmorPiercing()) {
      effectiveDefense =
          math.max(defenseTarget - attacker.getArmorPiercingValue(), 0);
    }
    // Apply armor piercing as a separate rule (not tied to volleys)
    else if (!isVolley && mutableSpecialRules['armorPiercing'] == true) {
      int armorPiercingValue =
          mutableSpecialRules['armorPiercingValue'] as int? ??
              attacker.getArmorPiercingValue();
      effectiveDefense = math.max(defenseTarget - armorPiercingValue, 0);
    }
    // Apply cleave for melee attacks
    else if (!isVolley &&
        (attacker.getCleave() > 0 || mutableSpecialRules['cleave'] == true)) {
      // Get cleave value either from regiment or special rules
      int cleaveValue =
          mutableSpecialRules['cleaveValue'] as int? ?? attacker.getCleave();
      effectiveDefense = math.max(defenseTarget - cleaveValue, 0);
    }
    // Apply brutal impact for impact attacks
    else if (isImpact &&
        (attacker.getBrutalImpact() > 0 ||
            mutableSpecialRules['brutalImpact'] == true)) {
      int brutalImpactValue =
          mutableSpecialRules['brutalImpactValue'] as int? ??
              attacker.getBrutalImpact();
      effectiveDefense = math.max(defenseTarget - brutalImpactValue, 0);
    }

    // Adjust for flanking/rear attack - ignore shield
    if (isFlank || isRear) {
      if (defender.hasSpecialRule('shield') || defender.shield) {
        effectiveDefense = math.max(effectiveDefense - 1, 0);
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
      resolveTarget = math.max(
          resolveTarget - 1, 0); // Simulate re-rolls by reducing target
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
            woundDistribution, resolveDistribution, totalAttacks);

    // 7. Calculate breaking threshold based on effective stand count
    int standsToBreak = (effectiveDefenderStands / 2).ceil();

    // 8. Return complete simulation
    return CombatSimulation(
      attacker: attacker,
      numAttackerStands:
          effectiveAttackerStands, // Use effective count that includes character
      defender: defender,
      numDefenderStands:
          effectiveDefenderStands, // Use effective count that includes character
      isCharge: isCharge,
      isImpact: isImpact,
      isFlank: isFlank,
      isRear: isRear,
      isVolley: isVolley,
      isWithinEffectiveRange: isWithinEffectiveRange,
      specialRulesInEffect: mutableSpecialRules,
      hitRoll: hitRoll,
      defenseRoll: defenseRoll,
      resolveRoll: resolveRoll,
      hitDistribution: hitDistribution,
      woundDistribution: woundDistribution,
      resolveDistribution: resolveDistribution,
      totalDamageDistribution: totalDamageDistribution,
      standsToBreak:
          standsToBreak, // Set the breaking threshold based on effective stands
    );
  }

// Update method to calculate total attacks to include character attacks
  int _calculateTotalAttacks({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required bool isCharge,
    required bool isImpact,
    required Map<String, bool> specialRulesInEffect,
    required Map<String, int> impactValues,
    Map<String, int> specialRuleValues = const {},
  }) {
    int totalAttacks;
    // Create mutable copies to avoid unmodifiable map errors
    final Map<String, bool> mutableSpecialRules =
        Map<String, bool>.from(specialRulesInEffect);
    final Map<String, int> mutableSpecialRuleValues =
        Map<String, int>.from(specialRuleValues);

    if (isImpact) {
      // For impact attacks, get the impact value
      int impactValue = attacker.getImpact();

      // If that's zero, check impactValues map (for backward compatibility)
      if (impactValue == 0) {
        impactValue = impactValues['impactValue'] ?? 0;
      }

      totalAttacks = impactValue * numAttackerStands;

      // Add character impact attacks if present
      if (attackerCharacter != null && attackerCharacter.getImpact() > 0) {
        totalAttacks += attackerCharacter.getImpact();
      }

      // Apply glorious charge - updates the clash but not number of attacks
      if (isCharge && attacker.hasSpecialRule('glorious charge')) {
        mutableSpecialRules['gloriousCharge'] = true;
      }

      // Apply brutal impact - updates the defense reduction but not number of attacks
      if (attacker.getBrutalImpact() > 0) {
        mutableSpecialRules['brutalImpact'] = true;
        mutableSpecialRuleValues['brutalImpactValue'] =
            attacker.getBrutalImpact();
      }
    } else {
      // For regular clash, use the attacks characteristic
      int regimentAttacks = attacker.attacks * numAttackerStands;

      // Add character attacks
      int characterAttacks = 0;
      if (attackerCharacter != null) {
        characterAttacks = attackerCharacter.attacks;
      }

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
      totalAttacks = (engagedStands * attacker.attacks) +
          supportAttacks +
          characterAttacks;
    }

    // Apply special rules modifications
    if (attacker.hasSpecialRule('flurry') ||
        mutableSpecialRules['flurry'] == true) {
      // Flurry allows re-rolling failed hits
      // Let this be handled by our reroll-aware hit calculation instead
      mutableSpecialRules['flurry'] = true;
    }

    // Apply shock special rule - impacts clash characteristic, not attack count
    if (isCharge && attacker.hasSpecialRule('shock')) {
      mutableSpecialRules['shock'] = true;
    }

    // Apply inspired rerolls - impacts the hit probability calculation
    if (mutableSpecialRules['inspired'] == true && attacker.clash >= 4) {
      mutableSpecialRules['inspiredReroll'] = true;
    }

    // Add +1 attack if regiment has leader special rule
    if (attacker.hasSpecialRule('leader')) {
      totalAttacks += 1;
    }

    // Copy any changes back to the original map
    specialRulesInEffect.addAll(mutableSpecialRules);

    return totalAttacks;
  }

  // Updated method to include character barrage attacks
  int _calculateTotalVolleys({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required bool isWithinEffectiveRange,
    required Map<String, bool> specialRulesInEffect,
  }) {
    // Create mutable copy of the map
    final Map<String, bool> mutableSpecialRules =
        Map<String, bool>.from(specialRulesInEffect);

    if (!attacker.hasBarrage()) {
      return 0; // No barrage capability
    }

    int totalVolleys = attacker.getBarrage() * numAttackerStands;

    // Add character's barrage if present
    if (attackerCharacter != null && attackerCharacter.hasBarrage()) {
      totalVolleys += attackerCharacter.getBarrage();
    }

    // Apply special rules for volleys
    if (attacker.hasSpecialRule('rapid volley') ||
        mutableSpecialRules['rapidVolley'] == true) {
      // Rapid volley grants an additional hit on rolls of 1
      // Simulate by increasing expected hits by 1/6 of the total shots
      double rapidVolleyBonus = totalVolleys * (1.0 / 6.0);
      totalVolleys += rapidVolleyBonus.round();
    }

    if (attacker.hasSpecialRule('torrential fire') ||
        mutableSpecialRules['torrentialFire'] == true) {
      // Torrential fire grants an additional hit for every 2 hits
      // Simulate by increasing expected hits by half the success rate
      double successRate = attacker.volley / 6.0;
      double torrentialFireBonus = totalVolleys * successRate * 0.5;
      totalVolleys += torrentialFireBonus.round();
    }

    // Apply aimed re-rolls for failed hits
    if (mutableSpecialRules['aimedReroll'] == true) {
      // Similar effect to flurry for melee
      double missRate = (6.0 - attacker.volley) / 6.0;
      double rerollSuccessRate = missRate * (attacker.volley / 6.0);
      double aimedBonus = totalVolleys * rerollSuccessRate;
      totalVolleys += aimedBonus.round();
    }

    // Apply deadshots special rule (always under effects of aimed special rule)
    if (attacker.hasSpecialRule('deadshots')) {
      // This is handled in hit target adjustment, not in volley count
      mutableSpecialRules['aimed'] = true;
    }

    // Apply sureshot (ignores obscuring terrain penalties)
    if (attacker.hasSpecialRule('sureshot') ||
        mutableSpecialRules['sureshot'] == true) {
      // This doesn't affect volley count directly, but affects other calculations
      mutableSpecialRules['sureshot'] = true;
    }

    // Add +1 barrage if regiment has leader special rule
    if (attacker.hasSpecialRule('leader')) {
      totalVolleys += 1;
    }

    // Penalize for being outside effective range - halved shots
    if (!isWithinEffectiveRange) {
      totalVolleys = (totalVolleys * 0.5).round();
    }

    // Copy any changes back to the original map
    specialRulesInEffect.addAll(mutableSpecialRules);

    return totalVolleys;
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
    double stdDev = math.sqrt(variance);

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
    return coefficient * math.pow(p, k) * math.pow(1 - p, n - k);
  }

  // Calculate wound distribution based on hit distribution and defense target
  ProbabilityDistribution _calculateWoundDistribution(
      ProbabilityDistribution hitDistribution, int defenseTarget) {
    // FIXED: For Conquest, a defense target of 2 means the unit saves on a roll of 1-2
    // To calculate defense failures, we need a roll above the defenseTarget value (3-6 in this example)
    // So the probability of a failure is (6-defenseTarget)/6

    // For defense roll failures, we need to roll higher than the defense target
    // E.g., if defense is 2, rolls of 3, 4, 5, 6 are failures
    int failureTarget = 6 - defenseTarget;

    // Create binomial distribution for direct defense rolls
    // We'll use the mean number of hits as a basis for our calculation
    int expectedHits = hitDistribution.mean.round();

    // Create a direct binomial distribution for defense failures
    return ProbabilityDistribution.binomial(
      dice: expectedHits,
      targetValue: failureTarget,
    );
  }

  // Calculate resolve test distribution based on wound distribution
  ProbabilityDistribution _calculateResolveDistribution(
      ProbabilityDistribution woundDistribution,
      int resolveTarget,
      int indomitableValue) {
    // FIXED: For resolve tests, a roll above the resolveTarget is a failure
    // E.g., if resolve is 3, rolls of 4, 5, 6 are failures
    int failureTarget = 6 - resolveTarget;

    // Use the expected number of wounds as the basis for resolve tests
    int expectedWounds = woundDistribution.mean.round();

    // Create binomial distribution for resolve failures
    ProbabilityDistribution resolveDistribution =
        ProbabilityDistribution.binomial(
      dice: expectedWounds,
      targetValue: failureTarget,
    );

    // Apply Indomitable effect if present
    if (indomitableValue > 0) {
      // This is a simple approximation - we subtract indomitable from the mean
      // and create a new distribution with adjusted mean and standard deviation
      double adjustedMean =
          math.max(0.0, resolveDistribution.mean - indomitableValue);

      // Create a new binomial distribution with appropriate mean
      if (adjustedMean > 0) {
        // Calculate probability that would give this adjusted mean
        double p = adjustedMean / expectedWounds;
        if (p > 0 && p < 1) {
          int adjustedTarget = (6 * p).round();
          adjustedTarget = math.min(math.max(adjustedTarget, 0), 6);

          resolveDistribution = ProbabilityDistribution.binomial(
            dice: expectedWounds,
            targetValue: adjustedTarget,
          );
        }
      } else {
        // If indomitable would reduce to 0, create a distribution with just a 0
        resolveDistribution = ProbabilityDistribution(
          probabilities: [1.0], // 100% chance of 0 wounds
          mean: 0.0,
          standardDeviation: 0.0,
          diceCount: expectedWounds,
          targetValue: failureTarget,
        );
      }
    }

    return resolveDistribution;
  }

  // Calculate total damage by combining wound and resolve distributions
  ProbabilityDistribution _calculateTotalDamageDistribution(
      ProbabilityDistribution woundDistribution,
      ProbabilityDistribution resolveDistribution,
      int totalAttacks) {
    // Calculate a reasonable maximum for the total damage distribution
    // Typically, worst case is all attacks hit, all defense rolls fail, all morale tests fail
    // So roughly 2x the total attack dice is a reasonable upper bound
    int reasonableMaxOutcome = totalAttacks * 2;

    // Add a buffer for special rules that might increase damage
    reasonableMaxOutcome += 5;

    // Ensure we capture at least the mean + 3 standard deviations of both distributions
    int statisticalMax = (woundDistribution.mean +
            resolveDistribution.mean +
            3 *
                (woundDistribution.standardDeviation +
                    resolveDistribution.standardDeviation))
        .ceil();

    // Use the smaller of our calculated max and statistical max, but ensure it's at least 10
    int maxOutcome =
        math.max(10, math.min(reasonableMaxOutcome, statisticalMax));

    return ProbabilityDistribution.combine(
        woundDistribution, resolveDistribution,
        maxOutcome: maxOutcome);
  }

// Add this simplified method for direct calculation if needed for testing
  ProbabilityDistribution calculateSimplifiedWoundDistribution(
      int totalAttacks, int hitTarget, int defenseValue, int resolveValue) {
    // 1. Calculate hit probability distribution
    ProbabilityDistribution hitDistribution = ProbabilityDistribution.binomial(
      dice: totalAttacks,
      targetValue: hitTarget,
    );

    // 2. Calculate direct wounds distribution
    ProbabilityDistribution woundDistribution =
        ProbabilityDistribution.binomial(
      dice: hitDistribution.mean.round(),
      targetValue: 7 - defenseValue,
    );

    // 3. Calculate morale wounds distribution
    ProbabilityDistribution moraleDistribution =
        ProbabilityDistribution.binomial(
      dice: woundDistribution.mean.round(),
      targetValue: 7 - resolveValue,
    );

    // 4. Combine direct and morale wounds
    return ProbabilityDistribution.combine(
      woundDistribution,
      moraleDistribution,
    );
  }
}
