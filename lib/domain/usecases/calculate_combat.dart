// lib/domain/usecases/calculate_combat.dart
import 'package:conquest_calculator/domain/models/combat_context.dart';
import 'package:conquest_calculator/domain/models/combat_distributions.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'package:conquest_calculator/domain/usecases/processors/combat_processor.dart';
import 'package:conquest_calculator/domain/usecases/processors/melee_combat_processor.dart';
import 'package:conquest_calculator/domain/usecases/processors/ranged_combat_processor.dart';
import 'package:conquest_calculator/domain/utils/probability_calculator.dart';
import 'package:conquest_calculator/presentation/providers/combat/models/combat_state.dart';
import 'dart:math' as math;

import '../models/regiment.dart';
import '../models/combat_simulation.dart';

/// Main class for calculating combat results
class CalculateCombat {
  final ProbabilityCalculator _probabilityCalculator = ProbabilityCalculator();

  /// Calculates the expected result of a combat between two regiments
  CombatSimulation calculateExpectedResult({
    required Regiment attacker,
    required int numAttackerStands,
    Regiment? attackerCharacter,
    required Regiment defender,
    required int numDefenderStands,
    Regiment? defenderCharacter,
    bool isCharge = false,
    bool isImpact = false,
    bool isFlank = false,
    bool isRear = false,
    bool isVolley = false,
    bool isWithinEffectiveRange = false,
    Map<String, bool> specialRulesInEffect = const {},
    Map<String, int> impactValues = const {},
  }) {
    // Create combat context with all parameters
    final context = CombatContext(
      attacker: attacker,
      numAttackerStands: numAttackerStands,
      attackerCharacter: attackerCharacter,
      defender: defender,
      numDefenderStands: numDefenderStands,
      defenderCharacter: defenderCharacter,
      isCharge: isCharge,
      isImpact: isImpact,
      isFlank: isFlank,
      isRear: isRear,
      isVolley: isVolley,
      isWithinEffectiveRange: isWithinEffectiveRange,
      specialRulesInEffect: Map<String, bool>.from(specialRulesInEffect),
      impactValues: Map<String, int>.from(impactValues),
    );

    // Calculate effective stand counts with characters
    context.effectiveAttackerStands =
        context.numAttackerStands + (context.attackerCharacter != null ? 1 : 0);
    context.effectiveDefenderStands =
        context.numDefenderStands + (context.defenderCharacter != null ? 1 : 0);

    // Calculate breaking threshold based on effective stand count
    context.standsToBreak = (context.effectiveDefenderStands / 2).ceil();

    // Create combat processor based on combat type
    final CombatProcessor processor = _createCombatProcessor(context);

    // Process the combat and get distributions
    final CombatDistributions distributions = processor.processCombat();

    // Create DiceResult instances for backward compatibility
    DiceResult hitRoll = DiceResult(
      successes: distributions.regularHitDistribution.mean.round(),
      failures: distributions.regularHitDistribution.diceCount -
          distributions.regularHitDistribution.mean.round(),
      total: distributions.regularHitDistribution.diceCount,
    );

    DiceResult defenseRoll = DiceResult(
      successes: (distributions.regularHitDistribution.mean -
              distributions.regularWoundDistribution.mean)
          .round(),
      failures: distributions.regularWoundDistribution.mean.round(),
      total: distributions.regularHitDistribution.mean.round(),
    );

    DiceResult resolveRoll = DiceResult(
      successes: (distributions.regularWoundDistribution.mean -
              distributions.regularResolveDistribution.mean)
          .round(),
      failures: distributions.regularResolveDistribution.mean.round(),
      total: distributions.regularWoundDistribution.mean.round(),
    );

    // Return the complete combat simulation
    return CombatSimulation(
      attacker: context.attacker,
      numAttackerStands: context.effectiveAttackerStands,
      defender: context.defender,
      numDefenderStands: context.effectiveDefenderStands,
      isCharge: context.isCharge,
      isImpact: context.isImpact,
      isFlank: context.isFlank,
      isRear: context.isRear,
      isVolley: context.isVolley,
      isWithinEffectiveRange: context.isWithinEffectiveRange,
      specialRulesInEffect: context.specialRulesInEffect,
      // For backward compatibility
      hitRoll: hitRoll,
      defenseRoll: defenseRoll,
      resolveRoll: resolveRoll,
      // Enhanced distributions
      hitDistribution: distributions.regularHitDistribution,
      woundDistribution: distributions.regularWoundDistribution,
      resolveDistribution: distributions.regularResolveDistribution,
      totalDamageDistribution: distributions.totalDamageDistribution,
      standsToBreak: context.standsToBreak,
    );
  }

