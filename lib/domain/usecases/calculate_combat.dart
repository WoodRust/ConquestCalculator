// lib/domain/usecases/calculate_combat.dart
import 'package:conquest_calculator/domain/models/combat_context.dart';
import 'package:conquest_calculator/domain/models/combat_distributions.dart';
import 'package:conquest_calculator/domain/usecases/processors/combat_processor.dart';
import 'package:conquest_calculator/domain/usecases/processors/melee_combat_processor.dart';
import 'package:conquest_calculator/domain/usecases/processors/ranged_combat_processor.dart';
import 'package:conquest_calculator/domain/utils/probability_calculator.dart';

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
}
