// test/presentation/providers/combat_notifier_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/models/combat_simulation.dart';
import 'package:conquest_calculator/domain/models/probability_distribution.dart';
import 'package:conquest_calculator/domain/usecases/calculate_combat.dart';
import 'package:conquest_calculator/presentation/providers/combat_provider.dart';

// Mock classes
class MockCalculateCombat extends Mock implements CalculateCombat {}

class MockRegiment extends Mock implements Regiment {
  final bool _isCharacter;
  final String _name;
  final bool _hasBarrage;
  final bool _hasImpact;

  MockRegiment({
    required String name,
    bool isCharacter = false,
    bool hasBarrage = false,
    bool hasImpact = false,
  })  : _name = name,
        _isCharacter = isCharacter,
        _hasBarrage = hasBarrage,
        _hasImpact = hasImpact;

  @override
  bool isCharacter() => _isCharacter;

  @override
  bool hasBarrage() => _hasBarrage;

  @override
  bool hasImpact() => _hasImpact;

  @override
  String get name => _name;

  @override
  RegimentType get type => RegimentType.infantry;

  @override
  String toString() => 'MockRegiment(name: $_name, isCharacter: $_isCharacter)';
}

void main() {
  late MockCalculateCombat mockCalculateCombat;
  late ProviderContainer container;
  late StateNotifierProvider<CombatNotifier, CombatState> testProvider;

  setUp(() {
    mockCalculateCombat = MockCalculateCombat();

    testProvider = StateNotifierProvider<CombatNotifier, CombatState>((ref) {
      return CombatNotifier(mockCalculateCombat);
    });

    container = ProviderContainer(
      overrides: [
        combatProvider.overrideWithProvider(testProvider),
      ],
    );

    // Create a mock DiceResult for the mock CombatSimulation
    final mockDiceResult = DiceResult(
      successes: 3,
      failures: 2,
      total: 5,
    );

    // Create a mock ProbabilityDistribution for the mock CombatSimulation
    final mockProbabilityDist = ProbabilityDistribution(
      probabilities: [0.1, 0.2, 0.3, 0.2, 0.1, 0.1],
      mean: 2.5,
      standardDeviation: 1.2,
      diceCount: 5,
      targetValue: 3,
    );

    // Setup necessary mock behavior with a mock CombatSimulation
    when(() => mockCalculateCombat.calculateExpectedResult(
          attacker: any(named: 'attacker'),
          numAttackerStands: any(named: 'numAttackerStands'),
          attackerCharacter: any(named: 'attackerCharacter'),
          defender: any(named: 'defender'),
          numDefenderStands: any(named: 'numDefenderStands'),
          defenderCharacter: any(named: 'defenderCharacter'),
          isCharge: any(named: 'isCharge'),
          isImpact: any(named: 'isImpact'),
          isFlank: any(named: 'isFlank'),
          isRear: any(named: 'isRear'),
          isVolley: any(named: 'isVolley'),
          isWithinEffectiveRange: any(named: 'isWithinEffectiveRange'),
          specialRulesInEffect: any(named: 'specialRulesInEffect'),
          impactValues: any(named: 'impactValues'),
        )).thenAnswer((_) => CombatSimulation(
          attacker: _.positionalArguments[0] as Regiment,
          numAttackerStands: _.positionalArguments[1] as int,
          defender: _.positionalArguments[2] as Regiment,
          numDefenderStands: _.positionalArguments[3] as int,
          hitRoll: mockDiceResult,
          defenseRoll: mockDiceResult,
          resolveRoll: mockDiceResult,
          hitDistribution: mockProbabilityDist,
          woundDistribution: mockProbabilityDist,
          resolveDistribution: mockProbabilityDist,
          totalDamageDistribution: mockProbabilityDist,
          standsToBreak: 2,
        ));
  });

  tearDown(() {
    container.dispose();
  });

  group('CombatNotifier character and regiment consistency rules', () {
    final normalRegiment = MockRegiment(name: 'Normal Regiment');
    final characterRegiment =
        MockRegiment(name: 'Character', isCharacter: true);

    test(
        'When updating attacker to character, defender (if regular regiment) should be cleared',
        () {
      // Arrange - Setup initial state with regular regiment as defender
      final notifier = container.read(testProvider.notifier);
      notifier.updateDefender(normalRegiment);
      expect(container.read(testProvider).defender, equals(normalRegiment));

      // Act - Update attacker to character
      notifier.updateAttacker(characterRegiment);

      // Assert - Defender should be cleared
      final state = container.read(testProvider);
      expect(state.attacker, equals(characterRegiment));
      expect(state.defender, isNull);
    });

    test(
        'When updating defender to regular regiment, attacker (if character) should be cleared',
        () {
      // Arrange - Setup initial state with character as attacker
      final notifier = container.read(testProvider.notifier);
      notifier.updateAttacker(characterRegiment);
      expect(container.read(testProvider).attacker, equals(characterRegiment));

      // Act - Update defender to regular regiment
      notifier.updateDefender(normalRegiment);

      // Assert - Attacker should be cleared
      final state = container.read(testProvider);
      expect(state.defender, equals(normalRegiment));
      expect(state.attacker, isNull);
    });

    test(
        'Updating attacker to character when defender is already a character should work fine',
        () {
      // Arrange - Setup initial state with character as defender
      final notifier = container.read(testProvider.notifier);
      final anotherCharacter =
          MockRegiment(name: 'Another Character', isCharacter: true);
      notifier.updateDefender(characterRegiment);

      // Act - Update attacker to character
      notifier.updateAttacker(anotherCharacter);

      // Assert - Both should remain set
      final state = container.read(testProvider);
      expect(state.attacker, equals(anotherCharacter));
      expect(state.defender, equals(characterRegiment));
    });

    test(
        'Updating attacker to regiment when defender is character should work fine',
        () {
      // Arrange - Setup initial state with character as defender
      final notifier = container.read(testProvider.notifier);
      notifier.updateDefender(characterRegiment);

      // Act - Update attacker to regiment
      notifier.updateAttacker(normalRegiment);

      // Assert - Both should remain set
      final state = container.read(testProvider);
      expect(state.attacker, equals(normalRegiment));
      expect(state.defender, equals(characterRegiment));
    });

    test(
        'Updating defender to character when attacker is regiment should work fine',
        () {
      // Arrange - Setup initial state with regiment as attacker
      final notifier = container.read(testProvider.notifier);
      notifier.updateAttacker(normalRegiment);

      // Act - Update defender to character
      notifier.updateDefender(characterRegiment);

      // Assert - Both should remain set
      final state = container.read(testProvider);
      expect(state.attacker, equals(normalRegiment));
      expect(state.defender, equals(characterRegiment));
    });

    test(
        'Updating defender to character when attacker is also character should work fine',
        () {
      // Arrange - Setup initial state with character as attacker
      final notifier = container.read(testProvider.notifier);
      final anotherCharacter =
          MockRegiment(name: 'Another Character', isCharacter: true);
      notifier.updateAttacker(characterRegiment);

      // Act - Update defender to character
      notifier.updateDefender(anotherCharacter);

      // Assert - Both should remain set
      final state = container.read(testProvider);
      expect(state.attacker, equals(characterRegiment));
      expect(state.defender, equals(anotherCharacter));
    });

    test(
        'Character attached to attacker regiment should be cleared when attacker is cleared',
        () {
      // Arrange - Setup a regiment with character attached
      final notifier = container.read(testProvider.notifier);
      notifier.updateAttacker(normalRegiment);
      notifier.attachCharacterToAttacker(characterRegiment);
      expect(container.read(testProvider).attackerCharacter,
          equals(characterRegiment));

      // Act - Update defender to make attacker be cleared due to consistency rules
      notifier.updateDefender(normalRegiment);

      // Assert - Character should be cleared along with attacker
      final state = container.read(testProvider);
      expect(state.attacker, isNull);
      expect(state.attackerCharacter, isNull);
    });

    test(
        'Character attached to defender regiment should be cleared when defender is cleared',
        () {
      // Arrange - Setup a regiment with character attached
      final notifier = container.read(testProvider.notifier);
      notifier.updateDefender(normalRegiment);
      notifier.attachCharacterToDefender(characterRegiment);
      expect(container.read(testProvider).defenderCharacter,
          equals(characterRegiment));

      // Act - Update attacker to make defender be cleared due to consistency rules
      notifier.updateAttacker(characterRegiment);

      // Assert - Character should be cleared along with defender
      final state = container.read(testProvider);
      expect(state.defender, isNull);
      expect(state.defenderCharacter, isNull);
    });
  });
}
