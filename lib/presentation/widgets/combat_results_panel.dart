// lib/presentation/widgets/combat_results_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../utils/combat_calculator_utils.dart';
import 'probability_distribution_chart.dart' as chart;
import 'summary_row.dart';
import '../themes/app_theme.dart';
import 'enhanced_combat_summary.dart';
import 'dart:math' as math;

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

                  // Enhanced Combat Summary
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

                        // Generate stand loss probabilities based on the combined expected wounds
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

  // Build a list of stand loss probability rows with proper calculation of combined wounds
  List<Widget> _buildStandLossProbabilities(
      BuildContext context, CombatState state) {
    final List<Widget> rows = [];

    // Get needed values
    final simulation = state.simulation!;
    final defender = state.defender!;
    final int standCount = defender.isCharacter() ? 1 : state.numDefenderStands;
    final int woundsPerStand = defender.wounds;
    final int standsToBreak = simulation.standsToBreak;

    // Calculate total expected wounds from both impact and regular attacks
    final hasImpact = state.isImpact && (state.attacker?.hasImpact() ?? false);

    double expectedImpactWounds = 0.0;
    double expectedRegularWounds = 0.0;

    if (hasImpact) {
      expectedImpactWounds =
          CombatCalculatorUtils.calculateExpectedImpactWounds(state);
    }

    expectedRegularWounds =
        CombatCalculatorUtils.calculateExpectedWounds(state);

    // Total expected wounds combining both sources
    double totalExpectedWounds = expectedImpactWounds + expectedRegularWounds;

    // For logging/debugging
    print('Expected Impact Wounds: $expectedImpactWounds');
    print('Expected Regular Wounds: $expectedRegularWounds');
    print('Total Expected Wounds: $totalExpectedWounds');

    // Calculate the number of stands we expect to lose based on total wounds
    double expectedStandsLost = totalExpectedWounds / woundsPerStand;

    // Get the probability distribution from the simulation
    final totalDistribution = simulation.totalDamageDistribution!;

    // Calculate probabilities for each stand loss outcome

    // First we need the total probability mass to normalize with
    double totalProbability = 0.0;

    // Create a map to hold our stand loss probabilities
    Map<int, double> standLossProbabilities = {};

    // Calculate probability for each possible stand loss outcome
    for (int i = 0; i <= standCount; i++) {
      double probability;

      if (i == 0) {
        // Probability of no stands lost
        probability = 0.0;
        for (int j = 0;
            j < woundsPerStand && j < totalDistribution.probabilities.length;
            j++) {
          probability += totalDistribution.probabilities[j];
        }
      } else if (i == standCount) {
        // Probability of all stands lost (regiment destroyed)
        probability = totalDistribution
            .getProbabilityOfExceeding(standCount * woundsPerStand - 1);
      } else {
        // Probability of losing exactly i stands
        int minWounds = i * woundsPerStand;
        int maxWounds = (i + 1) * woundsPerStand - 1;

        probability = 0.0;
        for (int j = minWounds;
            j <= maxWounds && j < totalDistribution.probabilities.length;
            j++) {
          probability += totalDistribution.probabilities[j];
        }
      }

      standLossProbabilities[i] = probability;
      totalProbability += probability;
    }

    // Normalize probabilities to ensure they sum to 1.0
    // This is important if the distribution doesn't cover all possibilities
    if (totalProbability > 0 &&
        (totalProbability < 0.99 || totalProbability > 1.01)) {
      for (int i = 0; i <= standCount; i++) {
        standLossProbabilities[i] =
            standLossProbabilities[i]! / totalProbability;
      }
    }

    // Add rows for each stand loss probability
    for (int i = 0; i <= standCount; i++) {
      String label;
      if (i == 0) {
        label = 'Lose 0 Stands:';
      } else if (i == standsToBreak) {
        label = 'Breaking ($i Stand${i > 1 ? 's' : ''}):';
      } else if (i == standCount) {
        label = 'Destruction ($i Stand${i > 1 ? 's' : ''}):';
      } else {
        label = 'Lose $i Stand${i > 1 ? 's' : ''}:';
      }

      Color textColor = i == 0
          ? AppTheme.noLossColor
          : AppTheme.getThresholdColor(i, standCount, standsToBreak);

      rows.add(
        SummaryRow(
          label: label,
          value: '${(standLossProbabilities[i]! * 100).toStringAsFixed(1)}%',
          color: textColor,
        ),
      );
    }

    return rows;
  }
}
