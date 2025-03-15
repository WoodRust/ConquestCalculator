// lib/presentation/screens/combat_calculator_screen.dart
import 'package:conquest_calculator/presentation/widgets/unit_selection_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../widgets/unit_selection_panel.dart';
import '../widgets/combat_results_panel.dart';
import '../widgets/saved_calculations_panel.dart';

class CombatCalculatorScreen extends ConsumerWidget {
  const CombatCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Combat Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: combatState.simulation != null
                ? () => _showSaveDialog(context, combatNotifier)
                : null,
            tooltip: 'Save calculation',
          ),
          IconButton(
            icon: Icon(combatState.showCumulativeDistribution
                ? Icons.show_chart
                : Icons.bar_chart),
            onPressed: () => combatNotifier.toggleCumulativeDistribution(
                !combatState.showCumulativeDistribution),
            tooltip: combatState.showCumulativeDistribution
                ? 'Show probability mass function'
                : 'Show cumulative distribution',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unit Selection Panel (now includes combat modifiers)
              const UnitSelectionPanel(),

              // Combat Results Panel
              const CombatResultsPanel(),

              // Saved Calculations Panel
              const SavedCalculationsPanel(),
            ],
          ),
        ),
      ),
    );
  }

  void _showSaveDialog(BuildContext context, CombatNotifier notifier) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Calculation'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter a name for this calculation',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                notifier.saveCurrentCalculation(textController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
