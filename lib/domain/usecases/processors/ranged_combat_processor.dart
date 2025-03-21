import 'package:conquest_calculator/domain/models/combat_context.dart';
import 'package:conquest_calculator/domain/models/combat_distributions.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'package:conquest_calculator/domain/usecases/processors/combat_processor.dart';
import 'package:conquest_calculator/domain/utils/probability_calculator.dart';

/// Processor for ranged combat
class RangedCombatProcessor extends CombatProcessor {
  RangedCombatProcessor(
      CombatContext context, ProbabilityCalculator probabilityCalculator)
      : super(context, probabilityCalculator);

  @override
  CombatDistributions processCombat() {
    // Calculate volley hit distribution
    ProbabilityDistribution regularHitDistribution =
        calculateVolleyHitDistribution();

    // Calculate defense roll distribution for volley hits
    ProbabilityDistribution regularWoundDistribution =
        calculateWoundDistribution(
      regularHitDistribution,
      calculateEffectiveDefense(
        defender: context.defender,
        attacker: context.attacker,
        isVolley: true,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      ),
    );

    // Calculate resolve test distribution for volley wounds
    ProbabilityDistribution regularResolveDistribution =
        calculateResolveDistribution(
      regularWoundDistribution,
      calculateEffectiveResolve(
        defender: context.defender,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      ),
      context.defender.getIndomitable(),
    );

    // Calculate total damage from volley attack phase
    ProbabilityDistribution regularTotalDamageDistribution =
        calculateTotalDamageDistribution(
      regularWoundDistribution,
      regularResolveDistribution,
      calculateTotalVolleys(),
    );

    // For ranged combat, there's no impact phase, so total damage is just the regular damage
    return CombatDistributions(
      regularHitDistribution: regularHitDistribution,
      regularWoundDistribution: regularWoundDistribution,
      regularResolveDistribution: regularResolveDistribution,
      regularTotalDamageDistribution: regularTotalDamageDistribution,
      totalDamageDistribution: regularTotalDamageDistribution,
    );
  }

  /// Calculate hit distribution for volley attacks
  ProbabilityDistribution calculateVolleyHitDistribution() {
    // Calculate total volleys
    int totalVolleys = calculateTotalVolleys();

    // Get base hit target (volley value)
    int hitTarget = context.attacker.volley;

    // Apply Aimed modifier
    if (context.specialRulesInEffect['aimed'] == true ||
        context.attacker.hasSpecialRule('deadshots')) {
      hitTarget += 1;

      // If Aimed would raise Volley to 5+, use re-roll instead
      if (hitTarget >= 5) {
        hitTarget = context.attacker.volley; // Reset to base value
        context.specialRulesInEffect['aimedReroll'] = true;
      }
    }

    // Check for reroll abilities
    bool hasRerolls = context.specialRulesInEffect['aimedReroll'] == true;

    if (hasRerolls) {
      // For rerolls, we use a special calculation that accounts for rerolling failures
      return probabilityCalculator.calculateDistributionWithRerolls(
        dice: totalVolleys.toDouble(),
        target: hitTarget,
        rerollFails: true,
      );
    } else {
      // Standard binomial distribution
      return probabilityCalculator.calculateBinomialDistribution(
        dice: totalVolleys.toDouble(),
        targetValue: hitTarget,
      );
    }
  }

  /// Calculate total volleys for ranged attacks
  int calculateTotalVolleys() {
    if (!context.attacker.hasBarrage()) {
      return 0; // No barrage capability
    }

    int totalVolleys =
        context.attacker.getBarrage() * context.numAttackerStands;

    // Add character's barrage if present
    if (context.attackerCharacter != null &&
        context.attackerCharacter!.hasBarrage()) {
      totalVolleys += context.attackerCharacter!.getBarrage();
    }

    // Apply special rules for volleys
    if (context.attacker.hasSpecialRule('rapid volley') ||
        context.specialRulesInEffect['rapidVolley'] == true) {
      // Rapid volley grants an additional hit on rolls of 1
      // Simulate by increasing expected hits by 1/6 of the total shots
      double rapidVolleyBonus = totalVolleys * (1.0 / 6.0);
      totalVolleys += rapidVolleyBonus.round();
    }

    // Add +1 barrage if regiment has leader special rule
    if (context.attacker.hasSpecialRule('leader')) {
      totalVolleys += 1;
    }

    // Penalize for being outside effective range - halved shots
    if (!context.isWithinEffectiveRange) {
      totalVolleys = (totalVolleys * 0.5).round();
    }

    return totalVolleys;
  }
}
