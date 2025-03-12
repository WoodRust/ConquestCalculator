// lib/data/dto/regiment_dto.dart
import '../../domain/models/regiment.dart';

class RegimentDto {
  final String name;
  final String faction;
  final String type;
  final String regimentClass;
  final Map<String, int> characteristics;
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
      characteristics: Map<String, int>.from(json['characteristics'] as Map),
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
    return Regiment(
      name: name,
      faction: faction,
      type: _parseRegimentType(type),
      regimentClass: _parseRegimentClass(regimentClass),
      march: characteristics['march'] ?? 0,
      volley: characteristics['volley'] ?? 0,
      clash: characteristics['clash'] ?? 0,
      attacks: characteristics['attacks'] ?? 0,
      wounds: characteristics['wounds'] ?? 0,
      resolve: characteristics['resolve'] ?? 0,
      defense: characteristics['defense'] ?? 0,
      evasion: characteristics['evasion'] ?? 0,
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
      default:
        return RegimentClass.medium;
    }
  }
}
