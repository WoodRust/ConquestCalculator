import 'package:conquest_calculator/domain/models/regiment.dart';

/// Holds all the context information for a combat calculation
class CombatContext {
  final Regiment attacker;
  final int numAttackerStands;
  final Regiment? attackerCharacter;
  final Regiment defender;
  final int numDefenderStands;
  final Regiment? defenderCharacter;
  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final bool isVolley;
  final bool isWithinEffectiveRange;
  final Map<String, bool> specialRulesInEffect;
  final Map<String, int> impactValues;

  // Calculated values
  int effectiveAttackerStands = 0;
  int effectiveDefenderStands = 0;
  int standsToBreak = 0;

  CombatContext({
    required this.attacker,
    required this.numAttackerStands,
    this.attackerCharacter,
    required this.defender,
    required this.numDefenderStands,
    this.defenderCharacter,
    required this.isCharge,
    required this.isImpact,
    required this.isFlank,
    required this.isRear,
    required this.isVolley,
    required this.isWithinEffectiveRange,
    required this.specialRulesInEffect,
    required this.impactValues,
  });
}
