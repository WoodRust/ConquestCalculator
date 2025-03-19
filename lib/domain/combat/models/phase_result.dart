// lib/domain/combat/models/phase_result.dart
import 'package:conquest_calculator/domain/models/probability_distribution.dart';

/// Represents the result of a single combat phase (impact, melee, defense, etc.)
class PhaseResult {
  /// The number of dice rolled in this phase
  final int diceCount;

  /// The expected number of successes
  final double expectedSuccesses;

  /// The expected number of failures
  final double expectedFailures;

  /// The full probability distribution of outcomes
  final ProbabilityDistribution distribution;

  const PhaseResult({
    required this.diceCount,
    required this.expectedSuccesses,
    required this.expectedFailures,
    required this.distribution,
  });

  /// Creates an empty result (used for initialization)
  factory PhaseResult.empty() {
    return PhaseResult(
      diceCount: 0,
      expectedSuccesses: 0.0,
      expectedFailures: 0.0,
      distribution: ProbabilityDistribution(
        probabilities: [1.0], // 100% chance of 0 successes
        mean: 0.0,
        standardDeviation: 0.0,
        diceCount: 0,
        targetValue: 0,
      ),
    );
  }

  /// Creates a new PhaseResult with updated values
  PhaseResult copyWith({
    int? diceCount,
    double? expectedSuccesses,
    double? expectedFailures,
    ProbabilityDistribution? distribution,
  }) {
    return PhaseResult(
      diceCount: diceCount ?? this.diceCount,
      expectedSuccesses: expectedSuccesses ?? this.expectedSuccesses,
      expectedFailures: expectedFailures ?? this.expectedFailures,
      distribution: distribution ?? this.distribution,
    );
  }
}
