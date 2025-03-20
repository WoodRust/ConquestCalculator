import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'dart:math' as math;

/// Utility class for probability calculations
class ProbabilityCalculator {
  /// Calculate a binomial probability distribution
  ProbabilityDistribution calculateBinomialDistribution({
    required int dice,
    required int targetValue,
  }) {
    return ProbabilityDistribution.binomial(
      dice: dice,
      targetValue: targetValue,
    );
  }

  /// Calculate probability distribution with rerolls
  ProbabilityDistribution calculateDistributionWithRerolls({
    required int dice,
    required int target,
    bool rerollFails = false,
    bool rerollOnes = false,
  }) {
    // Calculate base success probability
    double pSuccess = target / 6.0;

    // Calculate adjusted probability with rerolls
    double adjustedProbability;

    if (rerollFails) {
      // Probability after rerolling failures:
      // P' = P + (1-P)*P = P(2-P)
      adjustedProbability = pSuccess + (1 - pSuccess) * pSuccess;
    } else if (rerollOnes) {
      // Probability after rerolling only 1s:
      // P' = P + (1/6)*P
      adjustedProbability = pSuccess + (1 / 6) * pSuccess;
    } else {
      adjustedProbability = pSuccess;
    }

    // Use standard binomial with adjusted probability
    double mean = dice * adjustedProbability;
    double variance = dice * adjustedProbability * (1 - adjustedProbability);
    double stdDev = math.sqrt(variance);

    // Generate approximate probability distribution
    List<double> probabilities = List<double>.filled(dice + 1, 0.0);
    for (int k = 0; k <= dice; k++) {
      probabilities[k] = _binomialProbability(dice, k, adjustedProbability);
    }

    return ProbabilityDistribution(
      probabilities: probabilities,
      mean: mean,
      standardDeviation: stdDev,
      diceCount: dice,
      targetValue: target,
    );
  }

  /// Combine two probability distributions
  ProbabilityDistribution combineProbabilityDistributions(
    ProbabilityDistribution dist1,
    ProbabilityDistribution dist2, {
    int? maxOutcome,
  }) {
    return ProbabilityDistribution.combine(
      dist1,
      dist2,
      maxOutcome: maxOutcome,
    );
  }

  /// Helper for binomial probability mass function
  double _binomialProbability(int n, int k, double p) {
    if (k < 0 || k > n) return 0.0;
    if (p == 0.0) return (k == 0) ? 1.0 : 0.0;
    if (p == 1.0) return (k == n) ? 1.0 : 0.0;

    // Calculate binomial coefficient
    double coefficient = 1.0;
    for (int i = 0; i < k; i++) {
      coefficient *= (n - i) / (i + 1);
    }

    // Calculate probability
    return coefficient * math.pow(p, k) * math.pow(1 - p, n - k);
  }
}
