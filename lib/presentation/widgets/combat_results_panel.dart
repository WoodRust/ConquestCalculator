// lib/presentation/widgets/combat_results_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../utils/combat_calculator_utils.dart';
import 'probability_distribution_chart.dart' as chart;
import 'summary_row.dart';
import '../themes/app_theme.dart';
import 'enhanced_combat_summary.dart';

class CombatResultsPanel extends ConsumerWidget {
  const CombatResultsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);
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
                            CombatCalculatorUtils.calculateTotalAttacks(
                                combatState),
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

                  // Enhanced Combat Summary - NEW WIDGET INTEGRATION
                  EnhancedCombatSummary(state: combatState),

                  // Stand loss probabilities section
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.claudeSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.claudeBorder),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stand Loss Probabilities',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),

                        // Generate stand loss probabilities dynamically based on defender stand count
                        ..._buildStandLossProbabilities(context, combatState),

                        // Show effective stand counts when characters are attached
                        if (combatState.attackerCharacter != null ||
                            combatState.defenderCharacter != null ||
                            combatState.attacker?.isCharacter() == true ||
                            combatState.defender?.isCharacter() == true) ...[
                          const SizedBox(height: 8),
                          const Divider(color: AppTheme.claudeBorder),
                          const SizedBox(height: 8),
                          Text(
                            'Stand Counts (including characters)',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          SummaryRow(
                            label: 'Attacker Effective Stands:',
                            value:
                                combatState.effectiveAttackerStands.toString(),
                          ),
                          SummaryRow(
                            label: 'Defender Effective Stands:',
                            value:
                                combatState.effectiveDefenderStands.toString(),
                          ),
                          SummaryRow(
                            label: 'Defender Stands to Break:',
                            value: combatState.simulation!.standsToBreak
                                .toString(),
                          ),
                        ],
                      ],
                    ),
                  ),
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

  Color _getBreakingProbabilityColor(double probability) {
    return AppTheme.getProbabilityColor(probability);
  }

  // Build a list of stand loss probability rows
  List<Widget> _buildStandLossProbabilities(
      BuildContext context, CombatState state) {
    final List<Widget> rows = [];

    // Get needed values
    final simulation = state.simulation!;
    final defender = state.defender!;
    final int standCount = defender.isCharacter() ? 1 : state.numDefenderStands;
    final int woundsPerStand = defender.wounds;
    final int standsToBreak = simulation.standsToBreak;

    // Calculate probability of losing 0 stands (fewer wounds than needed to destroy 1 stand)
    final totalDistribution = simulation.totalDamageDistribution!;
    double noLossProbability = 0.0;
    for (int i = 0;
        i < woundsPerStand && i < totalDistribution.probabilities.length;
        i++) {
      noLossProbability += totalDistribution.probabilities[i];
    }

    // Add "Lose 0 Stands" row with appropriate coloring (always green as it's good for defender)
    rows.add(
      SummaryRow(
        label: 'Lose 0 Stands:',
        value: '${(noLossProbability * 100).toStringAsFixed(1)}%',
        color: AppTheme.noLossColor,
      ),
    );

    // For each stand up to the total stand count
    for (int i = 1; i <= standCount; i++) {
      // Create the label based on whether this is the breaking point
      String label = 'Lose $i Stand${i > 1 ? 's' : ''}:';
      if (i == standsToBreak) {
        label = 'Breaking ($i Stand${i > 1 ? 's' : ''}):';
      } else if (i == standCount) {
        label = 'Destruction ($i Stand${i > 1 ? 's' : ''}):';
      }

      // Calculate the probability for this stand loss
      double probability;
      if (i == standCount) {
        // For total destruction - use probability of losing at least all stands
        probability = simulation.getProbabilityOfLosingAtLeast(standCount);
      } else {
        // For losing exactly i stands
        probability = simulation.getProbabilityOfLosing(i);
      }

      // Use the standardized getThresholdColor method for consistent threshold-based coloring
      Color textColor =
          AppTheme.getThresholdColor(i, standCount, standsToBreak);

      rows.add(
        SummaryRow(
          label: label,
          value: '${(probability * 100).toStringAsFixed(1)}%',
          color: textColor,
        ),
      );
    }

    return rows;
  }
}
