// lib/presentation/providers/combat/notifiers/combat_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/regiment.dart';
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
      state = state.copyWith(isClash: true);

      // Enable impact by default if attacker has impact, otherwise disable it
      if (state.attacker!.hasImpact()) {
        state = state.copyWith(isImpact: true);
      } else {
        state = state.copyWith(isImpact: false);
      }

      // Enable inspired by default (using global specialRulesInEffect for backwards compatibility)
      final updatedRules =
          Map<String, bool>.from(state.attackerSpecialRulesInEffect);
      updatedRules['inspired'] = true;
      state = state.copyWith(attackerSpecialRulesInEffect: updatedRules);
    }
  }

  // Helper method to build special rules map from a Regiment's built-in rules
  Map<String, bool> _buildSpecialRulesMapFromRegiment(Regiment regiment) {
    final Map<String, bool> rulesMap = {};

    // Convert each special rule to the format expected in the special rules maps
    // (lowercase with underscores) and set it to true
    for (final rule in regiment.specialRules) {
      // Extract the base rule name by removing any parameters (e.g., "Impact (2)" -> "impact")
      String baseName = rule.toLowerCase();

      // Remove parameters if present
      int parenIndex = baseName.indexOf('(');
      if (parenIndex > 0) {
        baseName = baseName.substring(0, parenIndex).trim();
      }

      // Replace spaces with underscores for the map key format
      final ruleKey = baseName.replaceAll(' ', '_');

      // Set the rule to active (true)
      rulesMap[ruleKey] = true;
    }

    return rulesMap;
  }

  // Manual calculation method that only gets called by the Calculate button
  void calculateCombat() {
    if (state.attacker != null && state.defender != null) {
      // Handle character vs character combat differently
      bool isCharacterVsCharacter = state.isDuelMode ||
          (state.attacker!.isCharacter() && state.defender!.isCharacter());

      // ADDED: Debug output for special rules maps
      print("===== SPECIAL RULES DEBUG =====");
      print("Attacker Special Rules:");
      state.attackerSpecialRulesInEffect.forEach((key, value) {
        print("  $key: $value");
      });

      print("\nDefender Special Rules:");
      state.defenderSpecialRulesInEffect.forEach((key, value) {
        print("  $key: $value");
      });

      print("=============================");

      final simulation = _calculateCombat.calculateExpectedResult(
        attacker: state.attacker!,
        numAttackerStands: isCharacterVsCharacter ? 1 : state.numAttackerStands,
        attackerCharacter: state.attackerCharacter,
        defender: state.defender!,
        numDefenderStands: isCharacterVsCharacter ? 1 : state.numDefenderStands,
        defenderCharacter: state.defenderCharacter,
        isCharge: state.isCharge,
        isImpact: state.isImpact,
        isFlank: state.isFlank,
        isRear: state.isRear,
        isVolley: state.isVolley,
        isWithinEffectiveRange: state.isWithinEffectiveRange,
        //specialRulesInEffect: mergedRules,
        attackerSpecialRulesInEffect: state.attackerSpecialRulesInEffect,
        defenderSpecialRulesInEffect: state.defenderSpecialRulesInEffect,
        impactValues: state.specialRuleValues,
      );

      state = state.copyWith(simulation: simulation);
    }
  }

  // ===== Methods from saved_calculation_actions.dart =====

  void toggleCumulativeDistribution(bool value) {
    state = state.copyWith(showCumulativeDistribution: value);
  }

  void saveCurrentCalculation(String name) {
    if (state.simulation == null) return;

    final currentSim = state.simulation!;
    final savedCalc = SavedCalculation(
      name: name,
      simulation: currentSim,
    );

    final updatedSavedCalculations =
        List<SavedCalculation>.from(state.savedCalculations);
    updatedSavedCalculations.add(savedCalc);

    state = state.copyWith(savedCalculations: updatedSavedCalculations);
  }

  void toggleSavedCalculationVisibility(int index) {
    if (index < 0 || index >= state.savedCalculations.length) return;

    final updatedSavedCalculations =
        List<SavedCalculation>.from(state.savedCalculations);
    final currentCalc = updatedSavedCalculations[index];

    updatedSavedCalculations[index] = currentCalc.copyWith(
      isVisible: !currentCalc.isVisible,
    );

    state = state.copyWith(savedCalculations: updatedSavedCalculations);
  }

  void deleteSavedCalculation(int index) {
    if (index < 0 || index >= state.savedCalculations.length) return;

    final updatedSavedCalculations =
        List<SavedCalculation>.from(state.savedCalculations);
    updatedSavedCalculations.removeAt(index);

    state = state.copyWith(savedCalculations: updatedSavedCalculations);
  }

  // ===== Methods from combatant_actions.dart =====

  void setAttackerFaction(String? faction) {
    if (faction == null) {
      // If clearing faction, explicitly clear attacker and attacker character
      state = state.copyWith(
        clearAttackerFaction: true,
        clearAttacker: true, // Explicitly clear attacker
        clearAttackerCharacter: true, // Clear any attached character
        clearSimulation: true, // Clear the simulation
      );
    } else {
      state = state.copyWith(attackerFaction: faction);
    }
  }

  void setDefenderFaction(String? faction) {
    if (faction == null) {
      // If clearing faction, explicitly clear defender and defender character
      state = state.copyWith(
        clearDefenderFaction: true,
        clearDefender: true, // Explicitly clear defender
        clearDefenderCharacter: true, // Clear any attached character
        clearSimulation: true, // Clear the simulation
      );
    } else {
      state = state.copyWith(defenderFaction: faction);
    }
  }

  void swapAttackerAndDefender() {
    // Store the current values
    final currentAttacker = state.attacker;
    final currentAttackerStands = state.numAttackerStands;
    final currentAttackerCharacter = state.attackerCharacter;
    final currentAttackerFaction = state.attackerFaction;
    final currentAttackerSpecialRules =
        Map<String, bool>.from(state.attackerSpecialRulesInEffect);

    final currentDefender = state.defender;
    final currentDefenderStands = state.numDefenderStands;
    final currentDefenderCharacter = state.defenderCharacter;
    final currentDefenderFaction = state.defenderFaction;
    final currentDefenderSpecialRules =
        Map<String, bool>.from(state.defenderSpecialRulesInEffect);

    // Swap the values
    state = state.copyWith(
      attacker: currentDefender,
      numAttackerStands: currentDefenderStands,
      attackerCharacter: currentDefenderCharacter,
      attackerFaction: currentDefenderFaction,
      attackerSpecialRulesInEffect: currentDefenderSpecialRules,
      defender: currentAttacker,
      numDefenderStands: currentAttackerStands,
      defenderCharacter: currentAttackerCharacter,
      defenderFaction: currentAttackerFaction,
      defenderSpecialRulesInEffect: currentAttackerSpecialRules,
      clearSimulation: true, // Clear the current simulation
    );

    // Apply default melee options after swapping
    setDefaultMeleeOptions();
  }

  void updateAttacker(Regiment? regiment) {
    // If regiment is null, clear it
    if (regiment == null) {
      state = state.copyWith(
        clearAttacker: true, // Use explicit clearing
        clearAttackerCharacter: true,
        clearSimulation: true,
        // Clear attacker special rules when clearing the unit
        attackerSpecialRulesInEffect: {},
      );
      return;
    }

    // In duel mode, only allow character units as attacker
    if (state.isDuelMode && !regiment.isCharacter()) {
      return;
    }

    // Automatically update the faction based on the regiment's faction
    final String regimentFaction = regiment.faction;

    // Build special rules map from regiment's built-in rules
    final Map<String, bool> builtInRules =
        _buildSpecialRulesMapFromRegiment(regiment);

    // If not in duel mode, ensure consistency with regular mode rules
    if (!state.isDuelMode) {
      // If new attacker is a character and defender is a regular regiment
      if (regiment.isCharacter() &&
          state.defender != null &&
          !state.defender!.isCharacter()) {
        // Clear the defender and defender character if set
        state = state.copyWith(
          attacker: regiment,
          attackerFaction: regimentFaction,
          clearDefender: true, // Use explicit clearing
          clearDefenderCharacter: true, // Clear any attached character
          clearSimulation: true, // Clear the simulation
          // Initialize attacker special rules with built-in rules
          attackerSpecialRulesInEffect: builtInRules,
          // Clear defender special rules
          defenderSpecialRulesInEffect: {},
        );
      } else {
        state = state.copyWith(
          attacker: regiment,
          attackerFaction: regimentFaction,
          clearSimulation: true, // Clear the simulation when changing attacker
          // Initialize attacker special rules with built-in rules
          attackerSpecialRulesInEffect: builtInRules,
        );
      }

      // After setting attacker, set default melee options
      setDefaultMeleeOptions();
    } else {
      // In duel mode, simply update the attacker (we already verified it's a character)
      state = state.copyWith(
        attacker: regiment,
        attackerFaction: regimentFaction,
        clearSimulation: true, // Clear the simulation
        // Initialize attacker special rules with built-in rules
        attackerSpecialRulesInEffect: builtInRules,
      );
    }
  }

  void updateAttackerStands(int stands) {
    state = state.copyWith(numAttackerStands: stands, clearSimulation: true);
  }

  void attachCharacterToAttacker(Regiment character) {
    // Don't allow attaching characters in duel mode
    if (state.isDuelMode) return;

    // Only allow attaching if the regiment can have a character
    if (state.canAttachCharacterToAttacker()) {
      // Ensure the character is actually a character regiment
      if (character.isCharacter()) {
        state =
            state.copyWith(attackerCharacter: character, clearSimulation: true);
      }
    }
  }

  void detachCharacterFromAttacker() {
    if (state.attackerCharacter != null) {
      // Use the clearAttackerCharacter flag to ensure null is properly applied
      state =
          state.copyWith(clearAttackerCharacter: true, clearSimulation: true);
    }
  }

  // Add a method to update attacker special rules map directly
  void updateAttackerSpecialRules(Map<String, bool> updatedRules) {
    state = state.copyWith(
        attackerSpecialRulesInEffect: updatedRules, clearSimulation: true);
  }

  // Add a method to update defender special rules map directly
  void updateDefenderSpecialRules(Map<String, bool> updatedRules) {
    state = state.copyWith(
        defenderSpecialRulesInEffect: updatedRules, clearSimulation: true);
  }

  void updateDefender(Regiment? defender) {
    // If defender is null, clear it
    if (defender == null) {
      state = state.copyWith(
        clearDefender: true, // Use explicit clearing
        clearDefenderCharacter: true,
        clearSimulation: true,
        // Clear defender special rules when clearing the unit
        defenderSpecialRulesInEffect: {},
      );
      return;
    }

    // In duel mode, only allow character units as defender
    if (state.isDuelMode && !defender.isCharacter()) {
      return;
    }

    // Automatically update the faction based on the regiment's faction
    final String regimentFaction = defender.faction;

    // Build special rules map from regiment's built-in rules
    final Map<String, bool> builtInRules =
        _buildSpecialRulesMapFromRegiment(defender);

    // If not in duel mode, ensure consistency with regular mode rules
    if (!state.isDuelMode) {
      // If new defender is a regiment and attacker is a character-only unit
      if (!defender.isCharacter() &&
          state.attacker != null &&
          state.attacker!.isCharacter()) {
        // Clear the attacker and attacker character if set
        state = state.copyWith(
          defender: defender,
          defenderFaction: regimentFaction,
          clearAttacker: true, // Use explicit clearing
          clearAttackerCharacter: true, // Clear any attached character
          clearSimulation: true, // Clear the simulation
          // Initialize defender special rules with built-in rules
          defenderSpecialRulesInEffect: builtInRules,
          // Clear attacker special rules
          attackerSpecialRulesInEffect: {},
        );
      } else {
        state = state.copyWith(
          defender: defender,
          defenderFaction: regimentFaction,
          clearSimulation: true, // Clear the simulation when changing defender
          // Initialize defender special rules with built-in rules
          defenderSpecialRulesInEffect: builtInRules,
        );
      }
    } else {
      // In duel mode, simply update the defender (we already verified it's a character)
      state = state.copyWith(
        defender: defender,
        defenderFaction: regimentFaction,
        clearSimulation: true, // Clear the simulation
        // Initialize defender special rules with built-in rules
        defenderSpecialRulesInEffect: builtInRules,
      );
    }
  }

  void updateDefenderStands(int stands) {
    state = state.copyWith(numDefenderStands: stands, clearSimulation: true);
  }

  void attachCharacterToDefender(Regiment character) {
    // Don't allow attaching characters in duel mode
    if (state.isDuelMode) return;

    // Only allow attaching if the regiment can have a character
    if (state.canAttachCharacterToDefender()) {
      // Ensure the character is actually a character regiment
      if (character.isCharacter()) {
        state =
            state.copyWith(defenderCharacter: character, clearSimulation: true);
      }
    }
  }

  void detachCharacterFromDefender() {
    if (state.defenderCharacter != null) {
      // Use the clearDefenderCharacter flag to ensure null is properly applied
      state =
          state.copyWith(clearDefenderCharacter: true, clearSimulation: true);
    }
  }

  // ===== Methods from combat_mode_actions.dart =====

  void setCombatMode(CombatMode mode) {
    if (state.combatMode == mode) return; // No change needed

    // Update combat state based on the selected mode
    if (mode == CombatMode.melee) {
      // Switching to melee mode
      final updatedRules =
          Map<String, bool>.from(state.attackerSpecialRulesInEffect)
            ..remove('aimed'); // Clear ranged-specific rules

      state = state.copyWith(
        combatMode: mode,
        isVolley: false, // Turn off volley
        isWithinEffectiveRange:
            false, // Clear effective range when switching to melee
        attackerSpecialRulesInEffect: updatedRules,
        clearSimulation: true, // Clear the simulation
      );

      // Set default melee options
      setDefaultMeleeOptions();
    } else {
      // Switching to ranged mode
      final updatedRules =
          Map<String, bool>.from(state.attackerSpecialRulesInEffect)
            ..remove('inspired'); // Clear melee-specific rules

      state = state.copyWith(
        combatMode: mode,
        isVolley: true, // Turn on volley
        isClash: false, // Turn off melee-specific options
        isImpact: false,
        attackerSpecialRulesInEffect: updatedRules,
        clearSimulation: true, // Clear the simulation
      );
    }
  }

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
      //specialRulesInEffect: const {},
      attackerSpecialRulesInEffect: const {},
      defenderSpecialRulesInEffect: const {},
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

  // ===== Methods from combat_modifier_actions.dart =====

  void toggleCharge(bool value) {
    // Only allow toggling charge in melee mode
    if (state.combatMode == CombatMode.melee) {
      state = state.copyWith(isClash: value, clearSimulation: true);
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
        final updatedRules =
            Map<String, bool>.from(state.attackerSpecialRulesInEffect)
              ..remove('aimed');
        state = state.copyWith(attackerSpecialRulesInEffect: updatedRules);
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

  void toggleDefenderBroken(bool value) {
    state = state.copyWith(isDefenderBroken: value, clearSimulation: true);
  }

  // New methods for separate attacker and defender special rules
  void toggleAttackerCombatModifier(String rule, bool value) {
    final updatedRules =
        Map<String, bool>.from(state.attackerSpecialRulesInEffect);
    updatedRules[rule] = value;
    state = state.copyWith(
        attackerSpecialRulesInEffect: updatedRules, clearSimulation: true);
  }

  void toggleDefenderCombatModifier(String rule, bool value) {
    final updatedRules =
        Map<String, bool>.from(state.defenderSpecialRulesInEffect);
    updatedRules[rule] = value;
    state = state.copyWith(
        defenderSpecialRulesInEffect: updatedRules, clearSimulation: true);
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
