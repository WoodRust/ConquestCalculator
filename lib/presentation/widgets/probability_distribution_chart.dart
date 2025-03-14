// lib/presentation/widgets/probability_distribution_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/probability_distribution.dart';

class ProbabilityDistributionChart extends StatelessWidget {
  final ProbabilityDistribution distribution;
  final String title;
  final double width;
  final double height;
  final List<Threshold> thresholds;
  final bool showCumulative;
  final Color primaryColor;
  final Color secondaryColor;
  final int maxXValue;

  const ProbabilityDistributionChart({
    Key? key,
    required this.distribution,
    required this.title,
    this.width = 400,
    this.height = 200,
    this.thresholds = const [],
    this.showCumulative = false,
    this.primaryColor = Colors.deepPurple,
    this.secondaryColor = Colors.deepPurpleAccent,
    this.maxXValue = -1, // -1 means auto-calculate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate max X value if not specified
    final int effectiveMaxX =
        maxXValue > 0 ? maxXValue : _calculateEffectiveMaxX(distribution);

    // Make a copy of the distribution up to our max X value and ensure it's List<double>
    final List<double> probabilities =
        distribution.probabilities.length > effectiveMaxX
            ? List<double>.from(
                distribution.probabilities.sublist(0, effectiveMaxX + 1))
            : List<double>.from(distribution.probabilities);

    final List<double> cumulativeProbabilities =
        showCumulative ? _calculateCumulativeProbabilities(probabilities) : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        // Stats row
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Mean: ${distribution.mean.toStringAsFixed(1)}'),
              Text(
                  'Std Dev: ${distribution.standardDeviation.toStringAsFixed(1)}'),
              Text('Dice: ${distribution.diceCount}'),
            ],
          ),
        ),

        // Chart
        SizedBox(
          width: width,
          height: height,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: showCumulative ? 1.0 : _calculateMaxY(probabilities),
              minY: 0,
              groupsSpace: 4,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.black87,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String label = showCumulative
                        ? 'P(X ≤ ${groupIndex}) = ${(rod.toY * 100).toStringAsFixed(1)}%'
                        : 'P(X = ${groupIndex}) = ${(rod.toY * 100).toStringAsFixed(1)}%';

                    // Add threshold information if applicable
                    for (final threshold in thresholds) {
                      if (threshold.value == groupIndex) {
                        label += '\n${threshold.label}';
                        break;
                      }
                    }

                    return BarTooltipItem(
                      label,
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Only show some X labels to avoid clutter
                      if (value.toInt() %
                              _calculateXLabelInterval(effectiveMaxX) !=
                          0) {
                        return const Text('');
                      }

                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      );
                    },
                    reservedSize: 28,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      if (value == 0) return const Text('0%');

                      return Text(
                        '${(value * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 0.2 == 0,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.black12,
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  // Highlight threshold lines
                  bool isThreshold = thresholds.any((t) => t.value == value);
                  return FlLine(
                    color: isThreshold
                        ? Colors.red.withOpacity(0.3)
                        : Colors.black12,
                    strokeWidth: isThreshold ? 2 : 1,
                    dashArray: isThreshold ? [5, 5] : null,
                  );
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black26),
              ),
              barGroups: _createBarGroups(
                showCumulative ? cumulativeProbabilities : probabilities,
                effectiveMaxX,
              ),
            ),
          ),
        ),

        // Threshold legend
        if (thresholds.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: thresholds.map((threshold) {
                return Chip(
                  label: Text(
                    '${threshold.label}: ${threshold.value}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: threshold.color.withOpacity(0.2),
                  side: BorderSide(color: threshold.color),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  // Helper methods

  // Calculate a reasonable max X value to display
  int _calculateEffectiveMaxX(ProbabilityDistribution distribution) {
    // Start by finding the last non-zero probability
    int lastNonZero = distribution.probabilities.length - 1;
    while (lastNonZero > 0 && distribution.probabilities[lastNonZero] < 0.001) {
      lastNonZero--;
    }

    // Cap at distribution.mean + 3 * standardDeviation to show the meaningful part
    int statisticalMax =
        (distribution.mean + 3 * distribution.standardDeviation).ceil();

    // Return the smaller of the two values, but at least 1
    return max(min(lastNonZero, statisticalMax), 1);
  }

  // Calculate the interval for X axis labels to avoid crowding
  int _calculateXLabelInterval(int maxX) {
    if (maxX <= 5) return 1;
    if (maxX <= 10) return 2;
    if (maxX <= 20) return 5;
    if (maxX <= 50) return 10;
    return 20;
  }

  // Calculate max Y value for the chart
  double _calculateMaxY(List<double> probabilities) {
    double maxProb = 0.0;
    for (final prob in probabilities) {
      if (prob > maxProb) maxProb = prob;
    }

    // Round up to next 0.1 increment
    return ((maxProb * 10).ceil() / 10) + 0.05;
  }

  // Calculate cumulative probabilities for the chart
  List<double> _calculateCumulativeProbabilities(List<double> probabilities) {
    List<double> cumulative = List<double>.from(probabilities);
    for (int i = 1; i < cumulative.length; i++) {
      cumulative[i] += cumulative[i - 1];
    }
    return cumulative;
  }

  // Create bar groups for FL Chart
  List<BarChartGroupData> _createBarGroups(List<double> values, int maxX) {
    List<BarChartGroupData> groups = [];

    for (int i = 0; i <= maxX; i++) {
      // If we're beyond the distribution's array, use zero
      double value = i < values.length ? values[i] : 0.0;

      // Check if this is a threshold value
      bool isThreshold = thresholds.any((t) => t.value == i);

      // Create bar
      groups.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
              toY: value,
              color: isThreshold ? Colors.red : primaryColor,
              width: 8,
              borderRadius: BorderRadius.circular(0),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 1,
                color: Colors.grey.withOpacity(0.1),
              )),
        ],
      ));
    }

    return groups;
  }
}

// Helper class for thresholds
class Threshold {
  final int value;
  final String label;
  final Color color;

  const Threshold({
    required this.value,
    required this.label,
    this.color = Colors.red,
  });
}

// Extension to simplify getting min/max
int max(int a, int b) => a > b ? a : b;
int min(int a, int b) => a < b ? a : b;
