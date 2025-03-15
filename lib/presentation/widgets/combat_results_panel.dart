// lib/presentation/widgets/combat_results_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import 'probability_distribution_chart.dart' as chart;
import 'summary_row.dart';
import '../themes/app_theme.dart';

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
                        attackerAttacks: _calculateTotalAttacks(combatState),
                        // Don't limit the x-axis to defender's wounds - use intelligent limits
                        thresholds: [
                          // Stand loss threshold
                          chart.Threshold(
                            value: combatState.defender!.wounds,
                            label: '1 Stand',
                            color: Colors.orange.shade400,
                          ),
                          // Breaking threshold
                          chart.Threshold(
                            value: combatState.simulation!.standsToBreak *
                                combatState.defender!.wounds,
                            label: 'Breaking',
                            color: AppTheme.claudeDefenderAccent,
                          ),
                          // Total destruction
                          chart.Threshold(
                            value: (combatState.defender!.isCharacter()
                                    ? 1
                                    : combatState.numDefenderStands) *
                                combatState.defender!.wounds,
                            label: 'Destroyed',
                            color: AppTheme.claudePrimary,
                          ),
                        ],
                        primaryColor: AppTheme.claudePrimary.withAlpha(179),
                        secondaryColor: AppTheme.claudePrimary.withAlpha(102),
                      ),
                    ),
                  ),

                  // Results summary
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
                          'Combat Summary',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: AppTheme.claudeBorder),
                        const SizedBox(height: 8),
                        SummaryRow(
                          label: 'Expected Wounds:',
                          value: combatState.simulation!
                              .getExpectedWounds()
                              .toString(),
                        ),
                        SummaryRow(
                          label: 'Expected Stands Lost:',
                          value: combatState.simulation!
                              .getExpectedStandsLost()
                              .toString(),
                        ),
                        SummaryRow(
                          label: 'Breaking Probability:',
                          value:
                              '${(combatState.simulation!.breakingProbability * 100).toStringAsFixed(1)}%',
                          color: _getBreakingProbabilityColor(
                              combatState.simulation!.breakingProbability),
                        ),
                        SummaryRow(
                          label: 'Destruction Probability:',
                          value:
                              '${(combatState.simulation!.getProbabilityOfLosingAtLeast(combatState.defender!.isCharacter() ? 1 : combatState.numDefenderStands) * 100).toStringAsFixed(1)}%',
                        ),
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

  Color _getBreakingProbabilityColor(double probability) {
    if (probability < 0.25) return Colors.green.shade700;
    if (probability < 0.5) return Colors.orange.shade700;
    if (probability < 0.75) return Colors.deepOrange.shade700;
    return AppTheme.claudeDefenderAccent;
  }

  // Calculate total attacks to determine realistic maximum wounds
  int _calculateTotalAttacks(CombatState state) {
    if (state.attacker == null) return 0;

    // For a character, just use its attacks value
    if (state.attacker!.isCharacter()) {
      return state.attacker!.attacks;
    }

    // For regular regiments, calculate total attacks based on stands and support
    int baseAttacks = state.attacker!.attacks * state.numAttackerStands;

    // Add character attacks if present
    if (state.attackerCharacter != null) {
      baseAttacks += state.attackerCharacter!.attacks;
    }

    // For impact, use the impact value if available
    if (state.isImpact && state.attacker!.hasImpact()) {
      baseAttacks = state.attacker!.getImpact() * state.numAttackerStands;
      if (state.attackerCharacter != null &&
          state.attackerCharacter!.hasImpact()) {
        baseAttacks += state.attackerCharacter!.getImpact();
      }
    }

    return baseAttacks;
  }
}