  /// Creates the appropriate combat processor based on the combat context
  CombatProcessor _createCombatProcessor(CombatContext context) {
    if (context.isVolley) {
      return RangedCombatProcessor(context, _probabilityCalculator);
    } else {
      return MeleeCombatProcessor(context, _probabilityCalculator);
    }
  }

  /// Create a CombatContext from CombatState for utility calculations
  CombatContext _createContextFromState(CombatState state) {
    if (state.attacker == null || state.defender == null) {
      throw ArgumentError("Attacker and defender must be set in CombatState");
    }

    return CombatContext(
      attacker: state.attacker!,
      numAttackerStands: state.numAttackerStands,
      attackerCharacter: state.attackerCharacter,
      defender: state.defender!,
      numDefenderStands: state.numDefenderStands,
      defenderCharacter: state.defenderCharacter,
      isCharge: state.isCharge,
      isImpact: state.isImpact,
      isFlank: state.isFlank,
      isRear: state.isRear,
      isVolley: state.isVolley,
      isWithinEffectiveRange: state.isWithinEffectiveRange,
      specialRulesInEffect: Map<String, bool>.from(state.specialRulesInEffect),
      impactValues: Map<String, int>.from(state.specialRuleValues),
    );
  }

  /// Utility methods to match those from combat_calculator_utils.dart

  /// Calculate total impacts to determine impact attack count
  int calculateTotalImpacts(CombatState state) {
    if (state.attacker == null || !state.isImpact) return 0;

    try {
      final context = _createContextFromState(state);
      final processor = MeleeCombatProcessor(context, _probabilityCalculator);
      return processor.calculateTotalImpacts();
    } catch (e) {
      // Fallback implementation if context creation fails
      int impactValue = state.attacker!.getImpact();
      if (impactValue == 0) {
        impactValue = state.specialRuleValues['impactValue'] ?? 0;
      }

      int totalImpacts = impactValue * state.numAttackerStands;

      if (state.attackerCharacter != null &&
          state.attackerCharacter!.hasImpact()) {
        totalImpacts += state.attackerCharacter!.getImpact();
      }

      return totalImpacts;
    }
  }

  /// Calculate expected hits from impact attacks
  double calculateExpectedImpactHits(CombatState state) {
    if (state.attacker == null || !state.isImpact) return 0.0;

    try {
      final context = _createContextFromState(state);
      final processor = MeleeCombatProcessor(context, _probabilityCalculator);
      final distribution = processor.calculateImpactHitDistribution();
      return distribution.mean;
    } catch (e) {
      // Fallback implementation if context creation fails
      int totalImpacts = calculateTotalImpacts(state);
      int hitTarget = state.attacker!.clash;

      if (state.isCharge && state.attacker!.hasSpecialRule('glorious charge')) {
        hitTarget += 1;
      }

      double hitProbability = hitTarget / 6.0;
      return totalImpacts * hitProbability;
    }
  }

