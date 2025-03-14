// lib/presentation/providers/combat_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/regiment.dart';
import '../../domain/models/combat_simulation.dart';
import '../../domain/models/probability_distribution.dart';
import '../../domain/usecases/calculate_combat.dart';

// Enum to track which combat mode is active
enum CombatMode { melee, ranged }

// Updated CombatState class with character support
class CombatState {
  final Regiment? attacker;
  final int numAttackerStands;
  final Regiment? attackerCharacter; // Added: character attached to attacker
  final Regiment? defender;
  final int numDefenderStands;
  final Regiment? defenderCharacter; // Added: character attached to defender
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

  CombatState({
    this.attacker,
    this.numAttackerStands = 3,
    this.attackerCharacter, // Added
    this.defender,
    this.numDefenderStands = 3,
    this.defenderCharacter, // Added
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
  });

  CombatState copyWith({
    Regiment? attacker,
    int? numAttackerStands,
    Regiment? attackerCharacter,
    bool clearAttackerCharacter = false,
    Regiment? defender,
    int? numDefenderStands,
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
    CombatSimulation? simulation,
    List<SavedCalculation>? savedCalculations,
    bool? showCumulativeDistribution,
    CombatMode? combatMode,
  }) {
    return CombatState(
      attacker: attacker ?? this.attacker,
      numAttackerStands: numAttackerStands ?? this.numAttackerStands,
      attackerCharacter: clearAttackerCharacter
          ? null
          : (attackerCharacter ?? this.attackerCharacter),
      defender: defender ?? this.defender,
      numDefenderStands: numDefenderStands ?? this.numDefenderStands,
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
      simulation: simulation ?? this.simulation,
      savedCalculations: savedCalculations ?? this.savedCalculations,
      showCumulativeDistribution:
          showCumulativeDistribution ?? this.showCumulativeDistribution,
      combatMode: combatMode ?? this.combatMode,
    );
  }

  // Helper methods to get effective stand counts (including character)
  int get effectiveAttackerStands =>
      numAttackerStands + (attackerCharacter != null ? 1 : 0);

  int get effectiveDefenderStands =>
      numDefenderStands + (defenderCharacter != null ? 1 : 0);

  // Check if regiment can have a character attached (non-monster regiments only)
  bool canAttachCharacterToAttacker() {
    return attacker != null && attacker!.type != RegimentType.monster;
  }

  bool canAttachCharacterToDefender() {
    return defender != null && defender!.type != RegimentType.monster;
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

  void updateAttacker(Regiment attacker) {
    state = state.copyWith(attacker: attacker);

    // Auto-select combat mode based on regiment's capabilities
    if (attacker.hasBarrage() &&
        !state.isVolley &&
        state.combatMode == CombatMode.melee) {
      // If regiment has barrage ability, prompt user by highlighting ranged combat option
      // (we don't auto-switch, just make it clear it's available)
    }

    _recalculate();
  }

  void updateAttackerStands(int stands) {
    state = state.copyWith(numAttackerStands: stands);
    _recalculate();
  }

  void attachCharacterToAttacker(Regiment character) {
    // Only allow attaching if the regiment can have a character
    if (state.canAttachCharacterToAttacker()) {
      // Ensure the character is actually a character regiment
      if (character.isCharacter()) {
        state = state.copyWith(attackerCharacter: character);
        _recalculate();
      }
    }
  }

  void detachCharacterFromAttacker() {
    if (state.attackerCharacter != null) {
      // Use the clearAttackerCharacter flag to ensure null is properly applied
      state = state.copyWith(clearAttackerCharacter: true);
      _recalculate();
    }
  }

  void attachCharacterToDefender(Regiment character) {
    // Only allow attaching if the regiment can have a character
    if (state.canAttachCharacterToDefender()) {
      // Ensure the character is actually a character regiment
      if (character.isCharacter()) {
        state = state.copyWith(defenderCharacter: character);
        _recalculate();
      }
    }
  }

  void detachCharacterFromDefender() {
    if (state.defenderCharacter != null) {
      // Use the clearDefenderCharacter flag to ensure null is properly applied
      state = state.copyWith(clearDefenderCharacter: true);
      _recalculate();
    }
  }

  void updateDefender(Regiment defender) {
    state = state.copyWith(defender: defender);
    _recalculate();
  }

  void updateDefenderStands(int stands) {
    state = state.copyWith(numDefenderStands: stands);
    _recalculate();
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
      );
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
      );
    }

    _recalculate();
  }

  void toggleCharge(bool value) {
    // Only allow toggling charge in melee mode
    if (state.combatMode == CombatMode.melee) {
      state = state.copyWith(isCharge: value);
      // If turning on charge and regiment has impact, enable impact too
      if (value && (state.attacker?.hasImpact() ?? false)) {
        state = state.copyWith(isImpact: true);
      }
      _recalculate();
    }
  }

  void toggleImpact(bool value) {
    // Only allow toggling impact in melee mode for regiments with impact
    if (state.combatMode == CombatMode.melee &&
        (state.attacker?.hasImpact() ?? false)) {
      state = state.copyWith(isImpact: value);
      _recalculate();
    }
  }

  void toggleFlank(bool value) {
    state = state.copyWith(isFlank: value);
    // If turning on flank, turn off rear
    if (value && state.isRear) {
      state = state.copyWith(isRear: false);
    }
    _recalculate();
  }

  void toggleRear(bool value) {
    state = state.copyWith(isRear: value);
    // If turning on rear, turn off flank
    if (value && state.isFlank) {
      state = state.copyWith(isFlank: false);
    }
    _recalculate();
  }

  void toggleVolley(bool value) {
    // Only allow toggling volley in ranged mode
    if (state.combatMode == CombatMode.ranged) {
      state = state.copyWith(isVolley: value);

      // If turning off volley, also clear ranged-specific rules
      if (!value) {
        final updatedRules = Map<String, bool>.from(state.specialRulesInEffect)
          ..remove('aimed');
        state = state.copyWith(specialRulesInEffect: updatedRules);
      }

      _recalculate();
    }
  }

  void toggleWithinEffectiveRange(bool value) {
    // Only allow toggling effective range in ranged mode
    if (state.combatMode == CombatMode.ranged && state.isVolley) {
      state = state.copyWith(isWithinEffectiveRange: value);
      _recalculate();
    }
  }

  void toggleSpecialRule(String rule, bool value) {
    final updatedRules = Map<String, bool>.from(state.specialRulesInEffect);
    updatedRules[rule] = value;
    state = state.copyWith(specialRulesInEffect: updatedRules);
    _recalculate();
  }

  void updateSpecialRuleValue(String rule, int value) {
    final updatedValues = Map<String, int>.from(state.specialRuleValues);
    updatedValues[rule] = value;
    state = state.copyWith(specialRuleValues: updatedValues);
    _recalculate();
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

  void _recalculate() {
    if (state.attacker != null && state.defender != null) {
      final simulation = _calculateCombat.calculateExpectedResult(
        attacker: state.attacker!,
        numAttackerStands: state.numAttackerStands,
        attackerCharacter:
            state.attackerCharacter, // Add character to calculation
        defender: state.defender!,
        numDefenderStands: state.numDefenderStands,
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

final calculateCombatProvider = Provider((ref) => CalculateCombat());

final combatProvider =
    StateNotifierProvider<CombatNotifier, CombatState>((ref) {
  final calculateCombat = ref.watch(calculateCombatProvider);
  return CombatNotifier(calculateCombat);
});
