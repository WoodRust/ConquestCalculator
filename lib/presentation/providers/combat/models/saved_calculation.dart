// lib/presentation/providers/combat/models/saved_calculation.dart
import '../../../../domain/models/combat_simulation.dart';

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
