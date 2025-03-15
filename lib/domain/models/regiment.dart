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

  // Special rule numeric values
  final int? barrage; // Number of dice for Barrage attacks
  final int? barrageRange; // Range of Barrage attacks in inches
  final bool armorPiercing; // Whether unit has Armor Piercing
  final int armorPiercingValue; // The value of Armor Piercing if present
  final int? impact; // Impact (X) value
  final int? support; // Support (X) value
  final int? cleave; // Cleave (X) value
  final int? auraOfDeath; // Aura of Death (X) value
  final int? brutalImpact; // Brutal Impact (X) value
  final int? indomitable; // Indomitable (X) value
  final bool shield; // Shield special rule
  final int? tenacious; // Tenacious (X) value
  final int? terrifying; // Terrifying (X) value
  final int? trample; // Trample (X) value
  final int? vanguard; // Vanguard (X) value
  final int? spellDice; // Wizard (X) or Priest (X) value

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
    this.impact,
    this.support,
    this.cleave,
    this.auraOfDeath,
    this.brutalImpact,
    this.indomitable,
    this.shield = false,
    this.tenacious,
    this.terrifying,
    this.trample,
    this.vanguard,
    this.spellDice,
    this.specialRules = const [],
    this.drawEvents = const [],
  });

  // Helper methods to safely get values with defaults
  int getMarch() => march ?? 0;
  int getResolve() => resolve ?? 0;
  int getBarrage() => barrage ?? 0;
  int getBarrageRange() => barrageRange ?? 0;
  int getImpact() => impact ?? 0;
  int getSupport() => support ?? 0;
  int getCleave() => cleave ?? 0;
  int getAuraOfDeath() => auraOfDeath ?? 0;
  int getBrutalImpact() => brutalImpact ?? 0;
  int getIndomitable() => indomitable ?? 0;
  int getTenacious() => tenacious ?? 0;
  int getTerrifying() => terrifying ?? 0;
  int getTrample() => trample ?? 0;
  int getVanguard() => vanguard ?? 0;
  int getSpellDice() => spellDice ?? 0;
  int getArmorPiercingValue() => armorPiercingValue;

  bool isCharacter() => regimentClass == RegimentClass.character;
  bool hasBarrage() => barrage != null && barrage! > 0;
  bool hasArmorPiercing() => armorPiercing;
  bool hasImpact() => impact != null && impact! > 0;
  bool hasSupport() => support != null && support! > 0;
  bool hasSpellcasting() => spellDice != null && spellDice! > 0;

  bool hasSpecialRule(String ruleName) {
    return specialRules
        .any((rule) => rule.toLowerCase().contains(ruleName.toLowerCase()));
  }
}
