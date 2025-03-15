// lib/data/dto/regiment_dto.dart
import '../../domain/models/regiment.dart';

class RegimentDto {
  final String name;
  final String faction;
  final String type;
  final String regimentClass;
  final Map<String, dynamic> characteristics;
  final List<Map<String, String>> specialRules;
  final Map<String, dynamic> numericSpecialRules;
  final List<Map<String, String>> drawEvents;
  final int points;
  final int? pointsPerAdditionalStand;

  RegimentDto({
    required this.name,
    required this.faction,
    required this.type,
    required this.regimentClass,
    required this.characteristics,
    required this.specialRules,
    this.numericSpecialRules = const {},
    required this.drawEvents,
    required this.points,
    this.pointsPerAdditionalStand,
  });

  factory RegimentDto.fromJson(Map<String, dynamic> json) {
    return RegimentDto(
      name: json['name'] as String,
      faction: json['faction'] as String,
      type: json['type'] as String,
      regimentClass: json['regimentClass'] as String,
      characteristics:
          Map<String, dynamic>.from(json['characteristics'] as Map),
      specialRules: (json['specialRules'] as List)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
      numericSpecialRules: json['numericSpecialRules'] != null
          ? Map<String, dynamic>.from(json['numericSpecialRules'] as Map)
          : {},
      drawEvents: (json['drawEvents'] as List? ?? [])
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
      points: json['points'] as int,
      pointsPerAdditionalStand: json['pointsPerAdditionalStand'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'faction': faction,
      'type': type,
      'regimentClass': regimentClass,
      'characteristics': characteristics,
      'specialRules': specialRules,
      'numericSpecialRules': numericSpecialRules,
      'drawEvents': drawEvents,
      'points': points,
      'pointsPerAdditionalStand': pointsPerAdditionalStand,
    };
  }

  Regiment toRegiment() {
    // Get values from numericSpecialRules if available, otherwise extract from special rules text
    int? barrage = numericSpecialRules['barrage'] as int?;
    int? barrageRange = numericSpecialRules['barrageRange'] as int?;

    // Separate armor piercing from barrage
    bool armorPiercing = numericSpecialRules['armorPiercing'] as bool? ?? false;
    int armorPiercingValue =
        numericSpecialRules['armorPiercingValue'] as int? ?? 0;

    int? impact = numericSpecialRules['impact'] as int?;
    int? support = numericSpecialRules['support'] as int?;
    int? cleave = numericSpecialRules['cleave'] as int?;
    int? auraOfDeath = numericSpecialRules['auraOfDeath'] as int?;
    int? brutalImpact = numericSpecialRules['brutalImpact'] as int?;
    int? indomitable = numericSpecialRules['indomitable'] as int?;
    bool shield = numericSpecialRules['shield'] as bool? ?? false;
    int? tenacious = numericSpecialRules['tenacious'] as int?;
    int? terrifying = numericSpecialRules['terrifying'] as int?;
    int? trample = numericSpecialRules['trample'] as int?;
    int? vanguard = numericSpecialRules['vanguard'] as int?;
    int? spellDice = numericSpecialRules['spellDice'] as int?;

    // If numeric values aren't in numericSpecialRules, try to extract from special rules text
    if (numericSpecialRules.isEmpty) {
      for (final rule in specialRules) {
        final ruleName = rule['name'] ?? '';

        // Extract barrage information
        if (barrage == null && ruleName.contains('Barrage')) {
          final barrageMatch =
              RegExp(r'Barrage \((\d+)\)').firstMatch(ruleName);
          final barrageFullMatch =
              RegExp(r'Barrage \((\d+)\) \((\d+)\"').firstMatch(ruleName);

          if (barrageMatch != null) {
            barrage = int.tryParse(barrageMatch.group(1) ?? '0');
          }

          if (barrageFullMatch != null && barrageFullMatch.groupCount >= 2) {
            barrage = int.tryParse(barrageFullMatch.group(1) ?? '0');
            barrageRange = int.tryParse(barrageFullMatch.group(2) ?? '0');
          }
        }

        // Check for Armor Piercing - now as a separate special rule
        if (ruleName.contains('Armor Piercing')) {
          armorPiercing = true;
          final apMatch =
              RegExp(r'Armor Piercing \((\d+)\)').firstMatch(ruleName);
          if (apMatch != null) {
            armorPiercingValue = int.tryParse(apMatch.group(1) ?? '0') ?? 0;
          }
        }

        // Extract Impact value
        if (impact == null && ruleName.contains('Impact')) {
          final match = RegExp(r'Impact \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            impact = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Support value
        if (support == null && ruleName.contains('Support')) {
          final match = RegExp(r'Support \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            support = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Cleave value
        if (cleave == null && ruleName.contains('Cleave')) {
          final match = RegExp(r'Cleave \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            cleave = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Aura of Death value
        if (auraOfDeath == null && ruleName.contains('Aura of Death')) {
          final match = RegExp(r'Aura of Death \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            auraOfDeath = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Brutal Impact value
        if (brutalImpact == null && ruleName.contains('Brutal Impact')) {
          final match = RegExp(r'Brutal Impact \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            brutalImpact = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Indomitable value
        if (indomitable == null && ruleName.contains('Indomitable')) {
          final match = RegExp(r'Indomitable \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            indomitable = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Check for Shield
        if (ruleName == 'Shield') {
          shield = true;
        }

        // Extract Tenacious value
        if (tenacious == null && ruleName.contains('Tenacious')) {
          final match = RegExp(r'Tenacious \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            tenacious = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Terrifying value
        if (terrifying == null && ruleName.contains('Terrifying')) {
          final match = RegExp(r'Terrifying \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            terrifying = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Trample value
        if (trample == null && ruleName.contains('Trample')) {
          final match = RegExp(r'Trample \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            trample = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Vanguard value
        if (vanguard == null && ruleName.contains('Vanguard')) {
          final match = RegExp(r'Vanguard \((\d+)\)').firstMatch(ruleName);
          if (match != null) {
            vanguard = int.tryParse(match.group(1) ?? '0');
          }
        }

        // Extract Wizard/Priest value
        if (spellDice == null) {
          if (ruleName.contains('Wizard')) {
            final match = RegExp(r'Wizard \((\d+)\)').firstMatch(ruleName);
            if (match != null) {
              spellDice = int.tryParse(match.group(1) ?? '0');
            }
          } else if (ruleName.contains('Priest')) {
            final match = RegExp(r'Priest \((\d+)\)').firstMatch(ruleName);
            if (match != null) {
              spellDice = int.tryParse(match.group(1) ?? '0');
            }
          }
        }
      }
    }

    return Regiment(
      name: name,
      faction: faction,
      type: _parseRegimentType(type),
      regimentClass: _parseRegimentClass(regimentClass),
      // Only make march and resolve nullable as they're the only stats that might be null
      march: characteristics['march'] as int?,
      volley: characteristics['volley'] as int? ?? 0,
      clash: characteristics['clash'] as int? ?? 0,
      attacks: characteristics['attacks'] as int? ?? 0,
      wounds: characteristics['wounds'] as int? ?? 0,
      resolve: characteristics['resolve'] as int?,
      defense: characteristics['defense'] as int? ?? 0,
      evasion: characteristics['evasion'] as int? ?? 0,
      // Add numeric special rule values
      barrage: barrage,
      barrageRange: barrageRange,
      armorPiercing: armorPiercing,
      armorPiercingValue: armorPiercingValue,
      impact: impact,
      support: support,
      cleave: cleave,
      auraOfDeath: auraOfDeath,
      brutalImpact: brutalImpact,
      indomitable: indomitable,
      shield: shield,
      tenacious: tenacious,
      terrifying: terrifying,
      trample: trample,
      vanguard: vanguard,
      spellDice: spellDice,
      specialRules: specialRules.map((e) => e['name'] ?? '').toList(),
      drawEvents: drawEvents.map((e) => e['name'] ?? '').toList(),
    );
  }

  static RegimentType _parseRegimentType(String type) {
    switch (type.toLowerCase()) {
      case 'infantry':
        return RegimentType.infantry;
      case 'cavalry':
        return RegimentType.cavalry;
      case 'brute':
        return RegimentType.brute;
      case 'monster':
        return RegimentType.monster;
      case 'chariot':
        return RegimentType.chariot;
      default:
        return RegimentType.infantry;
    }
  }

  static RegimentClass _parseRegimentClass(String regimentClass) {
    switch (regimentClass.toLowerCase()) {
      case 'light':
        return RegimentClass.light;
      case 'medium':
        return RegimentClass.medium;
      case 'heavy':
        return RegimentClass.heavy;
      case 'character':
        return RegimentClass.character;
      default:
        return RegimentClass.medium;
    }
  }
}
