// lib/presentation/providers/combat/actions/saved_calculation_actions.dart
import '../models/saved_calculation.dart';
import '../notifiers/combat_notifier.dart';

/// Extension methods for CombatNotifier related to saved calculation actions
extension SavedCalculationActions on CombatNotifier {
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
