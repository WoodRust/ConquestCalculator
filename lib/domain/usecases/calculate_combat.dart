// lib/domain/usecases/calculate_combat.dart
import 'package:conquest_calculator/domain/models/combat_context.dart';
import 'package:conquest_calculator/domain/models/combat_distributions.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'package:conquest_calculator/domain/usecases/processors/combat_processor.dart';
import 'package:conquest_calculator/domain/usecases/processors/melee_combat_processor.dart';
import 'package:conquest_calculator/domain/usecases/processors/ranged_combat_processor.dart';
import 'package:conquest_calculator/domain/utils/probability_calculator.dart';
import 'package:conquest_calculator/presentation/providers/combat/models/combat_state.dart';

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
    bool isDefenderBroken = false, // Added this parameter
    Map<String, bool>? attackerSpecialRulesInEffect,
    Map<String, bool>? defenderSpecialRulesInEffect,
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
      isDefenderBroken: isDefenderBroken, // Pass the parameter to context
      attackerSpecialRulesInEffect: attackerSpecialRulesInEffect,
      defenderSpecialRulesInEffect: defenderSpecialRulesInEffect,
      impactValues: impactValues,
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
      successes: distributions.regularHitDistribution.mean,
      failures: distributions.regularHitDistribution.diceCount -
          distributions.regularHitDistribution.mean,
      total: distributions.regularHitDistribution.diceCount,
    );

    DiceResult defenseRoll = DiceResult(
      successes: (distributions.regularHitDistribution.mean -
          distributions.regularWoundDistribution.mean),
      failures: distributions.regularWoundDistribution.mean,
      total: distributions.regularHitDistribution.mean,
    );

    DiceResult resolveRoll = DiceResult(
      successes: (distributions.regularWoundDistribution.mean -
          distributions.regularResolveDistribution.mean),
      failures: distributions.regularResolveDistribution.mean,
      total: distributions.regularWoundDistribution.mean,
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
      //specialRulesInEffect: context.specialRulesInEffect,
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

  /// Create a robust CombatContext from CombatState for utility calculations
  CombatContext _createContextFromState(CombatState state) {
    if (state.attacker == null || state.defender == null) {
      throw ArgumentError("Attacker and defender must be set in CombatState");
    }

    // Calculate effective stand counts
    final effectiveAttackerStands =
        state.numAttackerStands + (state.attackerCharacter != null ? 1 : 0);
    final effectiveDefenderStands =
        state.numDefenderStands + (state.defenderCharacter != null ? 1 : 0);

    // Calculate breaking threshold
    final standsToBreak = (effectiveDefenderStands / 2).ceil();

    // Create context with separated special rules maps
    CombatContext context = CombatContext(
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
      isDefenderBroken: state.isDefenderBroken, // Add this line
      attackerSpecialRulesInEffect:
          Map<String, bool>.from(state.attackerSpecialRulesInEffect),
      defenderSpecialRulesInEffect:
          Map<String, bool>.from(state.defenderSpecialRulesInEffect),
      impactValues: Map<String, int>.from(state.specialRuleValues),
    );

    // Set calculated properties
    context.effectiveAttackerStands = effectiveAttackerStands;
    context.effectiveDefenderStands = effectiveDefenderStands;
    context.standsToBreak = standsToBreak;

    return context;
  }

  /// Utility methods that rely solely on the processor approach

  /// Calculate total impacts to determine impact attack count
  int calculateTotalImpacts(CombatState state) {
    if (state.attacker == null || !state.isImpact) return 0;

    try {
      final context = _createContextFromState(state);
      final processor = MeleeCombatProcessor(context, _probabilityCalculator);
      return processor.calculateTotalImpacts();
    } catch (e) {
      // Return a sensible default rather than duplicating logic
      print('Error calculating total impacts: $e');
      return 0;
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
      // Return a sensible default rather than duplicating logic
      print('Error calculating expected impact hits: $e');
      return 0.0;
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

      // Calculate impact hit distribution
      final impactHitDistribution = processor.calculateImpactHitDistribution();

      // Calculate defense roll distribution for impact hits
      final int defenseTarget = processor.calculateEffectiveDefense(
        defender: context.defender,
        attacker: context.attacker,
        isImpact: true,
        isFlank: context.isFlank,
        isRear: context.isRear,
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
      );

      final impactResolveDistribution = processor.calculateResolveDistribution(
        impactWoundDistribution,
        resolveTarget,
        context.defender.getIndomitable(),
      );

      // Return the sum of means from both distributions
      return impactWoundDistribution.mean + impactResolveDistribution.mean;
    } catch (e) {
      // Return a sensible default rather than duplicating logic
      print('Error calculating expected impact wounds: $e');
      return 0.0;
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
      // Return a sensible default rather than duplicating logic
      print('Error calculating total attacks: $e');
      return 0;
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
      // Return a sensible default rather than duplicating logic
      print('Error calculating expected hits: $e');
      return 0.0;
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

      // Calculate the hit distribution
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
      );

      final resolveDistribution = processor.calculateResolveDistribution(
        woundDistribution,
        resolveTarget,
        context.defender.getIndomitable(),
      );
      print("===== Calculate Expected Wounds =====");
      print("Expected Hits: ${hitDistribution.mean}");
      print("Defense Target: $defenseTarget");
      print("Expected Direct Wounds: ${woundDistribution.mean}");
      print("Resolve Target: $resolveTarget");
      print("Expected Morale Wounds: ${resolveDistribution.mean}");
      print(
          "Total Expected Wounds: ${woundDistribution.mean + resolveDistribution.mean}");
      // Return the sum of means from both distributions
      return woundDistribution.mean + resolveDistribution.mean;
    } catch (e) {
      // Return a sensible default rather than duplicating logic
      print('Error calculating expected wounds: $e');
      return 0.0;
    }
  }
}