  /// Calculate expected wounds from impact attacks (including morale wounds)
  double calculateExpectedImpactWounds(CombatState state) {
    if (state.attacker == null || !state.isImpact || state.defender == null) {
      return 0.0;
    }

    try {
      final context = _createContextFromState(state);
      final processor = MeleeCombatProcessor(context, _probabilityCalculator);

      // Use the processor to calculate the impact hit distribution
      final impactHitDistribution = processor.calculateImpactHitDistribution();

      // Calculate defense roll distribution for impact hits
      final int defenseTarget = processor.calculateEffectiveDefense(
        defender: context.defender,
        attacker: context.attacker,
        isImpact: true,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      );

      final impactWoundDistribution = processor.calculateWoundDistribution(
        impactHitDistribution,
        defenseTarget,
      );

      // Calculate resolve test distribution for impact wounds
      final int resolveTarget = processor.calculateEffectiveResolve(
        defender: context.defender,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      );

      final impactResolveDistribution = processor.calculateResolveDistribution(
        impactWoundDistribution,
        resolveTarget,
        context.defender.getIndomitable(),
      );

      // Return the sum of means from both distributions
      return impactWoundDistribution.mean + impactResolveDistribution.mean;
    } catch (e) {
      // Fallback implementation if context creation fails
      double expectedHits = calculateExpectedImpactHits(state);

      int defenseTarget =
          math.max(state.defender!.defense, state.defender!.evasion);

      bool hasShield = state.defender!.shield ||
          state.defender!.hasSpecialRule('shield') ||
          state.specialRulesInEffect['shield'] == true;

      if (!state.isFlank && !state.isRear && hasShield) {
        defenseTarget += 1;
      }

      if (state.attacker!.getBrutalImpact() > 0 ||
          state.specialRulesInEffect['brutalImpact'] == true) {
        int brutalImpactValue = state.specialRuleValues['brutalImpactValue'] ??
            state.attacker!.getBrutalImpact();
        defenseTarget = math.max(defenseTarget - brutalImpactValue, 0);
      }

      double defenseSuccessRate = defenseTarget / 6.0;
      double expectedDirectWounds = expectedHits * (1 - defenseSuccessRate);

      int resolveTarget = state.defender!.getResolve();
      double moraleFailRate = (6 - resolveTarget) / 6.0;
      double expectedMoraleWounds = expectedDirectWounds * moraleFailRate;

      return expectedDirectWounds + expectedMoraleWounds;
    }
  }

  /// Calculate total attacks to determine realistic maximum wounds
  int calculateTotalAttacks(CombatState state) {
    if (state.attacker == null) return 0;

    try {
      final context = _createContextFromState(state);
      final processor = state.isVolley
          ? RangedCombatProcessor(context, _probabilityCalculator)
          : MeleeCombatProcessor(context, _probabilityCalculator);

      if (state.isVolley) {
        return (processor as RangedCombatProcessor).calculateTotalVolleys();
      } else {
        return (processor as MeleeCombatProcessor).calculateTotalAttacks();
      }
    } catch (e) {
      // Fallback implementation if context creation fails
      if (state.attacker!.isCharacter()) {
        return state.attacker!.attacks;
      }

      int baseAttacks = state.attacker!.attacks * state.numAttackerStands;

      if (state.attackerCharacter != null) {
        baseAttacks += state.attackerCharacter!.attacks;
      }

      if (state.attacker!.hasSpecialRule('leader')) {
        baseAttacks += 1;
      }

      return baseAttacks;
    }
  }

  /// Calculate the expected number of hits properly accounting for rerolls
  double calculateExpectedHits(CombatState state) {
    if (state.attacker == null) return 0.0;

    try {
      final context = _createContextFromState(state);
      final processor = state.isVolley
          ? RangedCombatProcessor(context, _probabilityCalculator)
          : MeleeCombatProcessor(context, _probabilityCalculator);

      if (state.isVolley) {
        final distribution = (processor as RangedCombatProcessor)
            .calculateVolleyHitDistribution();
        return distribution.mean;
      } else {
        final distribution = (processor as MeleeCombatProcessor)
            .calculateRegularHitDistribution();
        return distribution.mean;
      }
    } catch (e) {
      // Fallback implementation if context creation fails
      int totalAttacks = calculateTotalAttacks(state);
      int hitTarget =
          state.isVolley ? state.attacker!.volley : state.attacker!.clash;

      if (state.specialRulesInEffect['inspired'] == true && !state.isVolley) {
        hitTarget += 1;
        if (hitTarget >= 5) {
          hitTarget = state.attacker!.clash;
        }
      }

      if (state.isCharge &&
          state.attacker!.hasSpecialRule('shock') &&
          !state.isVolley) {
        hitTarget += 1;
      }

      double hitProbability = hitTarget / 6.0;

      bool hasRerolls = state.specialRulesInEffect['flurry'] == true ||
          state.specialRulesInEffect['aimedReroll'] == true ||
          state.specialRulesInEffect['inspiredReroll'] == true ||
          (state.attacker!.hasSpecialRule('opportunists') &&
              (state.isFlank || state.isRear) &&
              !state.isImpact);

      double adjustedHitProbability = hitProbability;
      if (hasRerolls) {
        adjustedHitProbability =
            hitProbability + ((1 - hitProbability) * hitProbability);
      }

      return totalAttacks * adjustedHitProbability;
    }
  }

