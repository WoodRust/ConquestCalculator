// lib/presentation/widgets/saved_calculations_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';

class SavedCalculationsPanel extends ConsumerWidget {
  const SavedCalculationsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    // If there are no saved calculations, don't show anything
    if (combatState.savedCalculations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Saved Calculations',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: combatState.savedCalculations.length,
          itemBuilder: (context, index) {
            final calculation = combatState.savedCalculations[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(calculation.name),
                subtitle: Text(
                  '${calculation.simulation.attacker.name} vs ${calculation.simulation.defender.name}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        calculation.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: calculation.isVisible
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                      tooltip: calculation.isVisible
                          ? 'Hide from charts'
                          : 'Show in charts',
                      onPressed: () => combatNotifier
                          .toggleSavedCalculationVisibility(index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      tooltip: 'Delete calculation',
                      onPressed: () => _confirmDeleteCalculation(
                          context, combatNotifier, index, calculation.name),
                    ),
                  ],
                ),
                onTap: () => _showCalculationDetails(context, calculation),
              ),
            );
          },
        ),
      ],
    );
  }

  void _confirmDeleteCalculation(BuildContext context, CombatNotifier notifier,
      int index, String calculationName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Calculation'),
        content: Text('Are you sure you want to delete "$calculationName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              notifier.deleteSavedCalculation(index);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showCalculationDetails(
      BuildContext context, SavedCalculation calculation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(calculation.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Attacker: ${calculation.simulation.attacker.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Stands: ${calculation.simulation.numAttackerStands}'),
              const SizedBox(height: 8),
              Text(
                'Defender: ${calculation.simulation.defender.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Stands: ${calculation.simulation.numDefenderStands}'),
              const SizedBox(height: 8),
              Text(
                'Modifiers:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Charge: ${calculation.simulation.isCharge ? "Yes" : "No"}'),
              Text('Impact: ${calculation.simulation.isImpact ? "Yes" : "No"}'),
              Text('Flank: ${calculation.simulation.isFlank ? "Yes" : "No"}'),
              Text('Rear: ${calculation.simulation.isRear ? "Yes" : "No"}'),
              const SizedBox(height: 8),
              Text(
                'Results:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'Expected Wounds: ${calculation.simulation.getExpectedWounds()}'),
              Text(
                  'Expected Stands Lost: ${calculation.simulation.getExpectedStandsLost()}'),
              Text(
                  'Breaking Probability: ${(calculation.simulation.breakingProbability * 100).toStringAsFixed(1)}%'),
              const SizedBox(height: 8),
              Text(
                'Saved: ${_formatDateTime(calculation.savedAt)}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
