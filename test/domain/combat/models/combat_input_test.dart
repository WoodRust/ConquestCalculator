// test/domain/combat/models/combat_input_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:conquest_calculator/domain/combat/models/combat_input.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:mocktail/mocktail.dart';

class MockRegiment extends Mock implements Regiment {
  @override
  bool hasSpecialRule(String rule) => rule == 'test_rule';
}

void main() {
  late MockRegiment mockAttacker;
  late MockRegiment mockDefender;
  late MockRegiment mockCharacter;

  setUp(() {
    mockAttacker = MockRegiment();
    mockDefender = MockRegiment();
    mockCharacter = MockRegiment();
  });

  group('CombatInput', () {
    test('should correctly calculate effective stands', () {
      final input = CombatInput(
        attacker: mockAttacker,
        attackerStands: 3,
        attackerCharacter: mockCharacter,
        defender: mockDefender,
        defenderStands: 2,
        defenderCharacter: null,
      );

      expect(input.effectiveAttackerStands, 4); // 3 stands + 1 character
      expect(input.effectiveDefenderStands, 2); // 2 stands, no character
    });

    test('should correctly calculate stands to break', () {
      final input = CombatInput(
        attacker: mockAttacker,
        attackerStands: 3,
        defender: mockDefender,
        defenderStands: 3,
      );

      expect(input.standsToBreak, 2); // ceil(3/2) = 2

      final inputWithChar = CombatInput(
        attacker: mockAttacker,
        attackerStands: 3,
        defender: mockDefender,
        defenderStands: 3,
        defenderCharacter: mockCharacter,
      );

      expect(inputWithChar.standsToBreak, 2); // ceil(4/2) = 2

      final oddStandsInput = CombatInput(
        attacker: mockAttacker,
        attackerStands: 3,
        defender: mockDefender,
        defenderStands: 5,
      );

      expect(oddStandsInput.standsToBreak, 3); // ceil(5/2) = 3
    });

    test('should correctly check for special rules', () {
      final input = CombatInput(
        attacker: mockAttacker,
        attackerStands: 3,
        defender: mockDefender,
        defenderStands: 3,
        specialRulesInEffect: {'additional_rule': true},
      );

      expect(input.hasAttackerRule('test_rule'), true); // From mock
      expect(input.hasAttackerRule('additional_rule'),
          true); // From specialRulesInEffect
      expect(input.hasAttackerRule('nonexistent_rule'), false);
    });

    test('should correctly copy with new values', () {
      final input = CombatInput(
        attacker: mockAttacker,
        attackerStands: 3,
        defender: mockDefender,
        defenderStands: 3,
        isCharge: true,
      );

      final copied = input.copyWith(
        attackerStands: 4,
        isCharge: false,
        isImpact: true,
      );

      expect(copied.attacker, mockAttacker); // Unchanged
      expect(copied.attackerStands, 4); // Changed
      expect(copied.isCharge, false); // Changed
      expect(copied.isImpact, true); // Changed
      expect(copied.isRear, false); // Default value
    });

    test('should correctly clear character when requested', () {
      final input = CombatInput(
        attacker: mockAttacker,
        attackerStands: 3,
        attackerCharacter: mockCharacter,
        defender: mockDefender,
        defenderStands: 3,
      );

      final copied = input.copyWith(clearAttackerCharacter: true);

      expect(copied.attackerCharacter, null);
      expect(input.attackerCharacter, mockCharacter); // Original unchanged
    });
  });
}
