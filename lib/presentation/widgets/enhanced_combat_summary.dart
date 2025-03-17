import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../utils/combat_calculator_utils.dart';
import '../../domain/models/combat_simulation.dart';
import '../../presentation/providers/combat_provider.dart';

class EnhancedCombatSummary extends StatefulWidget {
  final CombatState state;

  const EnhancedCombatSummary({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  State<EnhancedCombatSummary> createState() => _EnhancedCombatSummaryState();
}

class _EnhancedCombatSummaryState extends State<EnhancedCombatSummary> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    // Don't show anything if the simulation is null
    if (widget.state.simulation == null) return const SizedBox.shrink();

    // Calculate values for impact attacks if applicable
    bool hasImpact =
        widget.state.isImpact && (widget.state.attacker?.hasImpact() ?? false);

    int totalImpacts = hasImpact
        ? CombatCalculatorUtils.calculateTotalImpacts(widget.state)
        : 0;

    double expectedImpactHits = hasImpact
        ? CombatCalculatorUtils.calculateExpectedImpactHits(widget.state)
        : 0.0;

    double expectedImpactWounds = hasImpact
        ? CombatCalculatorUtils.calculateExpectedImpactWounds(widget.state)
        : 0.0;

    int expectedImpactStandsLost =
        (expectedImpactWounds / (widget.state.defender?.wounds ?? 1)).floor();

    // Calculate regular attack values
    int totalAttacks =
        CombatCalculatorUtils.calculateTotalAttacks(widget.state);
    double expectedHits =
        CombatCalculatorUtils.calculateExpectedHits(widget.state);
    double expectedWounds =
        CombatCalculatorUtils.calculateExpectedWounds(widget.state);
    int expectedStandsLost =
        (expectedWounds / (widget.state.defender?.wounds ?? 1)).floor();

    // Calculate totals
    double totalExpectedWounds = expectedImpactWounds + expectedWounds;
    int totalExpectedStandsLost = expectedImpactStandsLost + expectedStandsLost;
    double breakingProbability =
        widget.state.simulation!.breakingProbability * 100;

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
          // Total Summary Header - Always visible
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
                    IconButton(
                      icon: Icon(
                        _showDetails ? Icons.expand_less : Icons.expand_more,
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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTotalStat(
                        'Total Attacks', '${totalImpacts + totalAttacks}'),
                    _buildTotalStat('Expected Wounds',
                        totalExpectedWounds.toStringAsFixed(1)),
                    _buildTotalStat('Stands Lost', '$totalExpectedStandsLost'),
                    _buildTotalStat(
                      'Breaking',
                      '${breakingProbability.toStringAsFixed(1)}%',
                      color: _getBreakingColor(breakingProbability),
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
                        _buildDetailStat('Stands', '$expectedImpactStandsLost'),
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
                      _buildDetailStat('Stands', '$expectedStandsLost'),
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
  Widget _buildTotalStat(String label, String value, {Color? color}) {
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
}
