import 'package:conquest_calculator/domain/models/combat_distributions.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'package:conquest_calculator/domain/usecases/processors/combat_processor.dart';

/// Processor for melee combat
class MeleeCombatProcessor extends CombatProcessor {
  MeleeCombatProcessor(super.context, super.probabilityCalculator);

  @override
  CombatDistributions processCombat() {
    // Variables to store distributions
    ProbabilityDistribution? impactHitDistribution;
    ProbabilityDistribution? impactWoundDistribution;
    ProbabilityDistribution? impactResolveDistribution;
    ProbabilityDistribution? impactTotalDamageDistribution;

    // Process impact phase if applicable
    if (context.isImpact && context.attacker.hasImpact()) {
      // Handle impact attack phase
      impactHitDistribution = calculateImpactHitDistribution();

      // Calculate defense roll distribution for impact hits
      impactWoundDistribution = calculateWoundDistribution(
        impactHitDistribution,
        calculateEffectiveDefense(
          defender: context.defender,
          attacker: context.attacker,
          isImpact: true,
          isFlank: context.isFlank,
          isRear: context.isRear,
          specialRulesInEffect: context.specialRulesInEffect,
        ),
      );

      // Calculate resolve test distribution for impact wounds
      impactResolveDistribution = calculateResolveDistribution(
        impactWoundDistribution,
        calculateEffectiveResolve(
          defender: context.defender,
          isFlank: context.isFlank,
          isRear: context.isRear,
          specialRulesInEffect: context.specialRulesInEffect,
        ),
        context.defender.getIndomitable(),
      );

      // Calculate total damage from impact phase
      impactTotalDamageDistribution = calculateTotalDamageDistribution(
        impactWoundDistribution,
        impactResolveDistribution,
        calculateTotalImpacts(),
      );
    }

    // Process regular melee phase
    ProbabilityDistribution regularHitDistribution =
        calculateRegularHitDistribution();

    // Calculate defense roll distribution for regular hits
    ProbabilityDistribution regularWoundDistribution =
        calculateWoundDistribution(
      regularHitDistribution,
      calculateEffectiveDefense(
        defender: context.defender,
        attacker: context.attacker,
        isImpact: false,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      ),
    );

    // Calculate resolve test distribution for regular wounds
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

    // Calculate total damage from regular attack phase
    ProbabilityDistribution regularTotalDamageDistribution =
        calculateTotalDamageDistribution(
      regularWoundDistribution,
      regularResolveDistribution,
      calculateTotalAttacks(),
    );

    // Combine both phases for the total damage distribution
    ProbabilityDistribution totalDamageDistribution;
    if (impactTotalDamageDistribution != null) {
      // Combine impact and regular damage distributions
      totalDamageDistribution =
          probabilityCalculator.combineProbabilityDistributions(
        impactTotalDamageDistribution,
        regularTotalDamageDistribution,
      );
    } else {
      // Just use regular damage if no impact phase
      totalDamageDistribution = regularTotalDamageDistribution;
    }

    return CombatDistributions(
      impactHitDistribution: impactHitDistribution,
      impactWoundDistribution: impactWoundDistribution,
      impactResolveDistribution: impactResolveDistribution,
      impactTotalDamageDistribution: impactTotalDamageDistribution,
      regularHitDistribution: regularHitDistribution,
      regularWoundDistribution: regularWoundDistribution,
      regularResolveDistribution: regularResolveDistribution,
      regularTotalDamageDistribution: regularTotalDamageDistribution,
      totalDamageDistribution: totalDamageDistribution,
    );
  }

  /// Calculate the hit distribution for impact attacks
  ProbabilityDistribution calculateImpactHitDistribution() {
    // Get total impact attacks
    int totalImpacts = calculateTotalImpacts();

    // Get base hit target (clash value for impacts)
    int hitTarget = context.attacker.clash;

    // Apply Glorious Charge bonus when charging
    if (context.isCharge &&
        context.attacker.hasSpecialRule('glorious charge')) {
      hitTarget += 1;
    }

    // Calculate binomial distribution for hits
    return probabilityCalculator.calculateBinomialDistribution(
      dice: totalImpacts.toDouble(),
      targetValue: hitTarget,
    );
  }

  /// Calculate total impact attacks
  int calculateTotalImpacts() {
    // Get the impact value
    int impactValue = context.attacker.getImpact();

    // Calculate total impact attacks: impact value × number of stands
    int totalImpacts = impactValue * context.numAttackerStands;

    // Add character impact attacks if present
    if (context.attackerCharacter != null &&
        context.attackerCharacter!.hasImpact()) {
      totalImpacts += context.attackerCharacter!.getImpact();
    }

    return totalImpacts;
  }

  /// Calculate hit distribution for regular melee attacks
  ProbabilityDistribution calculateRegularHitDistribution() {
    // Calculate total attacks
    int totalAttacks = calculateTotalAttacks();

    // Get base hit target (clash value)
    int hitTarget = context.attacker.clash;

    // Apply Inspired bonus to Clash
    if (context.attackerHasRule('inspired')) {
      hitTarget += 1;

      // If Inspired would raise Clash to 5+, use re-roll instead
      if (hitTarget > 5) {
        hitTarget = context.attacker.clash; // Reset to base value
        context.attackerSpecialRulesInEffect['inspiredReroll'] = true;
      }
    }

    // Apply Shock bonus when charging
    if (context.isCharge && context.attacker.hasSpecialRule('shock')) {
      hitTarget += 1;
    }

    // Check for reroll abilities
    bool hasRerolls = context.attackerHasRule('flurry') ||
        context.attackerHasRule('inspiredReroll') ||
        (context.attacker.hasSpecialRule('opportunists') &&
            (context.isFlank || context.isRear));

    if (hasRerolls) {
      // For rerolls, we use a special calculation that accounts for rerolling failures
      return probabilityCalculator.calculateDistributionWithRerolls(
        dice: totalAttacks.toDouble(),
        target: hitTarget,
        rerollFails: true,
      );
    } else {
      // Standard binomial distribution
      return probabilityCalculator.calculateBinomialDistribution(
        dice: totalAttacks.toDouble(),
        targetValue: hitTarget,
      );
    }
  }

  /// Calculate total regular attacks
  int calculateTotalAttacks() {
    // Add character attacks
    int characterAttacks = 0;
    if (context.attackerCharacter != null) {
      characterAttacks = context.attackerCharacter!.attacks;
    }

    // Calculate support attacks from unengaged stands
    // Simplified model: we'll assume half stands are engaged, half provide support
    int engagedStands = context.numAttackerStands;
    int supportingStands = context.numAttackerStands - engagedStands;

    // Get support value from Regiment's support field
    int supportValue = context.attacker.getSupport();

    // If no support value is defined, default to 1
    if (supportValue == 0) {
      supportValue = 1;
    }

    int supportAttacks = supportingStands * supportValue;

    // Add engaged attacks and support attacks
    int totalAttacks = (engagedStands * context.attacker.attacks) +
        supportAttacks +
        characterAttacks;

    // Add +1 attack if regiment has leader special rule
    if (context.attacker.hasSpecialRule('leader')) {
      totalAttacks += 1;
    }

    return totalAttacks;
  }
}
