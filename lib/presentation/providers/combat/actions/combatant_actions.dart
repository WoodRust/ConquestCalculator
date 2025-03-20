// lib/presentation/providers/combat/actions/combatant_actions.dart
import '../../../../domain/models/regiment.dart';
import '../notifiers/combat_notifier.dart';

/// Extension methods for CombatNotifier related to combatant (attacker/defender) actions
extension CombatantActions on CombatNotifier {
  // Set attacker faction - accepts nullable String
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

  // Set defender faction - accepts nullable String
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

  // Method to swap attacker and defender
  void swapAttackerAndDefender() {
    // Store the current values
    final currentAttacker = state.attacker;
    final currentAttackerStands = state.numAttackerStands;
    final currentAttackerCharacter = state.attackerCharacter;
    final currentAttackerFaction = state.attackerFaction;

    final currentDefender = state.defender;
    final currentDefenderStands = state.numDefenderStands;
    final currentDefenderCharacter = state.defenderCharacter;
    final currentDefenderFaction = state.defenderFaction;

    // Swap the values
    state = state.copyWith(
      attacker: currentDefender,
      numAttackerStands: currentDefenderStands,
      attackerCharacter: currentDefenderCharacter,
      attackerFaction: currentDefenderFaction,
      defender: currentAttacker,
      numDefenderStands: currentAttackerStands,
      defenderCharacter: currentAttackerCharacter,
      defenderFaction: currentAttackerFaction,
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
      );
      return;
    }

    // In duel mode, only allow character units as attacker
    if (state.isDuelMode && !regiment.isCharacter()) {
      return;
    }

    // Automatically update the faction based on the regiment's faction
    final String regimentFaction = regiment.faction;

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
        );
      } else {
        state = state.copyWith(
          attacker: regiment,
          attackerFaction: regimentFaction,
          clearSimulation: true, // Clear the simulation when changing attacker
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

  void updateDefender(Regiment? defender) {
    // If defender is null, clear it
    if (defender == null) {
      state = state.copyWith(
        clearDefender: true, // Use explicit clearing
        clearDefenderCharacter: true,
        clearSimulation: true,
      );
      return;
    }

    // In duel mode, only allow character units as defender
    if (state.isDuelMode && !defender.isCharacter()) {
      return;
    }

    // Automatically update the faction based on the regiment's faction
    final String regimentFaction = defender.faction;

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
        );
      } else {
        state = state.copyWith(
          defender: defender,
          defenderFaction: regimentFaction,
          clearSimulation: true, // Clear the simulation when changing defender
        );
      }
    } else {
      // In duel mode, simply update the defender (we already verified it's a character)
      state = state.copyWith(
        defender: defender,
        defenderFaction: regimentFaction,
        clearSimulation: true, // Clear the simulation
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
}
