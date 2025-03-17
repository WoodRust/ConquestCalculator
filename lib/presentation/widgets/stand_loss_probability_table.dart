import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../providers/combat_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StandLossProbabilityTable extends ConsumerWidget {
  const StandLossProbabilityTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);

    // Don't show anything if there's no simulation or distribution
    if (combatState.simulation == null ||
        combatState.simulation!.totalDamageDistribution == null ||
        combatState.defender == null) {
      return const SizedBox.shrink();
    }

    final totalDistribution = combatState.simulation!.totalDamageDistribution!;
    final defender = combatState.defender!;
    final woundsPerStand = defender.wounds;
    final standCount =
        defender.isCharacter() ? 1 : combatState.numDefenderStands;
    final standsToBreak = combatState.simulation!.standsToBreak;

    // Calculate probability for each stand loss outcome
    List<StandLossProbability> probabilities = [];

    for (int i = 0; i <= standCount; i++) {
      double probability;

      if (i == 0) {
        // Probability of no stands lost (0 to woundsPerStand-1 wounds)
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

      String label;
      if (i == 0) {
        label = "Lose 0 Stands:";
      } else if (i == standsToBreak) {
        label = "Breaking ($i Stand${i > 1 ? 's' : ''}):";
      } else if (i == standCount) {
        label = "Destruction ($i Stand${i > 1 ? 's' : ''}):";
      } else {
        label = "Lose $i Stand${i > 1 ? 's' : ''}:";
      }

      probabilities.add(StandLossProbability(
        standCount: i,
        probability: probability * 100, // Convert to percentage
        label: label,
        totalStands: standCount,
        standsToBreak: standsToBreak,
      ));
    }

    return Container(
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

          // Table with alternate row colors and distribution bars
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.claudeBorder.withOpacity(0.5)),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(5), // Stand loss label
                  1: FlexColumnWidth(2), // Probability value
                  2: FlexColumnWidth(4), // Distribution bar
                },
                children: [
                  // Optional header row
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: const Border(
                        bottom: BorderSide(
                          color: AppTheme.claudeBorder,
                          width: 1,
                        ),
                      ),
                    ),
                    children: const [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Text(
                          'Stand Loss',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.claudeSubtleText,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Text(
                          'Probability',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.claudeSubtleText,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Text(
                          'Distribution',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.claudeSubtleText,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Probability rows
                  ...probabilities.map((prob) => TableRow(
                        decoration: BoxDecoration(
                          color: _getRowBackgroundColor(prob.standCount,
                              prob.totalStands, prob.standsToBreak),
                          border: const Border(
                            bottom: BorderSide(
                              color: AppTheme.claudeBorder,
                              width: 0.5,
                            ),
                          ),
                        ),
                        children: [
                          // Stand loss label
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            child: Text(
                              prob.label,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: _getThresholdColor(prob.standCount,
                                    prob.totalStands, prob.standsToBreak),
                              ),
                            ),
                          ),

                          // Probability percentage
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 4),
                            child: Text(
                              '${prob.probability.toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getThresholdColor(prob.standCount,
                                    prob.totalStands, prob.standsToBreak),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),

                          // Distribution bar
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  width: constraints.maxWidth,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (prob.probability / 100)
                                        .clamp(0.0, 1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _getThresholdColor(
                                            prob.standCount,
                                            prob.totalStands,
                                            prob.standsToBreak),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get threshold color based on AppTheme
  Color _getThresholdColor(int standCount, int totalStands, int standsToBreak) {
    if (standCount == 0) return AppTheme.noLossColor;
    if (standCount == totalStands) return AppTheme.destroyedColor;
    if (standCount >= standsToBreak) return AppTheme.breakingColor;
    return AppTheme.singleStandLossColor;
  }

  // Helper method to get background color
  Color _getRowBackgroundColor(
      int standCount, int totalStands, int standsToBreak) {
    final thresholdColor =
        _getThresholdColor(standCount, totalStands, standsToBreak);
    return thresholdColor.withOpacity(0.05);
  }
}

// A simple data class to hold stand loss probability information
class StandLossProbability {
  final int standCount;
  final double probability;
  final String label;
  final int totalStands;
  final int standsToBreak;

  StandLossProbability({
    required this.standCount,
    required this.probability,
    required this.label,
    required this.totalStands,
    required this.standsToBreak,
  });
}
