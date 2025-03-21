// lib/presentation/widgets/combat_results_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import 'probability_distribution_chart.dart' as chart;
import '../themes/app_theme.dart';
import 'enhanced_combat_summary.dart';
import 'stand_loss_probability_table.dart';

class CombatResultsPanel extends ConsumerWidget {
  const CombatResultsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);
    final combatFacade = ref.read(combatFacadeProvider);
    final hasSimulation = combatState.simulation != null &&
        combatState.simulation!.totalDamageDistribution != null;

    return Card(
      elevation: 0,
      color: AppTheme.claudeCardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppTheme.claudeBorder, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Always show the heading and Calculate button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Combat Results',
                    style: Theme.of(context).textTheme.titleLarge),
                ElevatedButton.icon(
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.claudePrimary,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () {
                    // Only calculate if both units are selected
                    if (combatState.attacker != null &&
                        combatState.defender != null) {
                      combatNotifier.calculateCombat();
                    } else {
                      // Show a snackbar if units aren't selected
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please select both attacker and defender units'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Show either the placeholder message or results based on simulation status
            if (!hasSimulation)
              // Placeholder message when no simulation exists
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.claudeSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.claudeBorder),
                ),
                padding: const EdgeInsets.all(24),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calculate_outlined,
                        size: 48,
                        color: AppTheme.claudeSubtleText.withAlpha(179)),
                    const SizedBox(height: 16),
                    const Text(
                      'Select units and configure combat to calculate probabilities',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.claudeSubtleText),
                    ),
                  ],
                ),
              )
            else
              // Full results when simulation exists
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total damage distribution chart
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.claudeSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.claudeBorder),
                    ),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ClipRect(
                      child: chart.ProbabilityDistributionChart(
                        distribution:
                            combatState.simulation!.totalDamageDistribution!,
                        title: 'Wound Distribution',
                        width: MediaQuery.of(context).size.width - 72,
                        height: 250,
                        showCumulative: combatState.showCumulativeDistribution,
                        // Calculate total attacks for realistic max wounds
                        attackerAttacks:
                            combatFacade.calculateTotalAttacks(combatState),
                        // Generate thresholds for each stand and breaking point
                        thresholds: _generateStandThresholds(
                          combatState.defender!.wounds,
                          combatState.defender!.isCharacter()
                              ? 1
                              : combatState.numDefenderStands,
                          combatState.simulation!.standsToBreak,
                        ),
                        primaryColor: AppTheme.claudePrimary.withAlpha(179),
                        secondaryColor: AppTheme.claudePrimary.withAlpha(102),
                      ),
                    ),
                  ),

                  // Enhanced Combat Summary
                  EnhancedCombatSummary(state: combatState),

                  // Stand loss probabilities section - using our new table widget
                  const SizedBox(height: 16),
                  const StandLossProbabilityTable(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Generate threshold markers for each stand
  List<chart.Threshold> _generateStandThresholds(
      int woundsPerStand, int totalStands, int standsToBreak) {
    final List<chart.Threshold> thresholds = [];

    // Generate a threshold for each stand
    for (int i = 1; i <= totalStands; i++) {
      final int standThreshold = i * woundsPerStand;

      // Determine color and label based on the stand count
      String label;

      if (i == totalStands) {
        label = 'Destroyed';
      } else if (i == standsToBreak) {
        label = 'Breaking';
      } else {
        label = '$i Stand${i > 1 ? 's' : ''}';
      }

      // Use the standardized color scheme from AppTheme
      Color thresholdColor =
          AppTheme.getThresholdColor(i, totalStands, standsToBreak);

      thresholds.add(chart.Threshold(
        value: standThreshold,
        label: label,
        color: thresholdColor,
      ));
    }

    return thresholds;
  }
}
