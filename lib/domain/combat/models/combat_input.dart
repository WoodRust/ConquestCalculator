// lib/domain/combat/models/combat_input.dart
import 'package:conquest_calculator/domain/models/regiment.dart';

/// A unified model representing all inputs required for combat calculations
class CombatInput {
  /// Attacking regiment
  final Regiment attacker;

  /// Number of stands in the attacking regiment
  final int attackerStands;

  /// Character attached to attacking regiment (if any)
  final Regiment? attackerCharacter;

  /// Defending regiment
  final Regiment defender;

  /// Number of stands in the defending regiment
  final int defenderStands;

  /// Character attached to defending regiment (if any)
  final Regiment? defenderCharacter;

  // Combat modifiers
  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final bool isVolley;
  final bool isWithinEffectiveRange;

  /// Map of special rules that are in effect (name -> active)
  final Map<String, bool> specialRulesInEffect;

  /// Map of special rule numeric values (name -> value)
  final Map<String, int> specialRuleValues;

  const CombatInput({
    required this.attacker,
    required this.attackerStands,
    this.attackerCharacter,
    required this.defender,
    required this.defenderStands,
    this.defenderCharacter,
    this.isCharge = false,
    this.isImpact = false,
    this.isFlank = false,
    this.isRear = false,
    this.isVolley = false,
    this.isWithinEffectiveRange = false,
    this.specialRulesInEffect = const {},
    this.specialRuleValues = const {},
  });

  /// Returns true if the attacker has the specified special rule in effect
  bool hasAttackerRule(String rule) {
    return specialRulesInEffect[rule] == true || attacker.hasSpecialRule(rule);
  }

  /// Returns true if the defender has the specified special rule in effect
  bool hasDefenderRule(String rule) {
    return specialRulesInEffect[rule] == true || defender.hasSpecialRule(rule);
  }

  /// Returns the value for a special rule, or 0 if not present
  int getSpecialRuleValue(String rule) {
    return specialRuleValues[rule] ?? 0;
  }

  /// Creates a copy of this input with some fields replaced
  CombatInput copyWith({
    Regiment? attacker,
    int? attackerStands,
    Regiment? attackerCharacter,
    bool clearAttackerCharacter = false,
    Regiment? defender,
    int? defenderStands,
    Regiment? defenderCharacter,
    bool clearDefenderCharacter = false,
    bool? isCharge,
    bool? isImpact,
    bool? isFlank,
    bool? isRear,
    bool? isVolley,
    bool? isWithinEffectiveRange,
    Map<String, bool>? specialRulesInEffect,
    Map<String, int>? specialRuleValues,
  }) {
    return CombatInput(
      attacker: attacker ?? this.attacker,
      attackerStands: attackerStands ?? this.attackerStands,
      attackerCharacter: clearAttackerCharacter
          ? null
          : (attackerCharacter ?? this.attackerCharacter),
      defender: defender ?? this.defender,
      defenderStands: defenderStands ?? this.defenderStands,
      defenderCharacter: clearDefenderCharacter
          ? null
          : (defenderCharacter ?? this.defenderCharacter),
      isCharge: isCharge ?? this.isCharge,
      isImpact: isImpact ?? this.isImpact,
      isFlank: isFlank ?? this.isFlank,
      isRear: isRear ?? this.isRear,
      isVolley: isVolley ?? this.isVolley,
      isWithinEffectiveRange:
          isWithinEffectiveRange ?? this.isWithinEffectiveRange,
      specialRulesInEffect: specialRulesInEffect ?? this.specialRulesInEffect,
      specialRuleValues: specialRuleValues ?? this.specialRuleValues,
    );
  }

  /// Helper method to calculate the effective attacker stands count
  /// (includes character if present)
  int get effectiveAttackerStands =>
      attackerStands + (attackerCharacter != null ? 1 : 0);

  /// Helper method to calculate the effective defender stands count
  /// (includes character if present)
  int get effectiveDefenderStands =>
      defenderStands + (defenderCharacter != null ? 1 : 0);

  /// Helper method to calculate the number of stands required to break
  /// (half or more of total effective stands)
  int get standsToBreak => (effectiveDefenderStands / 2).ceil();
}
