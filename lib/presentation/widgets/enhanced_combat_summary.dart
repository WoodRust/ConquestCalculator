// lib/presentation/widgets/enhanced_combat_summary.dart
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../../presentation/providers/combat_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

class EnhancedCombatSummary extends ConsumerStatefulWidget {
  final CombatState state;

  const EnhancedCombatSummary({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  ConsumerState<EnhancedCombatSummary> createState() =>
      _EnhancedCombatSummaryState();
}

class _EnhancedCombatSummaryState extends ConsumerState<EnhancedCombatSummary> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    // Don't show anything if the simulation is null
    if (widget.state.simulation == null) return const SizedBox.shrink();

    // Get the combat facade for calculations
    final combatFacade = ref.read(combatFacadeProvider);

    // Calculate values for impact attacks if applicable
    bool hasImpact =
        widget.state.isImpact && (widget.state.attacker?.hasImpact() ?? false);

    int totalImpacts =
        hasImpact ? combatFacade.calculateTotalImpacts(widget.state) : 0;

    double expectedImpactHits = hasImpact
        ? combatFacade.calculateExpectedImpactHits(widget.state)
        : 0.0;

    double expectedImpactWounds = hasImpact
        ? combatFacade.calculateExpectedImpactWounds(widget.state)
        : 0.0;

    double expectedImpactStandsLost =
        (expectedImpactWounds / (widget.state.defender?.wounds ?? 1));

    // Calculate regular attack values
    int totalAttacks = combatFacade.calculateTotalAttacks(widget.state);
    double expectedHits = combatFacade.calculateExpectedHits(widget.state);
    double expectedWounds = combatFacade.calculateExpectedWounds(widget.state);
    double expectedStandsLost =
        (expectedWounds / (widget.state.defender?.wounds ?? 1));

    // Calculate totals
    double totalExpectedWounds = expectedImpactWounds + expectedWounds;
    double totalExpectedStandsLost =
        expectedImpactStandsLost + expectedStandsLost;

    // Calculate key probability values
    double oneStandLossProbability = 0.0;
    double breakingProbability =
        widget.state.simulation!.breakingProbability * 100;
    double destructionProbability = 0.0;

    final totalDistribution = widget.state.simulation!.totalDamageDistribution;
    if (totalDistribution != null && widget.state.defender != null) {
      // Calculate probability of losing at least 1 stand
      int woundsForOneStand = widget.state.defender!.wounds;
      oneStandLossProbability =
          totalDistribution.getProbabilityOfExceeding(woundsForOneStand - 1) *
              100;

      // Calculate probability of destruction (losing all stands)
      int woundsToDestroy =
          widget.state.defender!.wounds * widget.state.numDefenderStands;
      destructionProbability =
          totalDistribution.getProbabilityOfExceeding(woundsToDestroy - 1) *
              100;

      // Add this logging for debugging
      print("UI Display - Expected Wounds: $totalExpectedWounds");
      print("  Direct Wounds: $expectedWounds");
      print("  Impact Wounds: $expectedImpactWounds");
      print("  1+ Stand Loss Probability: $oneStandLossProbability%");
      print("  Breaking Probability: $breakingProbability%");
      print("  Destruction Probability: $destructionProbability%");
    }

    return Card(
      elevation: 0,
      color: AppTheme.claudeCardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppTheme.claudeBorder, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Summary Header - Always visible with Total Attacks in the top row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.claudePrimary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              border: const Border(
                bottom: BorderSide(color: AppTheme.claudeBorder),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with title, total attacks and expand/collapse button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Combined Combat Effect',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.claudePrimary,
                      ),
                    ),
                    Row(
                      children: [
                        _buildTotalStat(
                            'Total Attacks', '${totalImpacts + totalAttacks}',
                            isCompact: true),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            _showDetails
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: AppTheme.claudePrimary,
                          ),
                          onPressed: () {
                            setState(() {
                              _showDetails = !_showDetails;
                            });
                          },
                          tooltip: _showDetails ? 'Show less' : 'Show details',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTotalStat(
                        'Wounds', totalExpectedWounds.toStringAsFixed(1)),
                    _buildTotalStat('Stands Lost',
                        totalExpectedStandsLost.toStringAsFixed(1)),
                    _buildTotalStat(
                      '1+ Stands',
                      '${oneStandLossProbability.toStringAsFixed(1)}%',
                      color: AppTheme.singleStandLossColor,
                    ),
                    _buildTotalStat(
                      'Breaking',
                      '${breakingProbability.toStringAsFixed(1)}%',
                      color: AppTheme.breakingColor,
                    ),
                    _buildTotalStat(
                      'Destruction',
                      '${destructionProbability.toStringAsFixed(1)}%',
                      color: AppTheme.destroyedColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Expanded Details Section - Only visible when expanded
          if (_showDetails)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Impact Attacks Section (if applicable)
                  if (hasImpact) ...[
                    _buildSectionHeader(
                        'Impact Attacks', Colors.green.shade700),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDetailStat('Attacks', '$totalImpacts'),
                        _buildDetailStat(
                            'Hits', expectedImpactHits.toStringAsFixed(1)),
                        _buildDetailStat(
                            'Wounds', expectedImpactWounds.toStringAsFixed(1)),
                        _buildDetailStat('Stands',
                            expectedImpactStandsLost.toStringAsFixed(1)),
                      ],
                    ),
                    const Divider(height: 32),
                  ],

                  // Regular Attacks Section
                  _buildSectionHeader('Regular Attacks', Colors.blue.shade700),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDetailStat('Attacks', '$totalAttacks'),
                      _buildDetailStat('Hits', expectedHits.toStringAsFixed(1)),
                      _buildDetailStat(
                          'Wounds', expectedWounds.toStringAsFixed(1)),
                      _buildDetailStat(
                          'Stands', expectedStandsLost.toStringAsFixed(1)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Helper widget for the total stats in header
  Widget _buildTotalStat(String label, String value,
      {Color? color, bool isCompact = false}) {
    if (isCompact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.claudeSurface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppTheme.claudeBorder.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.claudeSubtleText,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color ?? AppTheme.claudeText,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.claudeSubtleText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? AppTheme.claudeText,
          ),
        ),
      ],
    );
  }

  // Helper widget for detail stats
  Widget _buildDetailStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.claudeSubtleText,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper widget for section headers
  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  // Helper method to determine breaking probability color
  Color _getBreakingColor(double probability) {
    if (probability < 25) return AppTheme.noLossColor;
    if (probability < 50) return AppTheme.singleStandLossColor;
    if (probability < 75) return AppTheme.breakingColor;
    return AppTheme.destroyedColor;
  }

  // Helper method to determine destruction probability color
  Color _getDestructionColor(double probability) {
    if (probability < 10) return AppTheme.noLossColor;
    if (probability < 25) return AppTheme.singleStandLossColor;
    if (probability < 50) return AppTheme.breakingColor;
    return AppTheme.destroyedColor;
  }

  // Helper method to determine stand loss probability color
  Color _getStandLossColor(double probability) {
    if (probability < 30) return AppTheme.noLossColor;
    if (probability < 60) return AppTheme.singleStandLossColor;
    if (probability < 80) return AppTheme.breakingColor;
    return AppTheme.destroyedColor;
  }
}
