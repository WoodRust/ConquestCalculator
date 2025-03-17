// test/presentation/widgets/combat_results_panel_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/models/combat_simulation.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'package:conquest_calculator/presentation/providers/combat_provider.dart';
import 'package:conquest_calculator/presentation/utils/combat_calculator_utils.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockRegiment extends Mock implements Regiment {
  final String _name;
  final bool _isCharacter;
  final int _attacks;
  final int _impact;
  final int _brutalImpact;
  final bool _hasLeader;
  final bool _hasGloriousCharge;
  final bool _hasShield;
  final int _wounds;
  final int _clash;
  final int _defense;
  final int _evasion;

  MockRegiment({
    required String name,
    bool isCharacter = false,
    int attacks = 4,
    int impact = 0,
    int brutalImpact = 0,
    bool hasLeader = false,
    bool hasGloriousCharge = false,
    bool hasShield = false,
    int wounds = 1,
    int clash = 3,
    int defense = 3,
    int evasion = 0,
  })  : _name = name,
        _isCharacter = isCharacter,
        _attacks = attacks,
        _impact = impact,
        _brutalImpact = brutalImpact,
        _hasLeader = hasLeader,
        _hasGloriousCharge = hasGloriousCharge,
        _hasShield = hasShield,
        _wounds = wounds,
        _clash = clash,
        _defense = defense,
        _evasion = evasion;

  @override
  bool isCharacter() => _isCharacter;

  @override
  String get name => _name;

  @override
  int get attacks => _attacks;

  @override
  int get wounds => _wounds;

  @override
  int get clash => _clash;

  @override
  int get defense => _defense;

  @override
  int get evasion => _evasion;

  @override
  int getImpact() => _impact;

  @override
  int getBrutalImpact() => _brutalImpact;

  @override
  bool hasImpact() => _impact > 0;

  @override
  bool hasSpecialRule(String rule) {
    if (rule == 'leader') return _hasLeader;
    if (rule == 'glorious charge') return _hasGloriousCharge;
    if (rule == 'shield') return _hasShield;
    return false;
  }

  @override
  bool get shield => _hasShield;
}

class MockCombatSimulation extends Mock implements CombatSimulation {
  final Regiment _attacker;
  final Regiment _defender;
  final int _numAttackerStands;
  final int _numDefenderStands;
  final int _standsToBreak;
  final ProbabilityDistribution _totalDamageDistribution;

  MockCombatSimulation({
    required Regiment attacker,
    required Regiment defender,
    required int numAttackerStands,
    required int numDefenderStands,
    required int standsToBreak,
    required ProbabilityDistribution totalDamageDistribution,
  })  : _attacker = attacker,
        _defender = defender,
        _numAttackerStands = numAttackerStands,
        _numDefenderStands = numDefenderStands,
        _standsToBreak = standsToBreak,
        _totalDamageDistribution = totalDamageDistribution;

  @override
  Regiment get attacker => _attacker;

  @override
  Regiment get defender => _defender;

  @override
  int get numAttackerStands => _numAttackerStands;

  @override
  int get numDefenderStands => _numDefenderStands;

  @override
  int get standsToBreak => _standsToBreak;

  @override
  ProbabilityDistribution? get totalDamageDistribution =>
      _totalDamageDistribution;

  @override
  int getExpectedStandsLost() => 1; // For testing purposes
}

