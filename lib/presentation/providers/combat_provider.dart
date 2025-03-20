// lib/presentation/providers/combat_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/regiment.dart';
import '../../domain/models/combat_simulation.dart';
import '../../domain/usecases/calculate_combat.dart';

// Enum to track which combat mode is active
enum CombatMode { melee, ranged }

// Updated CombatState class with faction support
class CombatState {
  final Regiment? attacker;
  final int numAttackerStands;
  final Regiment? attackerCharacter;
  final String? attackerFaction; // Store the selected attacker faction

  final Regiment? defender;
  final int numDefenderStands;
  final Regiment? defenderCharacter;
  final String? defenderFaction; // Store the selected defender faction

  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final bool isVolley;
  final bool isWithinEffectiveRange;
  final Map<String, bool> specialRulesInEffect;
  final Map<String, int> specialRuleValues;
  final CombatSimulation? simulation;
  final List<SavedCalculation> savedCalculations;
  final bool showCumulativeDistribution;
  final CombatMode combatMode;
  final bool isDuelMode;
  final bool selectionResetDueToModeChange;

  CombatState({
    this.attacker,
    this.numAttackerStands = 3,
    this.attackerCharacter,
    this.attackerFaction,
    this.defender,
    this.numDefenderStands = 3,
    this.defenderCharacter,
    this.defenderFaction,
    this.isCharge = false,
    this.isImpact = false,
    this.isFlank = false,
    this.isRear = false,
    this.isVolley = false,
    this.isWithinEffectiveRange = false,
    this.specialRulesInEffect = const {},
    this.specialRuleValues = const {},
    this.simulation,
    this.savedCalculations = const [],
    this.showCumulativeDistribution = false,
    this.combatMode = CombatMode.melee,
    this.isDuelMode = false,
    this.selectionResetDueToModeChange = false,
  });

  CombatState copyWith({
    Regiment? attacker,
    bool clearAttacker = false, // Added explicit flag to clear attacker
    int? numAttackerStands,
    Regiment? attackerCharacter,
    String? attackerFaction,
    bool clearAttackerFaction = false,
    bool clearAttackerCharacter = false,
    Regiment? defender,
    bool clearDefender = false, // Added explicit flag to clear defender
    int? numDefenderStands,
    Regiment? defenderCharacter,
    String? defenderFaction,
    bool clearDefenderFaction = false,
    bool clearDefenderCharacter = false,
    bool? isCharge,
    bool? isImpact,
    bool? isFlank,
    bool? isRear,
    bool? isVolley,
    bool? isWithinEffectiveRange,
    Map<String, bool>? specialRulesInEffect,
    Map<String, int>? specialRuleValues,
    CombatSimulation? simulation,
    bool clearSimulation = false,
    List<SavedCalculation>? savedCalculations,
    bool? showCumulativeDistribution,
    CombatMode? combatMode,
    bool? isDuelMode,
    bool? selectionResetDueToModeChange,
  }) {
    return CombatState(
      // Use clearAttacker flag to explicitly set attacker to null
      attacker: clearAttacker ? null : (attacker ?? this.attacker),
      numAttackerStands: numAttackerStands ?? this.numAttackerStands,
      attackerCharacter: clearAttackerCharacter
          ? null
          : (attackerCharacter ?? this.attackerCharacter),
      attackerFaction: clearAttackerFaction
          ? null
          : (attackerFaction ?? this.attackerFaction),
      // Use clearDefender flag to explicitly set defender to null
      defender: clearDefender ? null : (defender ?? this.defender),
      numDefenderStands: numDefenderStands ?? this.numDefenderStands,
      defenderCharacter: clearDefenderCharacter
          ? null
          : (defenderCharacter ?? this.defenderCharacter),
      defenderFaction: clearDefenderFaction
          ? null
          : (defenderFaction ?? this.defenderFaction),
      isCharge: isCharge ?? this.isCharge,
      isImpact: isImpact ?? this.isImpact,
      isFlank: isFlank ?? this.isFlank,
      isRear: isRear ?? this.isRear,
      isVolley: isVolley ?? this.isVolley,
      isWithinEffectiveRange:
          isWithinEffectiveRange ?? this.isWithinEffectiveRange,
      specialRulesInEffect: specialRulesInEffect ?? this.specialRulesInEffect,
      specialRuleValues: specialRuleValues ?? this.specialRuleValues,
      simulation: clearSimulation ? null : (simulation ?? this.simulation),
      savedCalculations: savedCalculations ?? this.savedCalculations,
      showCumulativeDistribution:
          showCumulativeDistribution ?? this.showCumulativeDistribution,
      combatMode: combatMode ?? this.combatMode,
      isDuelMode: isDuelMode ?? this.isDuelMode,
      selectionResetDueToModeChange:
          selectionResetDueToModeChange ?? this.selectionResetDueToModeChange,
    );
  }

