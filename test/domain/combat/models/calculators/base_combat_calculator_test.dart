// test/domain/combat/calculators/base_combat_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:conquest_calculator/domain/combat/calculators/base_combat_calculator.dart';

// Create a concrete implementation for testing
class TestCalculator extends BaseCombatCalculator {}

void main() {
  late TestCalculator calculator;

  setUp(() {
    calculator = TestCalculator();
  });

  group('BaseCombatCalculator', () {
    test('should calculate success probability correctly', () {
      expect(calculator.calculateSuccessProbability(3), 0.5); // 3/6
      expect(calculator.calculateSuccessProbability(1), 1 / 6); // 1/6
      expect(calculator.calculateSuccessProbability(6), 1.0); // 6/6
      expect(calculator.calculateSuccessProbability(0), 0.0); // 0/6
      expect(calculator.calculateSuccessProbability(7), 1.0); // Capped at 1.0
      expect(calculator.calculateSuccessProbability(-1), 0.0); // Capped at 0.0
    });

    test('should calculate expected successes correctly', () {
      expect(calculator.calculateExpectedSuccesses(6, 3),
          3.0); // 6 dice × (3/6) = 3
      expect(
          calculator.calculateExpectedSuccesses(4, 1), 4 / 6); // 4 dice × (1/6)
      expect(calculator.calculateExpectedSuccesses(10, 5),
          closeTo(8.33, 0.01)); // 10 dice × (5/6)
      expect(calculator.calculateExpectedSuccesses(0, 3), 0.0); // 0 dice
    });

    test('should create phase result correctly', () {
      final result = calculator.createPhaseResult(6, 3);

      expect(result.diceCount, 6);
      expect(result.expectedSuccesses, 3.0); // 6 dice × (3/6) = 3
      expect(result.expectedFailures, 3.0); // 6 dice × (3/6) = 3
      expect(result.distribution.probabilities.length, 7); // 0 to 6 successes
      expect(result.distribution.mean, 3.0);
    });

    test('should create empty phase result for zero dice', () {
      final result = calculator.createPhaseResult(0, 3);

      expect(result.diceCount, 0);
      expect(result.expectedSuccesses, 0.0);
      expect(result.expectedFailures, 0.0);
      expect(result.distribution.probabilities,
          [1.0]); // 100% chance of 0 successes
    });

    test('should handle rerolls correctly', () {
      final noRerollResult = calculator.createPhaseResult(4, 3);
      // Use named parameter
      final rerollResult =
          calculator.createPhaseResultWithRerolls(4, 3, rerollFails: true);

      // Without rerolls: 4 dice × (3/6) = 2 expected successes
      expect(noRerollResult.expectedSuccesses, 2.0);

      // With rerolls: 4 dice × [0.5 + (1-0.5)*0.5] = 4 × 0.75 = 3 expected successes
      expect(rerollResult.expectedSuccesses, 3.0);

      // Probability for 4 successes should be higher with rerolls
      expect(rerollResult.distribution.probabilities[4],
          greaterThan(noRerollResult.distribution.probabilities[4]));
    });
  });
}
