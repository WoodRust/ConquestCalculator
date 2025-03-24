// lib/domain/usecases/processors/combat_processor.dart - Consistent Special Rules
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
  }) {
    int defenseTarget = math.max(defender.defense, defender.evasion);

    // UPDATED: Apply Shield bonus for front attacks - only use context check
    bool hasShield = context.defenderHasRule('shield');
    print("\ndefender has shield: $hasShield");
    if (!isFlank && !isRear && hasShield) {
      print("\nApply shield to effective defence");
      defenseTarget += 1;
    }

    // UPDATED: Apply armor piercing for volleys - use context check
    if (isVolley && context.attackerHasRule('armorPiercing')) {
      defenseTarget =
          math.max(defenseTarget - attacker.getArmorPiercingValue(), 0);
    }
    // Apply armor piercing as a separate rule for non-volley attacks
    else if (!isVolley && context.attackerHasRule('armorPiercing')) {
      int armorPiercingValue = context.impactValues['armorPiercingValue'] ??
          attacker.getArmorPiercingValue();
      defenseTarget = math.max(defenseTarget - armorPiercingValue, 0);
    }
    // UPDATED: Apply cleave for melee attacks - only use context check
    else if (!isVolley && !isImpact && context.attackerHasRule('cleave')) {
      int cleaveValue =
          context.impactValues['cleaveValue'] ?? attacker.getCleave();
      defenseTarget = math.max(defenseTarget - cleaveValue, 0);
    }
    // UPDATED: Apply brutal impact for impact attacks - only use context check
    else if (isImpact && context.attackerHasRule('brutalImpact')) {
      int brutalImpactValue = context.impactValues['brutalImpactValue'] ??
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
  }) {
    int resolveTarget = defender.getResolve();

    // UPDATED: Check for Animate Vessel (auto-pass resolve tests) - use context check
    bool hasAnimateVessel = context.defenderHasRule('animate vessel');
    if (hasAnimateVessel) {
      return 6; // Will always pass resolve tests
    }

    // Apply Terrifying effect if in melee combat (not volley) and rule is active
    if (!context.isVolley &&
        context.attackerHasRule('terrifying') &&
        !context.defenderHasRule('fearless') &&
        !context.defenderHasRule('bravery')) {
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

    // UPDATED: Apply Indomitable effect if present and active
    if (indomitableValue > 0 && context.defenderHasRule('indomitable')) {
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
