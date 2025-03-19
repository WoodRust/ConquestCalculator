// test/domain/combat/calculators/morale_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:conquest_calculator/domain/combat/calculators/morale_calculator.dart';
import 'package:conquest_calculator/domain/combat/models/combat_input.dart';
import 'package:conquest_calculator/domain/combat/models/phase_result.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';

class MockRegiment extends Mock implements Regiment {
  final int _resolve;
  final int _terrifying;
  final int _indomitable;
  final bool _hasFearless;
  final bool _hasAnimateVessel;

  MockRegiment({
    int resolve = 3,
    int terrifying = 0,
    int indomitable = 0,
    bool hasFearless = false,
    bool hasAnimateVessel = false,
  })  : _resolve = resolve,
        _terrifying = terrifying,
        _indomitable = indomitable,
        _hasFearless = hasFearless,
        _hasAnimateVessel = hasAnimateVessel;

  @override
  int getResolve() => _resolve;

  @override
  int getTerrifying() => _terrifying;

  @override
  int getIndomitable() => _indomitable;

  @override
  bool hasSpecialRule(String rule) {
    if (rule == 'fearless') return _hasFearless;
    if (rule == 'animate vessel') return _hasAnimateVessel;
    return false;
  }
}

void main() {
  late MoraleCalculator calculator;

  setUp(() {
    calculator = MoraleCalculator();
  });

  group('MoraleCalculator', () {
    test('should calculate basic effective resolve correctly', () {
      // Arrange
      final defender = MockRegiment(resolve: 3);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 3); // Base resolve with no modifiers
    });

    test('should apply terrifying effect correctly', () {
      // Arrange
      final defender = MockRegiment(resolve: 3);
      final attacker = MockRegiment(terrifying: 2);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 1); // 3 - 2 terrifying = 1
    });

    test('should ignore terrifying when defender has fearless', () {
      // Arrange
      final defender = MockRegiment(resolve: 3, hasFearless: true);
      final attacker = MockRegiment(terrifying: 2);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 3); // Terrifying is ignored due to Fearless
    });

    test('should auto-pass resolve tests with animate vessel', () {
      // Arrange
      final defender = MockRegiment(resolve: 2, hasAnimateVessel: true);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 6); // Maximum possible value for auto-pass
    });

    test('should reduce resolve for flank attacks', () {
      // Arrange
      final defender = MockRegiment(resolve: 3);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
        isFlank: true,
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 2); // 3 - 1 flank penalty = 2
    });

    test('should reduce resolve for rear attacks', () {
      // Arrange
      final defender = MockRegiment(resolve: 3);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
        isRear: true,
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 2); // 3 - 1 rear penalty = 2
    });

    test('should handle broken status with minimum resolve', () {
      // Arrange
      final defender = MockRegiment(resolve: 3);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
        specialRulesInEffect: {'brokenStatus': true},
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 1); // Broken units use minimum value
    });

    test('should provide bonus for large units', () {
      // Arrange
      final defender = MockRegiment(resolve: 3);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 6, // Large unit
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 4); // 3 + 1 for large unit = 4
    });

    test('should never reduce resolve below 0', () {
      // Arrange
      final defender = MockRegiment(resolve: 1);
      final attacker = MockRegiment(terrifying: 3); // Excessive terrifying
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
        isFlank: true, // Additional penalty
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 0); // Minimum value is 0
    });

    test('should cap resolve at 6', () {
      // Arrange
      final defender = MockRegiment(resolve: 6);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 6, // Would give +1 bonus
      );

      // Act
      final result = calculator.calculateEffectiveResolve(input);

      // Assert
      expect(result, 6); // Maximum value is 6
    });

    test('should apply indomitable effect correctly', () {
      // Arrange
      // Create a phase result with 5 expected successes
      final distribution = ProbabilityDistribution(
        probabilities: [0.0, 0.0, 0.0, 0.0, 0.0, 1.0], // All probability at 5
        mean: 5.0,
        standardDeviation: 0.0,
        diceCount: 5,
        targetValue: 3,
      );

      final result = PhaseResult(
        diceCount: 5,
        expectedSuccesses: 5.0,
        expectedFailures: 0.0,
        distribution: distribution,
      );

      // Act
      final adjustedResult = calculator.applyIndomitable(result, 2);

      // Assert
      expect(adjustedResult.expectedSuccesses, 3.0); // 5 - 2 indomitable = 3
      expect(adjustedResult.distribution.mean, 3.0); // Mean is adjusted too
    });

    test('should not reduce successes below 0 with indomitable', () {
      // Arrange
      // Create a phase result with 3 expected successes
      final distribution = ProbabilityDistribution(
        probabilities: [0.0, 0.0, 0.0, 1.0], // All probability at 3
        mean: 3.0,
        standardDeviation: 0.0,
        diceCount: 3,
        targetValue: 3,
      );

      final result = PhaseResult(
        diceCount: 3,
        expectedSuccesses: 3.0,
        expectedFailures: 0.0,
        distribution: distribution,
      );

      // Act
      final adjustedResult =
          calculator.applyIndomitable(result, 5); // More than possible

      // Assert
      expect(adjustedResult.expectedSuccesses, 0.0); // Minimum is 0
      expect(adjustedResult.distribution.mean, 0.0); // Mean is 0 too
    });

    test('should calculate complete morale phase correctly', () {
      // Arrange
      final defender = MockRegiment(resolve: 3);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
      );

      // Create a wound result phase with 6 wounds
      final distribution = ProbabilityDistribution(
        probabilities: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0], // All at 6
        mean: 6.0,
        standardDeviation: 0.0,
        diceCount: 6,
        targetValue: 3,
      );

      final woundResult = PhaseResult(
        diceCount: 6,
        expectedSuccesses: 6.0,
        expectedFailures: 0.0,
        distribution: distribution,
      );

      // Act
      final moraleResult = calculator.calculateMoralePhase(input, woundResult);

      // Assert
      expect(moraleResult.diceCount, 6); // Same as wound count

      // With resolve 3, failure target is 3 (4, 5, 6 fail)
      // So success rate is 3/6 = 0.5, failure rate is 0.5
      // Expected failures from 6 dice = 6 * 0.5 = 3
      expect(moraleResult.expectedSuccesses, 3.0);
    });

    test('should handle morale phase with indomitable', () {
      // Arrange
      final defender = MockRegiment(resolve: 3, indomitable: 2);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
      );

      // Create a wound result phase with 6 wounds
      final distribution = ProbabilityDistribution(
        probabilities: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0], // All at 6
        mean: 6.0,
        standardDeviation: 0.0,
        diceCount: 6,
        targetValue: 3,
      );

      final woundResult = PhaseResult(
        diceCount: 6,
        expectedSuccesses: 6.0,
        expectedFailures: 0.0,
        distribution: distribution,
      );

      // Act
      final moraleResult = calculator.calculateMoralePhase(input, woundResult);

      // Assert
      expect(moraleResult.diceCount, 6); // Same as wound count

      // With resolve 3, failure target is 3 (4, 5, 6 fail)
      // So success rate is 3/6 = 0.5, failure rate is 0.5
      // Expected failures from 6 dice = 6 * 0.5 = 3
      // But with indomitable 2, this is reduced to 3 - 2 = 1
      expect(moraleResult.expectedSuccesses, 1.0);
    });

    test('should return empty result when no wounds', () {
      // Arrange
      final defender = MockRegiment(resolve: 3);
      final attacker = MockRegiment();
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 3,
      );

      // Create an empty wound result
      final woundResult = PhaseResult.empty();

      // Act
      final moraleResult = calculator.calculateMoralePhase(input, woundResult);

      // Assert
      expect(moraleResult.diceCount, 0);
      expect(moraleResult.expectedSuccesses, 0.0);
      expect(moraleResult.expectedFailures, 0.0);
    });
  });
}
