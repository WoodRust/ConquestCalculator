// test/data/repositories/regiment_repository_test.dart
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:conquest_calculator/data/repositories/regiment_repository_impl.dart';
import 'package:conquest_calculator/data/sources/local/regiment_local_data_source.dart';
import 'package:conquest_calculator/domain/models/regiment.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up asset bundle mocking
  final RegimentLocalDataSource dataSource = RegimentLocalDataSource();
  final RegimentRepositoryImpl repository = RegimentRepositoryImpl(dataSource);

  // Mock the asset bundle
  const String mockDweghomJson = '''
  [
    {
      "name": "Flame Berserkers",
      "faction": "Dweghom",
      "type": "infantry",
      "regimentClass": "light",
      "characteristics": {
        "march": 6,
        "volley": 1,
        "clash": 3,
        "attacks": 6,
        "wounds": 5,
        "resolve": 4,
        "defense": 3,
        "evasion": 0
      },
      "specialRules": [
        {
          "name": "Aura of Death (4)",
          "description": "Enemy stands in base contact with this stand suffer 4 hits when activated"
        }
      ],
      "drawEvents": [],
      "points": 160,
      "pointsPerAdditionalStand": 50
    }
  ]
  ''';

  setUp(() {
    // Set up asset bundle mock
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler(
      'flutter/assets',
      (ByteData? message) async {
        // Handle asset loading requests
        if (message != null) {
          final String key = utf8.decode(message.buffer.asUint8List());
          if (key == 'assets/data/regiments/dweghom.json') {
            return ByteData.sublistView(
                Uint8List.fromList(utf8.encode(mockDweghomJson)));
          }
        }
        return null;
      },
    );
  });

  group('RegimentRepository', () {
    test('should retrieve regiments by faction', () async {
      // Act
      final regiments = await repository.getRegimentsByFaction('dweghom');

      // Assert
      expect(regiments, isA<List<Regiment>>());
      expect(regiments.isNotEmpty, true);
      expect(regiments.first.faction, 'Dweghom');
      expect(regiments.first.name, 'Flame Berserkers');
    });
  });
}