void main() {
  late ProviderContainer container;
  late CombatNotifier combatNotifier;

  // Create a simple mock ProbabilityDistribution for testing
  final mockDistribution = ProbabilityDistribution(
    probabilities: [0.1, 0.2, 0.3, 0.2, 0.1, 0.1],
    mean: 2.5,
    standardDeviation: 1.2,
    diceCount: 5,
    targetValue: 3,
  );

  setUp(() {
    // Create a StateNotifierProvider for testing
    final providerToTest = StateNotifierProvider<CombatNotifier, CombatState>(
      (ref) =>
          CombatNotifier(null), // We don't need CalculateCombat for these tests
    );

    container = ProviderContainer(
      overrides: [
        // Override the provider with our test version
      ],
    );

    // Get access to the notifier directly
    combatNotifier = container.read(providerToTest.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('CombatCalculatorUtils Unit Tests', () {
    group('Impact Attack Calculations', () {
      test('calculateTotalImpacts should return impact value × stands', () {
        // Arrange
        final attacker = MockRegiment(
          name: 'Warewargs',
          attacks: 6,
          impact: 3, // 3 impact attacks per stand
          hasLeader: false,
        );

        final state = CombatState(
          attacker: attacker,
          numAttackerStands: 3, // 3 stands
          isImpact: true,
        );

        // Act
        final result = CombatCalculatorUtils.calculateTotalImpacts(state);

        // Assert
        expect(result, 9); // 3 impact attacks × 3 stands = 9 impacts
      });

      test('calculateTotalImpacts should add character impact attacks', () {
        // Arrange
        final attacker = MockRegiment(
          name: 'Warewargs',
          attacks: 6,
          impact: 3,
        );

        final character = MockRegiment(
          name: 'Character',
          isCharacter: true,
          impact: 2,
        );

        final state = CombatState(
          attacker: attacker,
          numAttackerStands: 3,
          attackerCharacter: character,
          isImpact: true,
        );

        // Act
        final result = CombatCalculatorUtils.calculateTotalImpacts(state);

        // Assert
        expect(result, 11); // 3 impact × 3 stands + 2 character impact = 11
      });

      test('calculateTotalImpacts should return 0 when isImpact is false', () {
        // Arrange
        final attacker = MockRegiment(
          name: 'Warewargs',
          attacks: 6,
          impact: 3,
        );

        final state = CombatState(
          attacker: attacker,
          numAttackerStands: 3,
          isImpact: false, // Impact is disabled
        );

        // Act
        final result = CombatCalculatorUtils.calculateTotalImpacts(state);

        // Assert
        expect(result, 0); // Should return 0 when impact is disabled
      });

      test('calculateExpectedImpactHits should apply glorious charge bonus',
          () {
        // Arrange
        final attacker = MockRegiment(
          name: 'Knights',
          impact: 2,
          clash: 3,
          hasGloriousCharge: true,
        );

        final state = CombatState(
          attacker: attacker,
          numAttackerStands: 2,
          isImpact: true,
          isCharge: true, // Charging to activate glorious charge
        );

        // Act
        final result = CombatCalculatorUtils.calculateExpectedImpactHits(state);

        // Assert
        // With glorious charge: clash 3 becomes clash 4
        // 4/6 hit chance × 4 impacts = 2.67 expected hits
        expect(result, closeTo(2.67, 0.01));
      });
    });

    group('Regular Attack Calculations', () {
      test('calculateTotalAttacks should return attacks × stands', () {
        // Arrange
        final attacker = MockRegiment(
          name: 'Warewargs',
          attacks: 6,
          impact: 3, // This should be ignored for regular attacks
        );

        final state = CombatState(
          attacker: attacker,
          numAttackerStands: 3,
          isImpact:
              true, // Even when impact is active, regular attacks should be calculated separately
        );

        // Act
        final result = CombatCalculatorUtils.calculateTotalAttacks(state);

        // Assert
        expect(result, 18); // 6 attacks × 3 stands = 18 attacks
      });

      test('calculateTotalAttacks should add character attacks', () {
        // Arrange
        final attacker = MockRegiment(
          name: 'Warewargs',
          attacks: 6,
        );

        final character = MockRegiment(
          name: 'Character',
          isCharacter: true,
          attacks: 4,
        );

        final state = CombatState(
          attacker: attacker,
          numAttackerStands: 3,
          attackerCharacter: character,
        );

        // Act
        final result = CombatCalculatorUtils.calculateTotalAttacks(state);

        // Assert
        expect(result, 22); // 6 attacks × 3 stands + 4 character attacks = 22
      });

      test('calculateTotalAttacks should add +1 for Leader special rule', () {
        // Arrange
        final attacker = MockRegiment(
          name: 'Warewargs',
          attacks: 6,
          hasLeader: true,
        );

        final state = CombatState(
          attacker: attacker,
          numAttackerStands: 3,
        );

        // Act
        final result = CombatCalculatorUtils.calculateTotalAttacks(state);

        // Assert
        expect(result, 19); // 6 attacks × 3 stands + 1 leader = 19 attacks
      });

      test(
          'calculateTotalAttacks should return just character attacks for character units',
          () {
        // Arrange
        final attacker = MockRegiment(
          name: 'Character',
          isCharacter: true,
          attacks: 5,
        );

        final state = CombatState(
          attacker: attacker,
          numAttackerStands: 1, // This should be ignored for characters
        );

        // Act
        final result = CombatCalculatorUtils.calculateTotalAttacks(state);

        // Assert
        expect(result, 5); // Just character's attack value
      });
    });

    // Add more test groups for other aspects if needed
  });
}
