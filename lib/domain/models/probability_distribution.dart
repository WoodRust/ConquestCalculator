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
  final double diceCount;

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
    required double dice, // Changed from int to double
    required int targetValue,
  }) {
    if (dice < 0) {
      throw ArgumentError('Number of dice must be non-negative');
    }
    if (targetValue < 0 || targetValue > 6) {
      throw ArgumentError('Target value must be between 0 and 6');
    }

    // Calculate success probability on a d6
    // FIXED: In Conquest, rolling less than or equal to the target is a success
    // So for targetValue of 3, probability is 3/6 = 0.5
    final double p = targetValue / 6.0;

    // Calculate expected values for mean and variance using exact formula
    double mean = dice * p;
    double variance = dice * p * (1 - p);
    double standardDeviation = math.sqrt(variance);

    // For the probabilities array, we need to decide how to handle fractional dice
    // We'll use a truncated binomial distribution with appropriate weights
    int intDice = dice.ceil(); // Round up to nearest integer
    double fractionalPart = dice - dice.floor();

    List<double> probs = List<double>.filled(intDice + 1, 0.0);

    // Calculate probabilities for the integer part
    if (fractionalPart < 0.0001) {
      // Essentially an integer
      for (int k = 0; k <= intDice; k++) {
        probs[k] = _binomialProbability(intDice, k, p);
      }
    } else {
      // Interpolate between floor and ceiling dice values
      List<double> lowerProbs = List<double>.filled(intDice, 0.0);
      List<double> upperProbs = List<double>.filled(intDice + 1, 0.0);

      int floorDice = dice.floor();

      for (int k = 0; k <= floorDice; k++) {
        lowerProbs[k] = _binomialProbability(floorDice, k, p);
      }

      for (int k = 0; k <= intDice; k++) {
        upperProbs[k] = _binomialProbability(intDice, k, p);
      }

      // Weighted average based on fractional part
      for (int k = 0; k <= intDice; k++) {
        double lowerProb = k <= floorDice ? lowerProbs[k] : 0.0;
        probs[k] =
            lowerProb * (1 - fractionalPart) + upperProbs[k] * fractionalPart;
      }
    }

    return ProbabilityDistribution(
      probabilities: probs,
      mean: mean,
      standardDeviation: standardDeviation,
      diceCount: dice, // Store the exact dice count
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
  /// Using direct calculation for better numerical stability
  static double _binomialCoefficient(int n, int k) {
    // Optimize for edge cases
    if (k == 0 || k == n) return 1.0;
    if (k == 1 || k == n - 1) return n.toDouble();

    // Take advantage of symmetry
    if (k > n - k) {
      k = n - k;
    }

    // Calculate directly
    double c = 1.0;
    for (int i = 0; i < k; i++) {
      c = c * (n - i) / (i + 1);
    }

    return c;
  }

  /// Get survival probability function: P(X ≥ k)
  List<double> getSurvivalDistribution() {
    List<double> survival = List<double>.filled(probabilities.length, 0.0);

    // Start from the end and accumulate backward
    double sum = 0.0;
    for (int i = probabilities.length - 1; i >= 0; i--) {
      sum += probabilities[i];
      survival[i] = sum;
    }

    return survival;
  }

  /// Get probability of being greater than or equal to a threshold: P(X ≥ k)
  double getProbabilityOfAtLeast(int threshold) {
    if (threshold >= probabilities.length) return 0.0;
    if (threshold <= 0) return 1.0;

    double probability = 0.0;
    for (int i = threshold; i < probabilities.length; i++) {
      probability += probabilities[i];
    }

    return probability;
  }

  // Factory method to combine two probability distributions
  factory ProbabilityDistribution.combine(
    ProbabilityDistribution dist1,
    ProbabilityDistribution dist2, {
    int? maxOutcome,
  }) {
    // Calculate the standard convolution length
    int standardMaxOutcome =
        dist1.probabilities.length + dist2.probabilities.length - 1;

    // If maxOutcome is specified, use it to limit the array size
    int actualMaxOutcome = maxOutcome ?? standardMaxOutcome;

    // Cap to a reasonable size to prevent enormous arrays
    actualMaxOutcome = math.min(actualMaxOutcome, 60);

    List<double> combined = List<double>.filled(actualMaxOutcome, 0.0);

    // Discrete convolution with limited output size
    for (int i = 0;
        i < math.min(dist1.probabilities.length, actualMaxOutcome);
        i++) {
      double prob1 = dist1.probabilities[i];
      if (prob1 < 1e-10)
        continue; // Skip near-zero probabilities for efficiency

      for (int j = 0;
          j < math.min(dist2.probabilities.length, actualMaxOutcome - i);
          j++) {
        double prob2 = dist2.probabilities[j];
        if (prob2 < 1e-10) continue; // Skip near-zero probabilities

        combined[i + j] += prob1 * prob2;
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

  /// Get probability of exceeding a threshold: P(X > k)
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
    if (sum < 1.0 && sum > 0.0) {
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
