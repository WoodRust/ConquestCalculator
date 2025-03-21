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

    // Apply Terrifying effect if in melee combat (not volley) and defender doesn't have Fearless or Bravery
    if (!context.isVolley &&
        context.attacker.getTerrifying() > 0 &&
        !defender.hasSpecialRule('fearless') &&
        !defender.hasSpecialRule('bravery')) {
      // Reduce resolve by terrifying value
      resolveTarget =
          math.max(resolveTarget - context.attacker.getTerrifying(), 1);
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
      dice: hitDistribution.mean,
      targetValue: failureTarget,
    );
  }

  /// Calculate resolve distribution based on wounds and resolve
  ProbabilityDistribution calculateResolveDistribution(
    ProbabilityDistribution woundDistribution,
    int resolveTarget,
    int indomitableValue, {
    bool isFlank = false,
    bool isRear = false,
  }) {
    // For resolve tests, rolling less than or equal to the resolveTarget is a success
    // Rerolls depend on flank/rear status
    bool needsRerollSuccesses = isFlank || isRear;

    // Calculate binomial distribution for resolve tests
    ProbabilityDistribution resolveDistribution;

    if (needsRerollSuccesses) {
      // Use the distribution with rerolls method for flank/rear attacks
      resolveDistribution =
          probabilityCalculator.calculateDistributionWithRerolls(
        dice: woundDistribution.mean,
        target: resolveTarget,
        rerollSuccesses: true, // Reroll successes for flank/rear attacks
      );
    } else {
      // Standard calculation for non-flank/rear attacks
      // For resolve failures, we need dice higher than resolveTarget
      int failureTarget = 6 - resolveTarget;

      resolveDistribution = probabilityCalculator.calculateBinomialDistribution(
        dice: woundDistribution.mean,
        targetValue: failureTarget,
      );
    }

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
            dice: woundDistribution.mean,
            targetValue: adjustedTarget,
          );
        }
      } else {
        // If indomitable would reduce to 0, create a distribution with just a 0
        resolveDistribution = ProbabilityDistribution(
          probabilities: [1.0], // 100% chance of 0 wounds
          mean: 0.0,
          standardDeviation: 0.0,
          diceCount: woundDistribution.mean,
          targetValue: 6 - resolveTarget, // Keep original target for reference
        );
      }
    }
    print("===== Resolve Calculation =====");
    print("Resolve Target: $resolveTarget");
    print("Indomitable Value: $indomitableValue");
    print(
        "Failure Target Calculation: 6 - $resolveTarget = ${6 - resolveTarget}");
    print("Wounds for Morale Tests: ${woundDistribution.mean.round()}");
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
