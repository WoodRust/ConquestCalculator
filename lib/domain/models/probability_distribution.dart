// lib/domain/models/probability_distribution.dart
import 'dart:math' as math;

/// Represents a discrete probability distribution for combat outcomes.
class ProbabilityDistribution {
  /// List of probabilities for each possible outcome
  /// probabilities[i] represents P(X = i) where X is the random variable
  final List<double> probabilities;

  /// Mean (expected value) of the distribution
  final double mean;

  /// Standard deviation of the distribution
  final double standardDeviation;

  /// Number of dice used in the calculation (for reference)
  final int diceCount;

  /// The target value used for success (for reference)
  final int targetValue;

  ProbabilityDistribution({
    required this.probabilities,
    required this.mean,
    required this.standardDeviation,
    required this.diceCount,
    required this.targetValue,
  });

  /// Creates a binomial probability distribution for n dice with target t or less on d6
  factory ProbabilityDistribution.binomial({
    required int dice,
    required int targetValue,
  }) {
    if (dice < 0) {
      throw ArgumentError('Number of dice must be non-negative');
    }
    if (targetValue < 0 || targetValue > 6) {
      throw ArgumentError('Target value must be between 0 and 6');
    }

    // Calculate success probability on a d6
    final double p = targetValue / 6.0;

    // Calculate binomial probabilities for 0 to n successes
    List<double> probs = List<double>.filled(dice + 1, 0.0);
    for (int k = 0; k <= dice; k++) {
      probs[k] = _binomialProbability(dice, k, p);
    }

    // Calculate mean and standard deviation
    double mean = dice * p;
    double variance = dice * p * (1 - p);
    double standardDeviation = math.sqrt(variance);

    return ProbabilityDistribution(
      probabilities: probs,
      mean: mean,
      standardDeviation: standardDeviation,
      diceCount: dice,
      targetValue: targetValue,
    );
  }

  /// Calculate probability mass function for a binomial distribution
  static double _binomialProbability(int n, int k, double p) {
    if (k < 0 || k > n) return 0.0;
    if (p == 0.0) return (k == 0) ? 1.0 : 0.0;
    if (p == 1.0) return (k == n) ? 1.0 : 0.0;

    // Calculate binomial coefficient C(n,k)
    double coefficient = _binomialCoefficient(n, k);

    // Calculate probability using binomial formula: C(n,k) * p^k * (1-p)^(n-k)
    return coefficient * math.pow(p, k) * math.pow(1 - p, n - k);
  }

  /// Calculate binomial coefficient C(n,k) = n! / (k! * (n-k)!)
  /// Implemented with logarithms to avoid factorial overflow
  static double _binomialCoefficient(int n, int k) {
    // Optimize for edge cases
    if (k == 0 || k == n) return 1.0;
    if (k == 1 || k == n - 1) return n.toDouble();

    // Use logarithm method for larger values to avoid overflow
    double logResult = 0.0;
    for (int i = 1; i <= k; i++) {
      logResult += math.log(n - k + i) - math.log(i);
    }
    return math.exp(logResult);
  }

  /// Factory method to combine two probability distributions
  /// Used for combining hit, wound, and morale distributions
  factory ProbabilityDistribution.combine(
    ProbabilityDistribution dist1,
    ProbabilityDistribution dist2,
  ) {
    // Using convolution to combine distributions
    int maxOutcome =
        dist1.probabilities.length + dist2.probabilities.length - 1;
    List<double> combined = List<double>.filled(maxOutcome, 0.0);

    // Discrete convolution
    for (int i = 0; i < dist1.probabilities.length; i++) {
      for (int j = 0; j < dist2.probabilities.length; j++) {
        combined[i + j] += dist1.probabilities[i] * dist2.probabilities[j];
      }
    }

    // Calculate combined mean and stddev
    double mean = dist1.mean + dist2.mean;
    double variance = (dist1.standardDeviation * dist1.standardDeviation) +
        (dist2.standardDeviation * dist2.standardDeviation);
    double standardDeviation = math.sqrt(variance);

    return ProbabilityDistribution(
      probabilities: combined,
      mean: mean,
      standardDeviation: standardDeviation,
      diceCount: dist1.diceCount + dist2.diceCount,
      targetValue: math.max(dist1.targetValue, dist2.targetValue),
    );
  }

  /// Get cumulative probability distribution: P(X ≤ k)
  List<double> getCumulativeDistribution() {
    List<double> cumulative = List<double>.from(probabilities);
    for (int i = 1; i < cumulative.length; i++) {
      cumulative[i] += cumulative[i - 1];
    }
    return cumulative;
  }

  /// Get probability of exceeding a threshold: P(X ≥ k)
  double getProbabilityOfExceeding(int threshold) {
    if (threshold < 0) return 1.0;
    if (threshold >= probabilities.length) return 0.0;

    double cumulativeProbability = 0.0;
    for (int i = 0; i <= threshold; i++) {
      if (i < probabilities.length) {
        cumulativeProbability += probabilities[i];
      }
    }
    return 1.0 - cumulativeProbability;
  }

  /// Get probability of outcome being exactly k: P(X = k)
  double getProbabilityOfExactly(int k) {
    if (k < 0 || k >= probabilities.length) return 0.0;
    return probabilities[k];
  }

  /// Create a truncated distribution by keeping only certain outcomes
  ProbabilityDistribution truncate(int maxOutcome) {
    if (maxOutcome >= probabilities.length) {
      return this;
    }

    List<double> truncated =
        List<double>.from(probabilities.sublist(0, maxOutcome + 1));

    // Normalize the truncated distribution
    double sum = truncated.fold(0.0, (a, b) => a + b);
    if (sum < 1.0) {
      truncated = truncated.map((p) => (p / sum).toDouble()).toList();
    }

    // Recalculate mean and standard deviation
    double newMean = 0.0;
    for (int i = 0; i < truncated.length; i++) {
      newMean += i * truncated[i];
    }

    double newVariance = 0.0;
    for (int i = 0; i < truncated.length; i++) {
      newVariance += math.pow(i - newMean, 2) * truncated[i];
    }

    return ProbabilityDistribution(
      probabilities: truncated,
      mean: newMean,
      standardDeviation: math.sqrt(newVariance),
      diceCount: diceCount,
      targetValue: targetValue,
    );
  }
}
