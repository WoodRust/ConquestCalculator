// test/domain/combat/calculators/impact_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:conquest_calculator/domain/combat/calculators/impact_calculator.dart';
import 'package:conquest_calculator/domain/combat/models/combat_input.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:mocktail/mocktail.dart';

class MockRegiment extends Mock implements Regiment {
  final int _impactValue;
  final int _clashValue;
  final bool _hasGloriousCharge;

  MockRegiment({
    required int impactValue,
    required int clashValue,
    bool hasGloriousCharge = false,
  })  : _impactValue = impactValue,
        _clashValue = clashValue,
        _hasGloriousCharge = hasGloriousCharge;

  @override
  bool hasImpact() => _impactValue > 0;

  @override
  int getImpact() => _impactValue;

  @override
  int get clash => _clashValue;

  @override
  bool hasSpecialRule(String rule) =>
      rule == 'glorious charge' && _hasGloriousCharge;
}

void main() {
  late ImpactCalculator calculator;

  setUp(() {
    calculator = ImpactCalculator();
  });

  group('ImpactCalculator', () {
    test('should calculate total impacts correctly', () {
      final attacker = MockRegiment(impactValue: 3, clashValue: 3);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 2,
        defender: MockRegiment(impactValue: 0, clashValue: 2),
        defenderStands: 3,
        isImpact: true,
      );

      expect(calculator.calculateTotalImpacts(input),
          6); // 2 stands × 3 impact = 6
    });

    test('should include character impacts in total', () {
      final attacker = MockRegiment(impactValue: 3, clashValue: 3);
      final character = MockRegiment(impactValue: 2, clashValue: 4);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 2,
        attackerCharacter: character,
        defender: MockRegiment(impactValue: 0, clashValue: 2),
        defenderStands: 3,
        isImpact: true,
      );

      // 2 stands × 3 impact + 2 character impact = 8
      expect(calculator.calculateTotalImpacts(input), 8);
    });

    test('should return 0 impacts when isImpact is false', () {
      final attacker = MockRegiment(impactValue: 3, clashValue: 3);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 2,
        defender: MockRegiment(impactValue: 0, clashValue: 2),
        defenderStands: 3,
        isImpact: false, // Impact is disabled
      );

      expect(calculator.calculateTotalImpacts(input), 0);
    });

    test('should return 0 impacts when attacker has no impact', () {
      final attacker = MockRegiment(impactValue: 0, clashValue: 3); // No impact
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 2,
        defender: MockRegiment(impactValue: 0, clashValue: 2),
        defenderStands: 3,
        isImpact: true,
      );

      expect(calculator.calculateTotalImpacts(input), 0);
    });

    test('should apply glorious charge bonus to hit target', () {
      final attacker = MockRegiment(
        impactValue: 3,
        clashValue: 3,
        hasGloriousCharge: true,
      );
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 2,
        defender: MockRegiment(impactValue: 0, clashValue: 2),
        defenderStands: 3,
        isImpact: true,
        isCharge: true, // Charging to activate glorious charge
      );

      // Base clash 3 + 1 for glorious charge = 4
      expect(calculator.calculateImpactTarget(input), 4);
    });

    test('should not apply glorious charge when not charging', () {
      final attacker = MockRegiment(
        impactValue: 3,
        clashValue: 3,
        hasGloriousCharge: true,
      );
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 2,
        defender: MockRegiment(impactValue: 0, clashValue: 2),
        defenderStands: 3,
        isImpact: true,
        isCharge: false, // Not charging
      );

      expect(
          calculator.calculateImpactTarget(input), 3); // Just base clash value
    });

    test('should calculate expected successes correctly', () {
      final attacker = MockRegiment(impactValue: 3, clashValue: 3);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 2,
        defender: MockRegiment(impactValue: 0, clashValue: 2),
        defenderStands: 3,
        isImpact: true,
      );

      final result = calculator.calculateImpactPhase(input);

      // 6 impact attacks × (3/6) success rate = 3 expected successes
      expect(result.diceCount, 6);
      expect(result.expectedSuccesses, 3.0);
      expect(result.distribution.mean, 3.0);
    });

    test('should return empty result when impact is disabled', () {
      final attacker = MockRegiment(impactValue: 3, clashValue: 3);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 2,
        defender: MockRegiment(impactValue: 0, clashValue: 2),
        defenderStands: 3,
        isImpact: false, // Impact disabled
      );

      final result = calculator.calculateImpactPhase(input);

      expect(result.diceCount, 0);
      expect(result.expectedSuccesses, 0.0);
      expect(result.distribution.probabilities,
          [1.0]); // 100% chance of 0 successes
    });
  });
}
