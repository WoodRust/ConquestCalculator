// lib/presentation/providers/combat/models/combat_state.dart
import '../../../../domain/models/regiment.dart';
import '../../../../domain/models/combat_simulation.dart';
import 'saved_calculation.dart';

// Enum to track which combat mode is active
enum CombatMode { melee, ranged }

// CombatState class with faction support
class CombatState {
  final Regiment? attacker;
  final int numAttackerStands;
  final Regiment? attackerCharacter;
  final String? attackerFaction; // Store the selected attacker faction

  final Regiment? defender;
  final int numDefenderStands;
  final Regiment? defenderCharacter;
  final String? defenderFaction; // Store the selected defender faction

  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final bool isVolley;
  final bool isWithinEffectiveRange;
  final Map<String, bool> specialRulesInEffect;
  final Map<String, int> specialRuleValues;
  final CombatSimulation? simulation;
  final List<SavedCalculation> savedCalculations;
  final bool showCumulativeDistribution;
  final CombatMode combatMode;
  final bool isDuelMode;
  final bool selectionResetDueToModeChange;

  CombatState({
    this.attacker,
    this.numAttackerStands = 3,
    this.attackerCharacter,
    this.attackerFaction,
    this.defender,
    this.numDefenderStands = 3,
    this.defenderCharacter,
    this.defenderFaction,
    this.isCharge = false,
    this.isImpact = false,
    this.isFlank = false,
    this.isRear = false,
    this.isVolley = false,
    this.isWithinEffectiveRange = false,
    this.specialRulesInEffect = const {},
    this.specialRuleValues = const {},
    this.simulation,
    this.savedCalculations = const [],
    this.showCumulativeDistribution = false,
    this.combatMode = CombatMode.melee,
    this.isDuelMode = false,
    this.selectionResetDueToModeChange = false,
  });

  CombatState copyWith({
    Regiment? attacker,
    bool clearAttacker = false, // Added explicit flag to clear attacker
    int? numAttackerStands,
    Regiment? attackerCharacter,
    String? attackerFaction,
    bool clearAttackerFaction = false,
    bool clearAttackerCharacter = false,
    Regiment? defender,
    bool clearDefender = false, // Added explicit flag to clear defender
    int? numDefenderStands,
    Regiment? defenderCharacter,
    String? defenderFaction,
    bool clearDefenderFaction = false,
    bool clearDefenderCharacter = false,
    bool? isCharge,
    bool? isImpact,
    bool? isFlank,
    bool? isRear,
    bool? isVolley,
    bool? isWithinEffectiveRange,
    Map<String, bool>? specialRulesInEffect,
    Map<String, int>? specialRuleValues,
    CombatSimulation? simulation,
    bool clearSimulation = false,
    List<SavedCalculation>? savedCalculations,
    bool? showCumulativeDistribution,
    CombatMode? combatMode,
    bool? isDuelMode,
    bool? selectionResetDueToModeChange,
  }) {
    return CombatState(
      // Use clearAttacker flag to explicitly set attacker to null
      attacker: clearAttacker ? null : (attacker ?? this.attacker),
      numAttackerStands: numAttackerStands ?? this.numAttackerStands,
      attackerCharacter: clearAttackerCharacter
          ? null
          : (attackerCharacter ?? this.attackerCharacter),
      attackerFaction: clearAttackerFaction
          ? null
          : (attackerFaction ?? this.attackerFaction),
      // Use clearDefender flag to explicitly set defender to null
      defender: clearDefender ? null : (defender ?? this.defender),
      numDefenderStands: numDefenderStands ?? this.numDefenderStands,
      defenderCharacter: clearDefenderCharacter
          ? null
          : (defenderCharacter ?? this.defenderCharacter),
      defenderFaction: clearDefenderFaction
          ? null
          : (defenderFaction ?? this.defenderFaction),
      isCharge: isCharge ?? this.isCharge,
      isImpact: isImpact ?? this.isImpact,
      isFlank: isFlank ?? this.isFlank,
      isRear: isRear ?? this.isRear,
      isVolley: isVolley ?? this.isVolley,
      isWithinEffectiveRange:
          isWithinEffectiveRange ?? this.isWithinEffectiveRange,
      specialRulesInEffect: specialRulesInEffect ?? this.specialRulesInEffect,
      specialRuleValues: specialRuleValues ?? this.specialRuleValues,
      simulation: clearSimulation ? null : (simulation ?? this.simulation),
      savedCalculations: savedCalculations ?? this.savedCalculations,
      showCumulativeDistribution:
          showCumulativeDistribution ?? this.showCumulativeDistribution,
      combatMode: combatMode ?? this.combatMode,
      isDuelMode: isDuelMode ?? this.isDuelMode,
      selectionResetDueToModeChange:
          selectionResetDueToModeChange ?? this.selectionResetDueToModeChange,
    );
  }

  // Helper methods to get effective stand counts (including character)
  int get effectiveAttackerStands =>
      numAttackerStands + (attackerCharacter != null ? 1 : 0);

  int get effectiveDefenderStands =>
      numDefenderStands + (defenderCharacter != null ? 1 : 0);

  // Check if regiment can have a character attached (non-monster regiments only and not characters)
  bool canAttachCharacterToAttacker() {
    return attacker != null &&
        attacker!.type != RegimentType.monster &&
        !attacker!.isCharacter();
  }

  bool canAttachCharacterToDefender() {
    return defender != null &&
        defender!.type != RegimentType.monster &&
        !defender!.isCharacter();
  }

  // Add a helper property to check for character vs character mode
  bool get isCharacterVsCharacterMode =>
      isDuelMode || attacker?.isCharacter() == true;

  // Convert faction string to file path format (lowercase with underscores)
  static String? factionToPath(String? faction) {
    if (faction == null) return null;
    return faction.toLowerCase().replaceAll(' ', '_');
  }
}
