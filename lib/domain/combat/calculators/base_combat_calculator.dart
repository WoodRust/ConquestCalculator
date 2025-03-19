// lib/domain/combat/calculators/base_combat_calculator.dart
import 'dart:math' as math;
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'package:conquest_calculator/domain/combat/models/phase_result.dart';

/// Base class for all combat calculators with shared functionality
abstract class BaseCombatCalculator {
  /// Calculate success probability for a given target on a d6
  double calculateSuccessProbability(int target) {
    // In Conquest, rolling less than or equal to the target is a success
    // So for a target of 3, probability is 3/6 = 0.5
    return math.min(math.max(target / 6.0, 0.0), 1.0);
  }

  /// Calculate expected successes for a dice pool
  double calculateExpectedSuccesses(int dice, int target) {
    return dice * calculateSuccessProbability(target);
  }

  /// Calculate expected failures for a dice pool
  double calculateExpectedFailures(int dice, int target) {
    return dice * (1.0 - calculateSuccessProbability(target));
  }

  /// Create a phase result from dice and target
  PhaseResult createPhaseResult(int dice, int target) {
    if (dice <= 0) {
      return PhaseResult.empty();
    }

    final prob = calculateSuccessProbability(target);
    final expectedSuccesses = dice * prob;
    final expectedFailures = dice * (1.0 - prob);

    // Create a binomial distribution for the probability of successes
    final distribution = ProbabilityDistribution.binomial(
      dice: dice,
      targetValue: target,
    );

    return PhaseResult(
      diceCount: dice,
      expectedSuccesses: expectedSuccesses,
      expectedFailures: expectedFailures,
      distribution: distribution,
    );
  }

  /// Calculate a phase result with re-rolls
  PhaseResult createPhaseResultWithRerolls(int dice, int target,
      {bool rerollFails = false} // Enclosed in curly braces as required
      ) {
    if (dice <= 0) {
      return PhaseResult.empty();
    }

    final baseProbability = calculateSuccessProbability(target);
    double adjustedProbability = baseProbability;

    if (rerollFails) {
      // When rerolling failures:
      // Adjusted probability = original + (1-original) * original
      adjustedProbability =
          baseProbability + (1.0 - baseProbability) * baseProbability;
    }

    final expectedSuccesses = dice * adjustedProbability;
    final expectedFailures = dice * (1.0 - adjustedProbability);

    // Create an adjusted probability distribution for rerolls
    final mean = expectedSuccesses;
    final variance = dice * adjustedProbability * (1.0 - adjustedProbability);
    final stdDev = math.sqrt(variance);

    // Generate probabilities for the distribution
    final List<double> probabilities = List<double>.filled(dice + 1, 0.0);
    for (int k = 0; k <= dice; k++) {
      probabilities[k] = _binomialProbability(dice, k, adjustedProbability);
    }

    final distribution = ProbabilityDistribution(
      probabilities: probabilities,
      mean: mean,
      standardDeviation: stdDev,
      diceCount: dice,
      targetValue: target,
    );

    return PhaseResult(
      diceCount: dice,
      expectedSuccesses: expectedSuccesses,
      expectedFailures: expectedFailures,
      distribution: distribution,
    );
  }

  /// Calculate binomial probability: P(X = k) where X ~ Bin(n, p)
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