  // Helper methods to get effective stand counts (including character)
  int get effectiveAttackerStands =>
      numAttackerStands + (attackerCharacter != null ? 1 : 0);

  int get effectiveDefenderStands =>
      numDefenderStands + (defenderCharacter != null ? 1 : 0);

  // Check if regiment can have a character attached (non-monster regiments only and not characters)
  bool canAttachCharacterToAttacker() {
    return attacker != null &&
        attacker!.type != RegimentType.monster &&
        !attacker!.isCharacter();
  }

  bool canAttachCharacterToDefender() {
    return defender != null &&
        defender!.type != RegimentType.monster &&
        !defender!.isCharacter();
  }

  // Add a helper property to check for character vs character mode
  bool get isCharacterVsCharacterMode =>
      isDuelMode || attacker?.isCharacter() == true;

  // Convert faction string to file path format (lowercase with underscores)
  static String? factionToPath(String? faction) {
    if (faction == null) return null;
    return faction.toLowerCase().replaceAll(' ', '_');
  }
}

class SavedCalculation {
  final String name;
  final CombatSimulation simulation;
  final bool isVisible;
  final DateTime savedAt;

  SavedCalculation({
    required this.name,
    required this.simulation,
    this.isVisible = true,
    DateTime? savedAt,
  }) : savedAt = savedAt ?? DateTime.now();

  SavedCalculation copyWith({
    String? name,
    CombatSimulation? simulation,
    bool? isVisible,
    DateTime? savedAt,
  }) {
    return SavedCalculation(
      name: name ?? this.name,
      simulation: simulation ?? this.simulation,
      isVisible: isVisible ?? this.isVisible,
      savedAt: savedAt ?? this.savedAt,
    );
  }
}

class CombatNotifier extends StateNotifier<CombatState> {
  final CalculateCombat _calculateCombat;

  CombatNotifier(this._calculateCombat) : super(CombatState());

  // Helper method to set default melee options based on attacker
  void _setDefaultMeleeOptions() {
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
    _setDefaultMeleeOptions();
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
      _setDefaultMeleeOptions();
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
      _setDefaultMeleeOptions();
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

  void toggleSpecialRule(String rule, bool value) {
    final updatedRules = Map<String, bool>.from(state.specialRulesInEffect);
    updatedRules[rule] = value;
    state = state.copyWith(
        specialRulesInEffect: updatedRules, clearSimulation: true);
  }

  void updateSpecialRuleValue(String rule, int value) {
    final updatedValues = Map<String, int>.from(state.specialRuleValues);
    updatedValues[rule] = value;
    state =
        state.copyWith(specialRuleValues: updatedValues, clearSimulation: true);
  }

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
}

final calculateCombatProvider = Provider((ref) => CalculateCombat());

final combatProvider =
    StateNotifierProvider<CombatNotifier, CombatState>((ref) {
  final calculateCombat = ref.watch(calculateCombatProvider);
  return CombatNotifier(calculateCombat);
});