  /// Calculate expected wounds from regular attacks (including morale wounds)
  double calculateExpectedWounds(CombatState state) {
    if (state.attacker == null || state.defender == null) return 0.0;

    try {
      final context = _createContextFromState(state);
      final processor = state.isVolley
          ? RangedCombatProcessor(context, _probabilityCalculator)
          : MeleeCombatProcessor(context, _probabilityCalculator);

      // Use the processor to calculate the hit distribution
      ProbabilityDistribution hitDistribution;
      if (state.isVolley) {
        hitDistribution = (processor as RangedCombatProcessor)
            .calculateVolleyHitDistribution();
      } else {
        hitDistribution = (processor as MeleeCombatProcessor)
            .calculateRegularHitDistribution();
      }

      // Calculate defense roll distribution
      final int defenseTarget = processor.calculateEffectiveDefense(
        defender: context.defender,
        attacker: context.attacker,
        isVolley: state.isVolley,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      );

      final woundDistribution = processor.calculateWoundDistribution(
        hitDistribution,
        defenseTarget,
      );

      // Calculate resolve test distribution
      final int resolveTarget = processor.calculateEffectiveResolve(
        defender: context.defender,
        isFlank: context.isFlank,
        isRear: context.isRear,
        specialRulesInEffect: context.specialRulesInEffect,
      );

      final resolveDistribution = processor.calculateResolveDistribution(
        woundDistribution,
        resolveTarget,
        context.defender.getIndomitable(),
      );

      // Return the sum of means from both distributions
      return woundDistribution.mean + resolveDistribution.mean;
    } catch (e) {
      // Fallback implementation if context creation fails
      double expectedHits = calculateExpectedHits(state);

      int defenseTarget =
          math.max(state.defender!.defense, state.defender!.evasion);

      bool hasShield = state.defender!.shield ||
          state.defender!.hasSpecialRule('shield') ||
          state.specialRulesInEffect['shield'] == true;

      if (!state.isFlank && !state.isRear && hasShield) {
        defenseTarget += 1;
      }

      if (state.isVolley && state.attacker!.hasArmorPiercing()) {
        defenseTarget = math.max(
            defenseTarget - state.attacker!.getArmorPiercingValue(), 0);
      } else if (!state.isVolley &&
          state.specialRulesInEffect['armorPiercing'] == true) {
        int armorPiercingValue =
            state.specialRuleValues['armorPiercingValue'] ??
                state.attacker!.getArmorPiercingValue();
        defenseTarget = math.max(defenseTarget - armorPiercingValue, 0);
      } else if (!state.isVolley &&
          (state.attacker!.getCleave() > 0 ||
              state.specialRulesInEffect['cleave'] == true)) {
        int cleaveValue = state.specialRuleValues['cleaveValue'] ??
            state.attacker!.getCleave();
        defenseTarget = math.max(defenseTarget - cleaveValue, 0);
      }

      double defenseSuccessRate = defenseTarget / 6.0;
      double expectedDirectWounds = expectedHits * (1 - defenseSuccessRate);

      int resolveTarget = state.defender!.getResolve();

      bool hasAnimateVessel = state.defender!.hasSpecialRule('animate vessel');
      if (hasAnimateVessel) {
        return expectedDirectWounds;
      }

      if (!state.isVolley &&
          state.attacker!.getTerrifying() > 0 &&
          !state.defender!.hasSpecialRule('fearless') &&
          !state.defender!.hasSpecialRule('bravery')) {
        resolveTarget =
            math.max(resolveTarget - state.attacker!.getTerrifying(), 0);
      }

      if (state.isFlank || state.isRear) {
        resolveTarget = math.max(resolveTarget - 1, 0);
      }

      int indomitableValue = state.defender!.getIndomitable();
      if (indomitableValue > 0) {
        expectedDirectWounds =
            math.max(0, expectedDirectWounds - indomitableValue);
      }

      double moraleFailRate = (6 - resolveTarget) / 6.0;
      double expectedMoraleWounds = expectedDirectWounds * moraleFailRate;

      return expectedDirectWounds + expectedMoraleWounds;
    }
  }
}
