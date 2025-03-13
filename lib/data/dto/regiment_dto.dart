// lib/data/dto/regiment_dto.dart
import '../../domain/models/regiment.dart';

class RegimentDto {
  final String name;
  final String faction;
  final String type;
  final String regimentClass;
  final Map<String, dynamic> characteristics;
  final List<Map<String, String>> specialRules;
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
      'drawEvents': drawEvents,
      'points': points,
      'pointsPerAdditionalStand': pointsPerAdditionalStand,
    };
  }

  Regiment toRegiment() {
    // Extract Barrage information from special rules
    int? barrage;
    int? barrageRange;
    bool armorPiercing = false;
    int armorPiercingValue = 0;

    for (final rule in specialRules) {
      final ruleName = rule['name'] ?? '';
      if (ruleName.contains('Barrage')) {
        // Extract barrage value
        final barrageMatch = RegExp(r'Barrage \((\d+)\)').firstMatch(ruleName);
        final barrageFullMatch =
            RegExp(r'Barrage \((\d+)\) \((\d+)\"').firstMatch(ruleName);

        if (barrageMatch != null) {
          barrage = int.tryParse(barrageMatch.group(1) ?? '0');
        }

        if (barrageFullMatch != null && barrageFullMatch.groupCount >= 2) {
          barrage = int.tryParse(barrageFullMatch.group(1) ?? '0');
          barrageRange = int.tryParse(barrageFullMatch.group(2) ?? '0');
        }

        // Check for Armor Piercing
        if (ruleName.contains('Armor Piercing')) {
          armorPiercing = true;
          final apMatch =
              RegExp(r'Armor Piercing \((\d+)\)').firstMatch(ruleName);
          if (apMatch != null) {
            armorPiercingValue = int.tryParse(apMatch.group(1) ?? '0') ?? 0;
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
      // Add barrage information
      barrage: barrage,
      barrageRange: barrageRange,
      armorPiercing: armorPiercing,
      armorPiercingValue: armorPiercingValue,
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
