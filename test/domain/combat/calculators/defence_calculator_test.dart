// test/domain/combat/calculators/defense_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:conquest_calculator/domain/combat/calculators/defence_calculator.dart';
import 'package:conquest_calculator/domain/combat/models/combat_input.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/combat/models/phase_result.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart'; // Added import

class MockRegiment extends Mock implements Regiment {
  final int _defense;
  final int _evasion;
  final bool _shield;
  final int _cleave;
  final int _brutalImpact;
  final int _armorPiercingValue;
  final bool _hasArmorPiercing;
  final Map<String, bool> _specialRules;

  MockRegiment({
    int defense = 3,
    int evasion = 0,
    bool shield = false,
    int cleave = 0,
    int brutalImpact = 0,
    int armorPiercingValue = 0,
    bool hasArmorPiercing = false,
    Map<String, bool> specialRules = const {},
  })  : _defense = defense,
        _evasion = evasion,
        _shield = shield,
        _cleave = cleave,
        _brutalImpact = brutalImpact,
        _armorPiercingValue = armorPiercingValue,
        _hasArmorPiercing = hasArmorPiercing,
        _specialRules = specialRules;

  @override
  int get defense => _defense;

  @override
  int get evasion => _evasion;

  @override
  bool get shield => _shield;

  @override
  int getCleave() => _cleave;

  @override
  int getBrutalImpact() => _brutalImpact;

  @override
  bool hasArmorPiercing() => _hasArmorPiercing;

  @override
  int getArmorPiercingValue() => _armorPiercingValue;

  @override
  bool hasSpecialRule(String rule) => _specialRules[rule] ?? false;
}

void main() {
  late DefenseCalculator calculator;

  setUp(() {
    calculator = DefenseCalculator();
  });

  group('DefenseCalculator', () {
    test('should use highest value between defense and evasion', () {
      // Arrange
      final defender =
          MockRegiment(defense: 2, evasion: 3); // Evasion is higher
      final input = CombatInput(
        attacker: MockRegiment(),
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
      );

      // Act
      final result = calculator.calculateEffectiveDefense(input, false, false);

      // Assert
      expect(result, 3); // Should use evasion as it's higher
    });

    test('should apply shield bonus for front attacks', () {
      // Arrange
      final defender = MockRegiment(defense: 3, shield: true);
      final input = CombatInput(
        attacker: MockRegiment(),
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
        isFlank: false,
        isRear: false,
      );

      // Act
      final result = calculator.calculateEffectiveDefense(input, false, false);

      // Assert
      expect(result, 4); // 3 + 1 from shield = 4
    });

    test('should not apply shield bonus for flank attacks', () {
      // Arrange
      final defender = MockRegiment(defense: 3, shield: true);
      final input = CombatInput(
        attacker: MockRegiment(),
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
        isFlank: true, // Flank attack
      );

      // Act
      final result = calculator.calculateEffectiveDefense(input, false, false);

      // Assert
      expect(result, 3); // No shield bonus for flank attacks
    });

    test('should apply cleave for melee attacks', () {
      // Arrange
      final attacker = MockRegiment(cleave: 2);
      final defender = MockRegiment(defense: 4);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
      );

      // Act
      final result = calculator.calculateEffectiveDefense(input, false, false);

      // Assert
      expect(result, 2); // 4 - 2 cleave = 2
    });

    test('should apply brutal impact for impact attacks', () {
      // Arrange
      final attacker = MockRegiment(brutalImpact: 1);
      final defender = MockRegiment(defense: 3);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
      );

      // Act
      final result = calculator.calculateEffectiveDefense(input, true, false);

      // Assert
      expect(result, 2); // 3 - 1 brutal impact = 2
    });

    test('should apply armor piercing for volley attacks', () {
      // Arrange
      final attacker =
          MockRegiment(armorPiercingValue: 2, hasArmorPiercing: true);
      final defender = MockRegiment(defense: 4);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
        isVolley: true,
      );

      // Act
      final result = calculator.calculateEffectiveDefense(input, false, true);

      // Assert
      expect(result, 2); // 4 - 2 armor piercing = 2
    });

    test('should never reduce defense below 0', () {
      // Arrange
      final attacker = MockRegiment(cleave: 5); // Excessive cleave
      final defender = MockRegiment(defense: 3);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
      );

      // Act
      final result = calculator.calculateEffectiveDefense(input, false, false);

      // Assert
      expect(result, 0); // Minimum defense is 0
    });

    test('should calculate defense phase correctly', () {
      // Arrange
      final defender = MockRegiment(defense: 3);
      final input = CombatInput(
        attacker: MockRegiment(),
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
      );

      // Create a distribution with 50% success rate (for 10 hits out of 20 dice)
      final distribution = ProbabilityDistribution(
        probabilities: List.generate(
            21,
            (i) => i == 10
                ? 1.0
                : 0.0), // Simple distribution with all probability at 10
        mean: 10.0,
        standardDeviation: 2.0,
        diceCount: 20,
        targetValue: 3,
      );

      // Create a phase result with 10 expected successes (hits)
      final attackResult = PhaseResult(
        diceCount: 20,
        expectedSuccesses: 10,
        expectedFailures: 10,
        distribution: distribution, // Use proper distribution instead of null
      );

      // Act
      final result =
          calculator.calculateDefensePhase(input, attackResult, false);

      // Assert
      expect(result.diceCount, 10); // Number of dice = number of hits

      // Calculate expected defense failures
      // Defense of 3 means failure on 4, 5, 6 (target 3)
      // So probability of failure is 3/6 = 0.5
      expect(
          result.expectedFailures, 5); // 10 hits * 0.5 failure rate = 5 wounds
    });

    test('should handle empty attack results', () {
      // Arrange
      final input = CombatInput(
        attacker: MockRegiment(),
        attackerStands: 1,
        defender: MockRegiment(),
        defenderStands: 2,
      );

      // Empty attack result - no hits
      final attackResult = PhaseResult.empty();

      // Act
      final result =
          calculator.calculateDefensePhase(input, attackResult, false);

      // Assert
      expect(result.diceCount, 0);
      expect(result.expectedSuccesses, 0);
      expect(result.expectedFailures, 0);
    });

    test('should apply special rules from specialRulesInEffect', () {
      // Arrange
      final attacker = MockRegiment();
      final defender = MockRegiment(defense: 3);
      final input = CombatInput(
        attacker: attacker,
        attackerStands: 1,
        defender: defender,
        defenderStands: 2,
        specialRulesInEffect: {'cleave': true},
        specialRuleValues: {'cleaveValue': 2},
      );

      // Act
      final result = calculator.calculateEffectiveDefense(input, false, false);

      // Assert
      expect(result, 1); // 3 - 2 cleave value = 1
    });
  });
}
