// lib/domain/combat/models/combat_result.dart
import 'package:conquest_calculator/domain/models/combat_simulation.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/combat/models/phase_result.dart';
import 'package:conquest_calculator/domain/combat/models/combat_input.dart';

/// Represents the complete results of a combat calculation
class CombatResult {
  /// The original input that produced this result
  final CombatInput input;

  /// Results for impact phase (if applicable)
  final PhaseResult? impactPhase;

  /// Results for melee/ranged attack phase
  final PhaseResult attackPhase;

  /// Results for defense phase
  final PhaseResult defensePhase;

  /// Results for morale phase
  final PhaseResult moralePhase;

  /// The combined probability distribution of all damage
  final ProbabilityDistribution totalDamageDistribution;

  /// Number of stands required to break the defender
  final int standsToBreak;

  /// Probability of breaking the defender (0.0 to 1.0)
  final double breakingProbability;

  const CombatResult({
    required this.input,
    this.impactPhase,
    required this.attackPhase,
    required this.defensePhase,
    required this.moralePhase,
    required this.totalDamageDistribution,
    required this.standsToBreak,
    required this.breakingProbability,
  });

  /// Converts this result to the legacy CombatSimulation format for backward compatibility
  CombatSimulation toCombatSimulation() {
    // Convert to the original PhaseResult to DiceResult
    final hitRoll = DiceResult(
      successes: attackPhase.expectedSuccesses.round(),
      failures: attackPhase.expectedFailures.round(),
      total: attackPhase.diceCount,
    );

    final defenseRoll = DiceResult(
      successes:
          (attackPhase.expectedSuccesses - defensePhase.expectedSuccesses)
              .round(),
      failures: defensePhase.expectedSuccesses.round(),
      total: attackPhase.expectedSuccesses.round(),
    );

    final resolveRoll = DiceResult(
      successes:
          (defensePhase.expectedSuccesses - moralePhase.expectedSuccesses)
              .round(),
      failures: moralePhase.expectedSuccesses.round(),
      total: defensePhase.expectedSuccesses.round(),
    );

    return CombatSimulation(
      attacker: input.attacker,
      numAttackerStands: input.effectiveAttackerStands,
      defender: input.defender,
      numDefenderStands: input.effectiveDefenderStands,
      isCharge: input.isCharge,
      isImpact: input.isImpact,
      isFlank: input.isFlank,
      isRear: input.isRear,
      isVolley: input.isVolley,
      isWithinEffectiveRange: input.isWithinEffectiveRange,
      specialRulesInEffect: input.specialRulesInEffect,
      hitRoll: hitRoll,
      defenseRoll: defenseRoll,
      resolveRoll: resolveRoll,
      hitDistribution: attackPhase.distribution,
      woundDistribution: defensePhase.distribution,
      resolveDistribution: moralePhase.distribution,
      totalDamageDistribution: totalDamageDistribution,
      standsToBreak: standsToBreak,
    );
  }

  /// Gets the expected total wounds
  double get expectedWounds => totalDamageDistribution.mean;

  /// Gets the expected number of stands lost
  double get expectedStandsLost => expectedWounds / input.defender.wounds;
}
