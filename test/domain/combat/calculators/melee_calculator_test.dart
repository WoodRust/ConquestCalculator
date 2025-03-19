// test/domain/combat/calculators/melee_calculator_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:conquest_calculator/domain/combat/calculators/melee_calculator.dart';
import 'package:conquest_calculator/domain/combat/models/combat_input.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';

class MockRegiment extends Mock implements Regiment {
  final bool _isCharacter;
  final int _attacks;
  final int _clash;

  MockRegiment({
    bool isCharacter = false,
    int attacks = 4,
    int clash = 3,
  })  : _isCharacter = isCharacter,
        _attacks = attacks,
        _clash = clash;

  @override
  bool isCharacter() => _isCharacter;

  @override
  int get attacks => _attacks;

  @override
  int get clash => _clash;

  @override
  bool hasSpecialRule(String rule) => false;
}

void main() {
  late MeleeCalculator calculator;
  late MockRegiment mockDefender; // Create a mock defender to use in all tests

  setUp(() {
    calculator = MeleeCalculator();
    mockDefender = MockRegiment(); // Basic mock for defender
  });

  group('MeleeCalculator', () {
    test('should calculate total attacks correctly for regular regiment', () {
      // Arrange
      final regiment = MockRegiment(attacks: 6, isCharacter: false);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        defender: mockDefender,
        defenderStands: 3,
      );

      // Act
      final result = calculator.calculateTotalAttacks(input);

      // Assert
      expect(result, 18); // 6 attacks × 3 stands = 18 attacks
    });

    test('should calculate total attacks correctly for character', () {
      // Arrange
      final character = MockRegiment(attacks: 5, isCharacter: true);
      final input = CombatInput(
        attacker: character,
        attackerStands: 1, // Should be ignored for characters
        defender: mockDefender,
        defenderStands: 3,
      );

      // Act
      final result = calculator.calculateTotalAttacks(input);

      // Assert
      expect(result, 5); // Just character's attack value
    });

    test('should add character attacks when attached', () {
      // Arrange
      final regiment = MockRegiment(attacks: 4, isCharacter: false);
      final character = MockRegiment(attacks: 3, isCharacter: true);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        attackerCharacter: character,
        defender: mockDefender,
        defenderStands: 3,
      );

      // Act
      final result = calculator.calculateTotalAttacks(input);

      // Assert
      expect(result, 11); // (4 attacks × 2 stands) + 3 character attacks = 11
    });

    test('should apply inspired bonus to hit target', () {
      // Arrange
      final regiment = MockRegiment(clash: 3);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        defender: mockDefender,
        defenderStands: 3,
        specialRulesInEffect: {'inspired': true},
      );

      // Act
      final result = calculator.calculateHitTarget(input);

      // Assert
      expect(result, 4); // 3 + 1 from inspired = 4
    });

    test('should convert inspired bonus to reroll when clash would exceed 4',
        () {
      // Arrange
      final regiment = MockRegiment(clash: 4); // Already at 4
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        defender: mockDefender,
        defenderStands: 3,
        specialRulesInEffect: {'inspired': true},
      );

      // Act
      final targetResult = calculator.calculateHitTarget(input);
      final hasRerolls = calculator.hasRerolls(input);

      // Assert
      expect(targetResult, 4); // Stays at 4, doesn't go to 5
      expect(input.specialRulesInEffect['inspiredReroll'],
          true); // Sets reroll flag
      expect(hasRerolls, true); // Should now have rerolls
    });

    test('should calculate melee phase with rerolls', () {
      // Arrange
      final regiment = MockRegiment(attacks: 6, clash: 3);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 2,
        defender: mockDefender,
        defenderStands: 3,
        specialRulesInEffect: {'flurry': true}, // Flurry grants rerolls
      );

      // Act
      final result = calculator.calculateMeleePhase(input);

      // Assert
      expect(result.diceCount, 12); // 6 attacks × 2 stands = 12 dice
      expect(result.distribution.mean,
          greaterThan(6.0)); // More than 50% with rerolls
      expect(result.distribution.targetValue, 3);
    });
  });
}
