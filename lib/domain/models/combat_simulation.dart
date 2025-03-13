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
  final bool isVolley; // New - is this a ranged attack?
  final bool
      isWithinEffectiveRange; // New - is the attack within effective range?
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
    this.isVolley = false,
    this.isWithinEffectiveRange = true,
    this.specialRulesInEffect = const {},
    required this.hitRoll,
    required this.defenseRoll,
    required this.resolveRoll,
  });

  // Helper methods to get meaningful results
  int getExpectedWounds() {
    return defenseRoll.failures + resolveRoll.failures;
  }

  int getExpectedStandsLost() {
    return getExpectedWounds() ~/ defender.wounds;
  }

  bool willLikelyBreak() {
    // A regiment is likely to break if it loses half or more of its stands
    return getExpectedStandsLost() >= (numDefenderStands / 2).ceil();
  }

  // Calculate probability of breaking (simplified)
  double getBreakProbability() {
    final standsRequired = (numDefenderStands / 2).ceil();
    final standsLost = getExpectedStandsLost();

    if (standsLost >= standsRequired) {
      return 100.0;
    } else {
      // This is simplified - real implementation would use probability distributions
      return (standsLost / standsRequired * 100).clamp(0.0, 100.0);
    }
  }
}
