// lib/presentation/providers/combat_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/regiment.dart';
import '../../domain/models/combat_simulation.dart';
import '../../domain/usecases/calculate_combat.dart';

class CombatState {
  final Regiment? attacker;
  final int numAttackerStands;
  final Regiment? defender;
  final int numDefenderStands;
  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final Map<String, bool> specialRulesInEffect;
  final CombatSimulation? simulation;

  CombatState({
    this.attacker,
    this.numAttackerStands = 3,
    this.defender,
    this.numDefenderStands = 3,
    this.isCharge = false,
    this.isImpact = false,
    this.isFlank = false,
    this.isRear = false,
    this.specialRulesInEffect = const {},
    this.simulation,
  });

  CombatState copyWith({
    Regiment? attacker,
    int? numAttackerStands,
    Regiment? defender,
    int? numDefenderStands,
    bool? isCharge,
    bool? isImpact,
    bool? isFlank,
    bool? isRear,
    Map<String, bool>? specialRulesInEffect,
    CombatSimulation? simulation,
  }) {
    return CombatState(
      attacker: attacker ?? this.attacker,
      numAttackerStands: numAttackerStands ?? this.numAttackerStands,
      defender: defender ?? this.defender,
      numDefenderStands: numDefenderStands ?? this.numDefenderStands,
      isCharge: isCharge ?? this.isCharge,
      isImpact: isImpact ?? this.isImpact,
      isFlank: isFlank ?? this.isFlank,
      isRear: isRear ?? this.isRear,
      specialRulesInEffect: specialRulesInEffect ?? this.specialRulesInEffect,
      simulation: simulation ?? this.simulation,
    );
  }
}

class CombatNotifier extends StateNotifier<CombatState> {
  final CalculateCombat _calculateCombat;

  CombatNotifier(this._calculateCombat) : super(CombatState());

  void updateAttacker(Regiment attacker) {
    state = state.copyWith(attacker: attacker);
    _recalculate();
  }

  void updateAttackerStands(int stands) {
    state = state.copyWith(numAttackerStands: stands);
    _recalculate();
  }

  void updateDefender(Regiment defender) {
    state = state.copyWith(defender: defender);
    _recalculate();
  }

  void updateDefenderStands(int stands) {
    state = state.copyWith(numDefenderStands: stands);
    _recalculate();
  }

  void toggleCharge(bool value) {
    state = state.copyWith(isCharge: value);
    _recalculate();
  }

  void toggleImpact(bool value) {
    state = state.copyWith(isImpact: value);
    _recalculate();
  }

  void toggleFlank(bool value) {
    state = state.copyWith(isFlank: value);
    _recalculate();
  }

  void toggleRear(bool value) {
    state = state.copyWith(isRear: value);
    _recalculate();
  }

  void toggleSpecialRule(String rule, bool value) {
    final updatedRules = Map<String, bool>.from(state.specialRulesInEffect);
    updatedRules[rule] = value;
    state = state.copyWith(specialRulesInEffect: updatedRules);
    _recalculate();
  }

  void _recalculate() {
    if (state.attacker != null && state.defender != null) {
      final simulation = _calculateCombat.calculateExpectedResult(
        attacker: state.attacker!,
        numAttackerStands: state.numAttackerStands,
        defender: state.defender!,
        numDefenderStands: state.numDefenderStands,
        isCharge: state.isCharge,
        isImpact: state.isImpact,
        isFlank: state.isFlank,
        isRear: state.isRear,
        specialRulesInEffect: state.specialRulesInEffect,
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
