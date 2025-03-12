// lib/presentation/screens/combat_calculator_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../widgets/wave_slider.dart';
import '../widgets/target_selector.dart';

class CombatCalculatorScreen extends ConsumerWidget {
  const CombatCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    // If we don't have a simulation yet, show a placeholder
    if (combatState.simulation == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Combat Calculator'),
        ),
        body: const Center(
          child: Text('Select units to calculate combat probabilities'),
        ),
      );
    }

    // Otherwise, show the combat visualization
    final simulation = combatState.simulation!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Combat Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Combat setup controls (simplified for now)
            Row(
              children: [
                Text('Number of Attacking Stands: '),
                TargetSelector(
                  selectionLimit: 10,
                  initialValue: combatState.numAttackerStands,
                  onChanged: (value) =>
                      combatNotifier.updateAttackerStands(value),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Hit roll wave slider
            Text('Hit Roll', style: Theme.of(context).textTheme.headlineSmall),
            WaveSlider(
              width: MediaQuery.of(context).size.width - 32,
              height: 80,
              dragPercentage: 0.0,
              expectedSuccessPercentage:
                  simulation.hitRoll.successes / simulation.hitRoll.total,
              numDice: simulation.hitRoll.total,
              expectedSuccesses: simulation.hitRoll.successes.toDouble(),
              onChanged: (value) {}, // We're using it for display only
            ),

            const SizedBox(height: 16),

            // Defense roll wave slider
            Text('Defense Roll',
                style: Theme.of(context).textTheme.headlineSmall),
            WaveSlider(
              width: MediaQuery.of(context).size.width - 32,
              height: 80,
              dragPercentage: 0.0,
              expectedSuccessPercentage: simulation.defenseRoll.successes /
                  simulation.defenseRoll.total,
              numDice: simulation.defenseRoll.total,
              expectedSuccesses: simulation.defenseRoll.successes.toDouble(),
              onChanged: (value) {}, // We're using it for display only
            ),

            const SizedBox(height: 16),

            // Resolve roll wave slider
            Text('Resolve Roll',
                style: Theme.of(context).textTheme.headlineSmall),
            WaveSlider(
              width: MediaQuery.of(context).size.width - 32,
              height: 80,
              dragPercentage: 0.0,
              expectedSuccessPercentage: simulation.resolveRoll.successes /
                  simulation.resolveRoll.total,
              numDice: simulation.resolveRoll.total,
              expectedSuccesses: simulation.resolveRoll.successes.toDouble(),
              onChanged: (value) {}, // We're using it for display only
            ),

            const SizedBox(height: 24),

            // Results summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expected Wounds: ${simulation.defenseRoll.failures + simulation.resolveRoll.failures}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Probability of Breaking: ${_calculateBreakProbability(combatState)}%',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateBreakProbability(CombatState state) {
    if (state.simulation == null) return 0.0;

    final simulation = state.simulation!;
    final totalWounds =
        simulation.defenseRoll.failures + simulation.resolveRoll.failures;
    final standsLost = totalWounds ~/ state.defender!.wounds;

    // Simplified breaking calculation
    final standsRequired = (state.numDefenderStands / 2).ceil();
    if (standsLost >= standsRequired) {
      return 100.0;
    } else {
      // This is very simplified - a real implementation would use probability distributions
      return (standsLost / standsRequired * 100).clamp(0.0, 100.0);
    }
  }
}
