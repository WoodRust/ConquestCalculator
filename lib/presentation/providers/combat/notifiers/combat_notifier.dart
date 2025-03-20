// lib/presentation/providers/combat/notifiers/combat_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/regiment.dart';
import '../../../../domain/models/combat_simulation.dart';
import '../../../../domain/usecases/calculate_combat.dart';
import '../models/combat_state.dart';
import '../models/saved_calculation.dart';

/// Core notifier class for combat state management
class CombatNotifier extends StateNotifier<CombatState> {
  final CalculateCombat _calculateCombat;

  CombatNotifier(this._calculateCombat) : super(CombatState());

  // Helper method to set default melee options based on attacker
  void setDefaultMeleeOptions() {
    if (state.attacker != null && state.combatMode == CombatMode.melee) {
      // Enable charge by default
      state = state.copyWith(isCharge: true);

      // Enable impact by default if attacker has impact, otherwise disable it
      if (state.attacker!.hasImpact()) {
        state = state.copyWith(isImpact: true);
      } else {
        state = state.copyWith(isImpact: false);
      }

      // Enable inspired by default
      final updatedRules = Map<String, bool>.from(state.specialRulesInEffect);
      updatedRules['inspired'] = true;
      state = state.copyWith(specialRulesInEffect: updatedRules);
    }
  }

  // Manual calculation method that only gets called by the Calculate button
  void calculateCombat() {
    if (state.attacker != null && state.defender != null) {
      // Handle character vs character combat differently
      bool isCharacterVsCharacter = state.isDuelMode ||
          (state.attacker!.isCharacter() && state.defender!.isCharacter());

      final simulation = _calculateCombat.calculateExpectedResult(
        attacker: state.attacker!,
        numAttackerStands: isCharacterVsCharacter ? 1 : state.numAttackerStands,
        attackerCharacter:
            state.attackerCharacter, // Add character to calculation
        defender: state.defender!,
        numDefenderStands: isCharacterVsCharacter ? 1 : state.numDefenderStands,
        defenderCharacter:
            state.defenderCharacter, // Add character to calculation
        isCharge: state.isCharge,
        isImpact: state.isImpact,
        isFlank: state.isFlank,
        isRear: state.isRear,
        isVolley: state.isVolley,
        isWithinEffectiveRange: state.isWithinEffectiveRange,
        specialRulesInEffect: state.specialRulesInEffect,
        impactValues: state.specialRuleValues,
      );

      state = state.copyWith(simulation: simulation);
    }
  }
}
