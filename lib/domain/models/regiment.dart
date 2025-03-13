// lib/domain/models/regiment.dart
enum RegimentType { infantry, cavalry, brute, monster, chariot }

enum RegimentClass { light, medium, heavy, character }

class Regiment {
  final String name;
  final String faction;
  final RegimentType type;
  final RegimentClass regimentClass;
  final int? march; // Can be null for character stands
  final int volley;
  final int clash;
  final int attacks;
  final int wounds;
  final int? resolve; // Can be null for certain units with Animate Vessel rule
  final int defense;
  final int evasion;
  // New characteristics for ranged combat
  final int? barrage; // Number of dice for Barrage attacks
  final int? barrageRange; // Range of Barrage attacks in inches
  final bool armorPiercing; // Whether Barrage has Armor Piercing
  final int armorPiercingValue; // The value of Armor Piercing if present

  final List<String> specialRules;
  final List<String> drawEvents;

  Regiment({
    required this.name,
    required this.faction,
    required this.type,
    required this.regimentClass,
    this.march,
    required this.volley,
    required this.clash,
    required this.attacks,
    required this.wounds,
    this.resolve,
    required this.defense,
    required this.evasion,
    this.barrage,
    this.barrageRange,
    this.armorPiercing = false,
    this.armorPiercingValue = 0,
    this.specialRules = const [],
    this.drawEvents = const [],
  });

  // Helper methods to safely get values with defaults
  int getMarch() => march ?? 0;
  int getResolve() => resolve ?? 0;
  int getBarrage() => barrage ?? 0;
  int getBarrageRange() => barrageRange ?? 0;

  bool isCharacter() => regimentClass == RegimentClass.character;
  bool hasBarrage() => barrage != null && barrage! > 0;

  bool hasSpecialRule(String ruleName) {
    return specialRules
        .any((rule) => rule.toLowerCase().contains(ruleName.toLowerCase()));
  }
}
