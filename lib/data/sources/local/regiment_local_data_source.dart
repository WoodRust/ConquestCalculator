// lib/data/sources/local/regiment_local_data_source.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../dto/regiment_dto.dart';

class RegimentLocalDataSource {
  Future<List<RegimentDto>> getRegiments(String faction) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/regiments/$faction.json');
    final List<dynamic> jsonList = json.decode(jsonString) as List;
    return jsonList.map((json) => RegimentDto.fromJson(json)).toList();
  }

  Future<List<RegimentDto>> getAllRegiments() async {
    final List<RegimentDto> allRegiments = [];

    final List<String> factions = [
      'dweghom',
      'hundred_kingdoms',
      'nords',
      'old_dominion',
      'sorcerer_kings',
      'spires',
      'wadrhun',
      'yoroni',
      'city_states'
    ];

    for (final faction in factions) {
      try {
        final regiments = await getRegiments(faction);
        allRegiments.addAll(regiments);
      } catch (e) {
        // If file doesn't exist yet, continue
        print('Error loading $faction regiments: $e');
      }
    }

    return allRegiments;
  }
}
