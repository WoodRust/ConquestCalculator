// lib/domain/models/combat_simulation.dart

import 'package:conquest_calculator/domain/models/regiment.dart';

class DiceResult {
  final int successes;
  final int failures;
  final int total;

  DiceResult({
    required this.successes,
    required this.failures,
    required this.total,
  });

  factory DiceResult.fromRoll({required int dice, required int target}) {
    // Calculate expected successes for a given number of dice and target
    final double successRate = target / 6.0;
    final int expectedSuccesses = (dice * successRate).round();
    return DiceResult(
      successes: expectedSuccesses,
      failures: dice - expectedSuccesses,
      total: dice,
    );
  }
}

class CombatSimulation {
  // Attacker
  final Regiment attacker;
  final int numAttackerStands;

  // Defender
  final Regiment defender;
  final int numDefenderStands;

  // Modifiers
  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final Map<String, bool> specialRulesInEffect;

  // Results
  final DiceResult hitRoll;
  final DiceResult defenseRoll;
  final DiceResult resolveRoll;

  CombatSimulation({
    required this.attacker,
    required this.numAttackerStands,
    required this.defender,
    required this.numDefenderStands,
    this.isCharge = false,
    this.isImpact = false,
    this.isFlank = false,
    this.isRear = false,
    this.specialRulesInEffect = const {},
    required this.hitRoll,
    required this.defenseRoll,
    required this.resolveRoll,
  });
}
