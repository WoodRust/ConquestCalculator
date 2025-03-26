// lib/domain/models/combat_context.dart
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
  final bool isDefenderBroken; // Added this flag

  // Separate maps for attacker and defender special rules
  final Map<String, bool> attackerSpecialRulesInEffect;
  final Map<String, bool> defenderSpecialRulesInEffect;

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
    this.isDefenderBroken = false, // Initialize with default value
    Map<String, bool>? attackerSpecialRulesInEffect,
    Map<String, bool>? defenderSpecialRulesInEffect,
    required this.impactValues,
  })  : this.attackerSpecialRulesInEffect = attackerSpecialRulesInEffect != null
            ? Map<String, bool>.from(attackerSpecialRulesInEffect)
            : {},
        this.defenderSpecialRulesInEffect = defenderSpecialRulesInEffect != null
            ? Map<String, bool>.from(defenderSpecialRulesInEffect)
            : {};

  // Helper method to check if attacker has a specific rule
  bool attackerHasRule(String ruleName) {
    return attackerSpecialRulesInEffect[ruleName] == true;
  }

  // Helper method to check if defender has a specific rule
  bool defenderHasRule(String ruleName) {
    return defenderSpecialRulesInEffect[ruleName] == true;
  }
}
