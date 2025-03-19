// test/domain/combat/calculators/ranged_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:conquest_calculator/domain/combat/calculators/ranged_calculator.dart';
import 'package:conquest_calculator/domain/combat/models/combat_input.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/combat/models/phase_result.dart';

class MockRegiment extends Mock implements Regiment {
  final int _barrage;
  final int _volley;
  final bool _hasBarrage;

  MockRegiment({
    int barrage = 0,
    int volley = 0,
    bool hasBarrage = false,
  })  : _barrage = barrage,
        _volley = volley,
        _hasBarrage = hasBarrage;

  @override
  int getBarrage() => _barrage;

  @override
  bool hasBarrage() => _hasBarrage;

  @override
  int get volley => _volley;

  @override
  bool hasSpecialRule(String rule) => false;
}

void main() {
  late RangedCalculator calculator;

  setUp(() {
    calculator = RangedCalculator();
  });

  group('RangedCalculator', () {
    test('should calculate total volleys correctly', () {
      // Arrange
      final regiment = MockRegiment(barrage: 2, hasBarrage: true);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        defender: MockRegiment(),
        defenderStands: 2,
        isVolley: true,
      );

      // Act
      final result = calculator.calculateTotalVolleys(input);

      // Assert
      expect(result, 6); // 2 barrage × 3 stands = 6 volleys
    });

    test('should add character barrage when present', () {
      // Arrange
      final regiment = MockRegiment(barrage: 2, hasBarrage: true);
      final character = MockRegiment(barrage: 3, hasBarrage: true);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        attackerCharacter: character,
        defender: MockRegiment(),
        defenderStands: 2,
        isVolley: true,
      );

      // Act
      final result = calculator.calculateTotalVolleys(input);

      // Assert
      expect(result, 9); // (2 barrage × 3 stands) + 3 character barrage = 9
    });

    test('should halve volleys when outside effective range', () {
      // Arrange
      final regiment = MockRegiment(barrage: 2, hasBarrage: true);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        defender: MockRegiment(),
        defenderStands: 2,
        isVolley: true,
        isWithinEffectiveRange: false,
      );

      // Act
      final result = calculator.calculateTotalVolleys(input);

      // Assert
      expect(result, 3); // (2 barrage × 3 stands) / 2 = 3
    });

    test('should apply aimed modifier to volley target', () {
      // Arrange
      final regiment = MockRegiment(volley: 3, hasBarrage: true);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        defender: MockRegiment(),
        defenderStands: 2,
        isVolley: true,
        specialRulesInEffect: {'aimed': true},
      );

      // Act
      final target = calculator.calculateVolleyTarget(input);

      // Assert
      expect(target, 4); // 3 + 1 from aimed = 4
    });

    test('should convert aimed bonus to reroll when volley would exceed 4', () {
      // Arrange
      final regiment = MockRegiment(volley: 4, hasBarrage: true);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 3,
        defender: MockRegiment(),
        defenderStands: 2,
        isVolley: true,
        specialRulesInEffect: {'aimed': true},
      );

      // Act
      final target = calculator.calculateVolleyTarget(input);
      final hasRerolls = calculator.hasRerolls(input);

      // Assert
      expect(target, 4); // Stays at 4, doesn't go to 5
      expect(
          input.specialRulesInEffect['aimedReroll'], true); // Sets reroll flag
      expect(hasRerolls, true); // Should now have rerolls
    });

    test('should calculate ranged phase with rerolls', () {
      // Arrange
      final regiment = MockRegiment(volley: 3, barrage: 2, hasBarrage: true);
      final input = CombatInput(
        attacker: regiment,
        attackerStands: 2,
        defender: MockRegiment(),
        defenderStands: 2,
        isVolley: true,
        specialRulesInEffect: {'aimedReroll': true},
      );

      // Act
      final result = calculator.calculateRangedPhase(input);

      // Assert
      expect(result.diceCount, 4); // 2 barrage × 2 stands = 4 dice
      expect(result.distribution.targetValue, 3);
      // With rerolls the expected success rate should be higher than without
      double successRateWithoutRerolls = 0.5; // 3/6
      expect(result.expectedSuccesses / result.diceCount,
          greaterThan(successRateWithoutRerolls));
    });
  });
}
