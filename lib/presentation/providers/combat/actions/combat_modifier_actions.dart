// lib/presentation/providers/combat/actions/combat_modifier_actions.dart
import '../models/combat_state.dart';
import '../notifiers/combat_notifier.dart';

/// Extension methods for CombatNotifier related to combat modifier actions
extension CombatModifierActions on CombatNotifier {
  void toggleCharge(bool value) {
    // Only allow toggling charge in melee mode
    if (state.combatMode == CombatMode.melee) {
      state = state.copyWith(isCharge: value, clearSimulation: true);
      // No longer auto-toggles impact - these are now independent
    }
  }

  void toggleImpact(bool value) {
    // Only allow toggling impact in melee mode for regiments with impact
    if (state.combatMode == CombatMode.melee &&
        (state.attacker?.hasImpact() ?? false)) {
      state = state.copyWith(isImpact: value, clearSimulation: true);
    }
  }

  void toggleFlank(bool value) {
    state = state.copyWith(isFlank: value, clearSimulation: true);
    // If turning on flank, turn off rear
    if (value && state.isRear) {
      state = state.copyWith(isRear: false);
    }
  }

  void toggleRear(bool value) {
    state = state.copyWith(isRear: value, clearSimulation: true);
    // If turning on rear, turn off flank
    if (value && state.isFlank) {
      state = state.copyWith(isFlank: false);
    }
  }

  void toggleVolley(bool value) {
    // Only allow toggling volley in ranged mode
    if (state.combatMode == CombatMode.ranged) {
      state = state.copyWith(isVolley: value, clearSimulation: true);

      // If turning off volley, also clear ranged-specific rules
      if (!value) {
        final updatedRules = Map<String, bool>.from(state.specialRulesInEffect)
          ..remove('aimed');
        state = state.copyWith(specialRulesInEffect: updatedRules);
      }
    }
  }

  void toggleWithinEffectiveRange(bool value) {
    // Only allow toggling effective range in ranged mode
    if (state.combatMode == CombatMode.ranged && state.isVolley) {
      state =
          state.copyWith(isWithinEffectiveRange: value, clearSimulation: true);
    }
  }

  void toggleArmorPiercing(bool value) {
    // Create a mutable copy of the special rules
    final updatedRules = Map<String, bool>.from(state.specialRulesInEffect);
    updatedRules['armorPiercing'] = value;

    // Create a mutable copy of the special rule values
    final updatedValues = Map<String, int>.from(state.specialRuleValues);

    // If enabling armor piercing, make sure we have the value from the regiment
    if (value && state.attacker != null && state.attacker!.hasArmorPiercing()) {
      updatedValues['armorPiercingValue'] =
          state.attacker!.getArmorPiercingValue();
    }

    state = state.copyWith(
        specialRulesInEffect: updatedRules,
        specialRuleValues: updatedValues,
        clearSimulation: true);
  }

  // Add this method to allow updating the armor piercing value
  void updateArmorPiercingValue(int value) {
    final updatedValues = Map<String, int>.from(state.specialRuleValues);
    updatedValues['armorPiercingValue'] = value;

    state =
        state.copyWith(specialRuleValues: updatedValues, clearSimulation: true);
  }

  void toggleCombatModifier(String rule, bool value) {
    final updatedRules = Map<String, bool>.from(state.specialRulesInEffect);
    updatedRules[rule] = value;
    state = state.copyWith(
        specialRulesInEffect: updatedRules, clearSimulation: true);
  }

  // Alias for toggleCombatModifier for backward compatibility
  void toggleSpecialRule(String rule, bool value) {
    toggleCombatModifier(rule, value);
  }

  void updateCombatModifierValue(String rule, int value) {
    final updatedValues = Map<String, int>.from(state.specialRuleValues);
    updatedValues[rule] = value;
    state =
        state.copyWith(specialRuleValues: updatedValues, clearSimulation: true);
  }

  // Alias for updateCombatModifierValue for backward compatibility
  void updateSpecialRuleValue(String rule, int value) {
    updateCombatModifierValue(rule, value);
  }
}
