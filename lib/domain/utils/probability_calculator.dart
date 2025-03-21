import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'dart:math' as math;

/// Utility class for probability calculations
class ProbabilityCalculator {
  /// Calculate a binomial probability distribution
  ProbabilityDistribution calculateBinomialDistribution({
    required double dice,
    required int targetValue,
  }) {
    return ProbabilityDistribution.binomial(
      dice: dice,
      targetValue: targetValue,
    );
  }

  /// Calculate probability distribution with rerolls (failures or successes)
  ProbabilityDistribution calculateDistributionWithRerolls({
    required double dice, // Changed from int to double
    required int target,
    bool rerollFails = false,
    bool rerollSuccesses = false, // New parameter for flank/rear attacks
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
    } else if (rerollSuccesses) {
      // Probability after rerolling successes:
      // P' = P*P (need to succeed twice in a row)
      adjustedProbability = pSuccess * pSuccess;
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

    // Generate probability distribution
    int maxDice = dice.ceil();
    List<double> probabilities = List<double>.filled(maxDice + 1, 0.0);

    // Similar logic to the binomial factory method for handling fractional dice
    double fractionalPart = dice - dice.floor();

    if (fractionalPart < 0.0001) {
      // Essentially an integer
      for (int k = 0; k <= maxDice; k++) {
        probabilities[k] =
            _binomialProbability(maxDice, k, adjustedProbability);
      }
    } else {
      // Interpolate between floor and ceiling dice values
      int floorDice = dice.floor();

      List<double> lowerProbs = List<double>.filled(maxDice, 0.0);
      List<double> upperProbs = List<double>.filled(maxDice + 1, 0.0);

      for (int k = 0; k <= floorDice; k++) {
        lowerProbs[k] = _binomialProbability(floorDice, k, adjustedProbability);
      }

      for (int k = 0; k <= maxDice; k++) {
        upperProbs[k] = _binomialProbability(maxDice, k, adjustedProbability);
      }

      // Weighted average based on fractional part
      for (int k = 0; k <= maxDice; k++) {
        double lowerProb = k <= floorDice ? lowerProbs[k] : 0.0;
        probabilities[k] =
            lowerProb * (1 - fractionalPart) + upperProbs[k] * fractionalPart;
      }
    }

    return ProbabilityDistribution(
      probabilities: probabilities,
      mean: mean,
      standardDeviation: stdDev,
      diceCount: dice, // Store the exact dice count
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
