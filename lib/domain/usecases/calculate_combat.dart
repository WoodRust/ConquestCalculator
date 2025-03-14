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
    bool isWithinEffectiveRange = true,
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
      hitTarget = attacker.volley;
    } else if (isImpact) {
      // For impact attacks, use the clash value
      hitTarget = attacker.clash;
      totalAttacks = _calculateTotalAttacks(
        attacker: attacker,
        numAttackerStands: numAttackerStands,
        isCharge: isCharge,
        isImpact: isImpact,
        specialRulesInEffect: specialRulesInEffect,
        impactValues: impactValues,
      );
    } else {
      // For clash attacks, use the base clash value with potential inspired bonus
      hitTarget =
          attacker.clash + (specialRulesInEffect['inspired'] == true ? 1 : 0);
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
    ProbabilityDistribution hitDistribution = ProbabilityDistribution.binomial(
      dice: totalAttacks,
      targetValue: hitTarget,
    );

    // For backward compatibility with the old system
    DiceResult hitRoll = DiceResult.fromRoll(
      dice: totalAttacks,
      target: hitTarget,
    );

    // 3. Calculate defense parameters
    int defenseTarget = max(defender.defense, defender.evasion);

    // Adjust for armor piercing
    int effectiveDefense = defenseTarget;
    if (isVolley && attacker.armorPiercing) {
      effectiveDefense = max(defenseTarget - attacker.armorPiercingValue, 0);
    } else if (specialRulesInEffect['cleave'] == true) {
      // Apply cleave effect, reducing effective defense
      int cleaveValue = specialRulesInEffect['cleaveValue'] as int? ?? 1;
      effectiveDefense = max(defenseTarget - cleaveValue, 0);
    }

    // Adjust for flanking and special rules
    if (isFlank || isRear) {
      // Flanking ignores shields - simulate by reducing defense
      if (defender.hasSpecialRule('shield')) {
        effectiveDefense = max(effectiveDefense - 1, 0);
      }
    }

    // 4. Calculate wounds distribution based on defense
    // Convert hit distribution to wounds by calculating defense
    // success probability and applying binomial for each hit outcome
    ProbabilityDistribution woundDistribution =
        _calculateWoundDistribution(hitDistribution, effectiveDefense);

    // For backward compatibility
    DiceResult defenseRoll = DiceResult.fromRoll(
      dice: hitRoll.successes,
      target: effectiveDefense,
    );

    // 5. Calculate resolve test distribution
    int resolveTarget = defender.getResolve();
    bool hasAnimateVessel = defender.hasSpecialRule('animate vessel');

    if (hasAnimateVessel) {
      // Animate Vessel units auto-pass resolve tests
      resolveTarget = 6; // Will always succeed
    }

    // Adjust for flanking
    if (isFlank || isRear) {
      // Units attacked from flank/rear must re-roll successful resolve tests
      resolveTarget =
          max(resolveTarget - 1, 0); // Simulate re-rolls by reducing target
    }

    // Calculate morale wound distribution based on wounds already suffered
    ProbabilityDistribution resolveDistribution =
        _calculateResolveDistribution(woundDistribution, resolveTarget);

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
      ProbabilityDistribution woundDistribution, int resolveTarget) {
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
    if (attacker.hasSpecialRule('rapid volley')) {
      // Rapid volley allows re-rolling failed hits
      double rapidVolleyMultiplier = 1 + ((6 - attacker.volley) / 6);
      totalVolleys = (totalVolleys * rapidVolleyMultiplier).round();
    }

    if (attacker.hasSpecialRule('torrential fire')) {
      // Torrential fire allows every hit to generate another attack
      double torrentialFireMultiplier =
          1 + (attacker.volley / 6); // Approximate effect
      totalVolleys = (totalVolleys * torrentialFireMultiplier).round();
    }

    // Penalize for being outside effective range
    if (!isWithinEffectiveRange) {
      totalVolleys = (totalVolleys * 0.5)
          .round(); // Half effectiveness outside effective range
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
  }) {
    int totalAttacks;

    if (isImpact) {
      // For impact attacks, get the impact value
      int impactValue = impactValues['impactValue'] ?? 0;

      // Check if the regiment has Impact special rule
      for (final rule in attacker.specialRules) {
        if (rule.contains('Impact (')) {
          // Extract the impact value from the special rule
          final match = RegExp(r'Impact \((\d+)\)').firstMatch(rule);
          if (match != null && match.groupCount >= 1) {
            impactValue = int.parse(match.group(1)!);
            break;
          }
        }
      }

      totalAttacks = impactValue * numAttackerStands;
    } else {
      // For regular clash, use the attacks characteristic
      totalAttacks = attacker.attacks * numAttackerStands;

      // Add support attacks from unengaged stands
      // In a simplified model, we can assume half of stands provide support
      int supportAttacks = (numAttackerStands / 2).floor();

      // If the unit has Support(X) special rule, adjust support attacks
      int supportValue = 1;

      // Extract Support value from special rules
      for (final rule in attacker.specialRules) {
        if (rule.contains('Support (')) {
          // Extract the support value from the special rule
          final match = RegExp(r'Support \((\d+)\)').firstMatch(rule);
          if (match != null && match.groupCount >= 1) {
            supportValue = int.parse(match.group(1)!);
            break;
          }
        }
      }

      supportAttacks *= supportValue;
      totalAttacks += supportAttacks;
    }

    // Apply special rules modifications
    if (attacker.hasSpecialRule('flurry')) {
      // Flurry allows re-rolling failed hits
      // We can simulate this by increasing the effective number of attacks
      // For a clash value of 3, re-rolling failures increases success by roughly 50%
      double flurryMultiplier = 1 + ((6 - attacker.clash) / 6);
      totalAttacks = (totalAttacks * flurryMultiplier).round();
    }

    return totalAttacks;
  }
}
