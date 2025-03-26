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
  final String? attackerFaction;

  final Regiment? defender;
  final int numDefenderStands;
  final Regiment? defenderCharacter;
  final String? defenderFaction;

  final bool isCharge;
  final bool isImpact;
  final bool isFlank;
  final bool isRear;
  final bool isVolley;
  final bool isWithinEffectiveRange;
  final bool isDefenderBroken; // Added this flag

  // Split special rules for attacker and defender
  final Map<String, bool> attackerSpecialRulesInEffect;
  final Map<String, bool> defenderSpecialRulesInEffect;

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
    this.isDefenderBroken = false, // Initialize with default value
    Map<String, bool>? attackerSpecialRulesInEffect,
    Map<String, bool>? defenderSpecialRulesInEffect,
    this.specialRuleValues = const {},
    this.simulation,
    this.savedCalculations = const [],
    this.showCumulativeDistribution = false,
    this.combatMode = CombatMode.melee,
    this.isDuelMode = false,
    this.selectionResetDueToModeChange = false,
  })  :
        // Initialize the maps if they're null
        this.attackerSpecialRulesInEffect = attackerSpecialRulesInEffect ?? {},
        this.defenderSpecialRulesInEffect = defenderSpecialRulesInEffect ?? {};

  CombatState copyWith({
    Regiment? attacker,
    bool clearAttacker = false,
    int? numAttackerStands,
    Regiment? attackerCharacter,
    String? attackerFaction,
    bool clearAttackerFaction = false,
    bool clearAttackerCharacter = false,
    Regiment? defender,
    bool clearDefender = false,
    int? numDefenderStands,
    Regiment? defenderCharacter,
    String? defenderFaction,
    bool clearDefenderFaction = false,
    bool clearDefenderCharacter = false,
    bool? isClash,
    bool? isImpact,
    bool? isFlank,
    bool? isRear,
    bool? isVolley,
    bool? isWithinEffectiveRange,
    bool? isDefenderBroken, // Added parameter to copyWith
    Map<String, bool>? attackerSpecialRulesInEffect,
    Map<String, bool>? defenderSpecialRulesInEffect,
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
      attacker: clearAttacker ? null : (attacker ?? this.attacker),
      numAttackerStands: numAttackerStands ?? this.numAttackerStands,
      attackerCharacter: clearAttackerCharacter
          ? null
          : (attackerCharacter ?? this.attackerCharacter),
      attackerFaction: clearAttackerFaction
          ? null
          : (attackerFaction ?? this.attackerFaction),
      defender: clearDefender ? null : (defender ?? this.defender),
      numDefenderStands: numDefenderStands ?? this.numDefenderStands,
      defenderCharacter: clearDefenderCharacter
          ? null
          : (defenderCharacter ?? this.defenderCharacter),
      defenderFaction: clearDefenderFaction
          ? null
          : (defenderFaction ?? this.defenderFaction),
      isCharge: isClash ?? this.isCharge,
      isImpact: isImpact ?? this.isImpact,
      isFlank: isFlank ?? this.isFlank,
      isRear: isRear ?? this.isRear,
      isVolley: isVolley ?? this.isVolley,
      isWithinEffectiveRange:
          isWithinEffectiveRange ?? this.isWithinEffectiveRange,
      isDefenderBroken:
          isDefenderBroken ?? this.isDefenderBroken, // Added this line
      attackerSpecialRulesInEffect:
          attackerSpecialRulesInEffect ?? this.attackerSpecialRulesInEffect,
      defenderSpecialRulesInEffect:
          defenderSpecialRulesInEffect ?? this.defenderSpecialRulesInEffect,
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
