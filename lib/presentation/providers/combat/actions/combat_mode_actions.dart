// lib/presentation/providers/combat/actions/combat_mode_actions.dart
import '../models/combat_state.dart';
import '../notifiers/combat_notifier.dart';

/// Extension methods for CombatNotifier related to combat mode actions
extension CombatModeActions on CombatNotifier {
  // Method to switch between combat modes
  void setCombatMode(CombatMode mode) {
    if (state.combatMode == mode) return; // No change needed

    // Update combat state based on the selected mode
    if (mode == CombatMode.melee) {
      // Switching to melee mode
      final updatedRules = Map<String, bool>.from(state.specialRulesInEffect)
        ..remove('aimed'); // Clear ranged-specific rules

      state = state.copyWith(
        combatMode: mode,
        isVolley: false, // Turn off volley
        isWithinEffectiveRange:
            false, // Clear effective range when switching to melee
        specialRulesInEffect: updatedRules,
        clearSimulation: true, // Clear the simulation
      );

      // Set default melee options
      setDefaultMeleeOptions();
    } else {
      // Switching to ranged mode
      final updatedRules = Map<String, bool>.from(state.specialRulesInEffect)
        ..remove('inspired'); // Clear melee-specific rules

      state = state.copyWith(
        combatMode: mode,
        isVolley: true, // Turn on volley
        isCharge: false, // Turn off melee-specific options
        isImpact: false,
        specialRulesInEffect: updatedRules,
        clearSimulation: true, // Clear the simulation
      );
    }
  }

  // Updated toggleDuelMode method with visual feedback
  void toggleDuelMode(bool value) {
    // Force the selections to null by creating a new state with explicit nulls
    final newState = CombatState(
      isDuelMode: value,
      // Explicitly set to null instead of using copyWith
      attacker: null, // Clear attacker
      defender: null, // Clear defender
      numAttackerStands: 3,
      numDefenderStands: 3,
      // Reset combat modifiers
      isCharge: false,
      isImpact: false,
      isFlank: false,
      isRear: false,
      isVolley: false,
      isWithinEffectiveRange: false,
      specialRulesInEffect: const {},
      specialRuleValues: const {},
      // Visual feedback
      selectionResetDueToModeChange: true,
      // Preserve faction selections
      attackerFaction: state.attackerFaction,
      defenderFaction: state.defenderFaction,
      // These will preserve saved calculations
      savedCalculations: state.savedCalculations,
      showCumulativeDistribution: state.showCumulativeDistribution,
      combatMode: value ? CombatMode.melee : state.combatMode,
    );

    // Update the state with the new clean state
    state = newState;

    // Clear the visual feedback flag after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        state = state.copyWith(selectionResetDueToModeChange: false);
      }
    });
  }
}
