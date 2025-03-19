// test/domain/combat/models/phase_result_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:conquest_calculator/domain/combat/models/phase_result.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';

void main() {
  group('PhaseResult', () {
    test('should create an empty result correctly', () {
      final emptyResult = PhaseResult.empty();

      expect(emptyResult.diceCount, 0);
      expect(emptyResult.expectedSuccesses, 0.0);
      expect(emptyResult.expectedFailures, 0.0);
      expect(emptyResult.distribution.probabilities, [1.0]);
      expect(emptyResult.distribution.mean, 0.0);
    });

    test('should copy with new values correctly', () {
      // Create a simple distribution for testing
      final testDist = ProbabilityDistribution(
        probabilities: [0.5, 0.5],
        mean: 0.5,
        standardDeviation: 0.5,
        diceCount: 1,
        targetValue: 3,
      );

      final result = PhaseResult(
        diceCount: 5,
        expectedSuccesses: 2.5,
        expectedFailures: 2.5,
        distribution: testDist,
      );

      final newDist = ProbabilityDistribution(
        probabilities: [0.25, 0.5, 0.25],
        mean: 1.0,
        standardDeviation: 0.7,
        diceCount: 2,
        targetValue: 3,
      );

      final copied = result.copyWith(
        diceCount: 10,
        distribution: newDist,
      );

      expect(copied.diceCount, 10); // Changed
      expect(copied.expectedSuccesses, 2.5); // Unchanged
      expect(copied.distribution, newDist); // Changed
    });
  });
}
