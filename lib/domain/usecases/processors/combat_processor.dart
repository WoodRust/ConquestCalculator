import 'package:conquest_calculator/domain/models/combat_context.dart';
import 'package:conquest_calculator/domain/models/combat_distributions.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'dart:math' as math;

import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/utils/probability_calculator.dart';

/// Abstract base class for combat processors
abstract class CombatProcessor {
  final CombatContext context;
  final ProbabilityCalculator probabilityCalculator;

  CombatProcessor(this.context, this.probabilityCalculator);

  /// Process the combat and return all probability distributions
  CombatDistributions processCombat();

  /// Calculate the defense value with all applicable modifiers
  int calculateEffectiveDefense({
    required Regiment defender,
    required Regiment attacker,
    bool isImpact = false,
    bool isVolley = false,
    bool isFlank = false,
    bool isRear = false,
    required Map<String, bool> specialRulesInEffect,
  }) {
    int defenseTarget = math.max(defender.defense, defender.evasion);

    // Apply Shield bonus for front attacks
    bool hasShield = defender.shield ||
        defender.hasSpecialRule('shield') ||
        specialRulesInEffect['shield'] == true;

    if (!isFlank && !isRear && hasShield) {
      defenseTarget += 1;
    }

    // Apply armor piercing for volleys
    if (isVolley && attacker.hasArmorPiercing()) {
      defenseTarget =
          math.max(defenseTarget - attacker.getArmorPiercingValue(), 0);
    }
    // Apply armor piercing as a separate rule for non-volley attacks
    else if (!isVolley && specialRulesInEffect['armorPiercing'] == true) {
      int armorPiercingValue =
          specialRulesInEffect['armorPiercingValue'] as int? ??
              attacker.getArmorPiercingValue();
      defenseTarget = math.max(defenseTarget - armorPiercingValue, 0);
    }
    // Apply cleave for melee attacks
    else if (!isVolley &&
        !isImpact &&
        (attacker.getCleave() > 0 || specialRulesInEffect['cleave'] == true)) {
      int cleaveValue =
          specialRulesInEffect['cleaveValue'] as int? ?? attacker.getCleave();
      defenseTarget = math.max(defenseTarget - cleaveValue, 0);
    }
    // Apply brutal impact for impact attacks
    else if (isImpact &&
        (attacker.getBrutalImpact() > 0 ||
            specialRulesInEffect['brutalImpact'] == true)) {
      int brutalImpactValue =
          specialRulesInEffect['brutalImpactValue'] as int? ??
              attacker.getBrutalImpact();
      defenseTarget = math.max(defenseTarget - brutalImpactValue, 0);
    }

    return defenseTarget;
  }

  /// Calculate the resolve value with all applicable modifiers
  int calculateEffectiveResolve({
    required Regiment defender,
    bool isFlank = false,
    bool isRear = false,
    required Map<String, bool> specialRulesInEffect,
  }) {
    int resolveTarget = defender.getResolve();

    // Check for Animate Vessel (auto-pass resolve tests)
    bool hasAnimateVessel = defender.hasSpecialRule('animate vessel');
    if (hasAnimateVessel) {
      return 6; // Will always pass resolve tests
    }

    // Adjust for flank/rear attacks (re-roll successful tests)
    if (isFlank || isRear) {
      // Units attacked from flank/rear must re-roll successful resolve tests
      // Simulate re-rolls by reducing the target
      resolveTarget = math.max(resolveTarget - 1, 0);
    }

    return resolveTarget;
  }

  /// Calculate wound distribution based on hits and defense
  ProbabilityDistribution calculateWoundDistribution(
    ProbabilityDistribution hitDistribution,
    int defenseTarget,
  ) {
    // For defense roll failures, we need to roll higher than the defense target
    // E.g., if defense is 2, rolls of 3, 4, 5, 6 are failures
    int failureTarget = 6 - defenseTarget;

    // Create binomial distribution for direct wounds
    return probabilityCalculator.calculateBinomialDistribution(
      dice: hitDistribution.mean.round(),
      targetValue: failureTarget,
    );
  }

  /// Calculate resolve distribution based on wounds and resolve
  ProbabilityDistribution calculateResolveDistribution(
    ProbabilityDistribution woundDistribution,
    int resolveTarget,
    int indomitableValue,
  ) {
    // For resolve tests failures, we need to roll higher than the resolve target
    // E.g., if resolve is 3, rolls of 4, 5, 6 are failures
    int failureTarget = 6 - resolveTarget;

    // Create binomial distribution for resolve failures
    ProbabilityDistribution resolveDistribution =
        probabilityCalculator.calculateBinomialDistribution(
      dice: woundDistribution.mean.round(),
      targetValue: failureTarget,
    );

    // Apply Indomitable effect if present
    if (indomitableValue > 0) {
      // This is a simple approximation - we subtract indomitable from the mean
      double adjustedMean =
          math.max(0.0, resolveDistribution.mean - indomitableValue);

      // Create a new binomial distribution with appropriate mean
      if (adjustedMean > 0) {
        // Calculate probability that would give this adjusted mean
        double p = adjustedMean / woundDistribution.mean.round();
        if (p > 0 && p < 1) {
          int adjustedTarget = (6 * p).round();
          adjustedTarget = math.min(math.max(adjustedTarget, 0), 6);

          resolveDistribution =
              probabilityCalculator.calculateBinomialDistribution(
            dice: woundDistribution.mean.round(),
            targetValue: adjustedTarget,
          );
        }
      } else {
        // If indomitable would reduce to 0, create a distribution with just a 0
        resolveDistribution = ProbabilityDistribution(
          probabilities: [1.0], // 100% chance of 0 wounds
          mean: 0.0,
          standardDeviation: 0.0,
          diceCount: woundDistribution.mean.round(),
          targetValue: failureTarget,
        );
      }
    }

    return resolveDistribution;
  }

  /// Calculate total damage distribution (direct wounds + morale wounds)
  ProbabilityDistribution calculateTotalDamageDistribution(
    ProbabilityDistribution woundDistribution,
    ProbabilityDistribution resolveDistribution,
    int totalAttacks,
  ) {
    // Calculate a reasonable maximum for the total damage distribution
    int reasonableMaxOutcome = totalAttacks * 2 + 5;

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

    return probabilityCalculator.combineProbabilityDistributions(
      woundDistribution,
      resolveDistribution,
      maxOutcome: maxOutcome,
    );
  }
}
