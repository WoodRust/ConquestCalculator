// test/presentation/widgets/unit_selection_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:conquest_calculator/domain/models/regiment.dart';
import 'package:conquest_calculator/domain/repositories/regiment_repository.dart';
import 'package:conquest_calculator/presentation/providers/regiment_provider.dart';
import 'package:conquest_calculator/presentation/screens/unit_selection_screen.dart';

// Mock classes
class MockRegimentRepository extends Mock implements RegimentRepository {}

// Create a mock for Regiment that implements isCharacter
class MockRegiment extends Mock implements Regiment {
  final bool _isCharacter;
  final String _name;
  final String _faction;
  final RegimentType _type;
  final RegimentClass _regimentClass;

  MockRegiment({
    bool isChar = false,
    String name = 'Test Regiment',
    String faction = 'Test Faction',
    RegimentType type = RegimentType.infantry,
    RegimentClass regimentClass = RegimentClass.medium,
  })  : _isCharacter = isChar,
        _name = name,
        _faction = faction,
        _type = type,
        _regimentClass = regimentClass;

  @override
  bool isCharacter() => _isCharacter;

  @override
  String get name => _name;

  @override
  String get faction => _faction;

  @override
  RegimentType get type => _type;

  @override
  RegimentClass get regimentClass => _regimentClass;

  @override
  List<String> get specialRules => [];

  @override
  String toString() => name;
}

void main() {
  late MockRegimentRepository mockRepository;

  // Create more complete mock regiment data
  final mockCharacters = [
    MockRegiment(
        isChar: true,
        name: 'Character 1',
        regimentClass: RegimentClass.character),
    MockRegiment(
        isChar: true,
        name: 'Character 2',
        regimentClass: RegimentClass.character),
  ];

  final mockRegiments = [
    MockRegiment(name: 'Regiment 1'),
    MockRegiment(name: 'Regiment 2'),
    MockRegiment(name: 'Regiment 3'),
  ];

  final allUnits = [...mockRegiments, ...mockCharacters];

  setUpAll(() {
    registerFallbackValue(MockRegiment());
  });

  setUp(() {
    mockRepository = MockRegimentRepository();

    // Configure mock behavior
    when(() => mockRepository.getRegimentsByFaction(any()))
        .thenAnswer((_) async => allUnits);
  });

  testWidgets('UnitSelectionScreen respects allowedFilters parameter',
      (WidgetTester tester) async {
    // Create a test ProviderContainer with overrides
    final container = ProviderContainer(
      overrides: [
        regimentRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    // Build the widget tree
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: UnitSelectionScreen(
            faction: 'dweghom',
            initialFilter: UnitFilter.charactersOnly,
            allowedFilters: {
              UnitFilter.charactersOnly
            }, // Only allow character selection
            title: 'Select Dweghom Character',
            onUnitSelected: (_) {},
          ),
        ),
      ),
    );

    // Wait for async operations to complete
    await tester.pumpAndSettle();

    // Verify that character filter chip is enabled
    final characterChipFinder = find.widgetWithText(FilterChip, 'Characters');
    expect(characterChipFinder, findsOneWidget);
    final characterChip = tester.widget<FilterChip>(characterChipFinder);
    expect(characterChip.onSelected, isNotNull);
    expect(characterChip.selected, isTrue); // Should be selected by default

    // Verify that regiment filter chip is disabled
    final regimentChipFinder = find.widgetWithText(FilterChip, 'Regiments');
    expect(regimentChipFinder, findsOneWidget);
    final regimentChip = tester.widget<FilterChip>(regimentChipFinder);
    expect(regimentChip.onSelected, isNull);

    // Verify that "all" filter chip is disabled
    final allChipFinder = find.widgetWithText(FilterChip, 'All');
    expect(allChipFinder, findsOneWidget);
    final allChip = tester.widget<FilterChip>(allChipFinder);
    expect(allChip.onSelected, isNull);

    // Open the filter menu
    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pumpAndSettle();

    // Since the popup menu is rendered in the overlay, we need to use find.descendant
    // to constrain the search to the overlay's context
    expect(find.text('Characters Only'), findsOneWidget);
    expect(find.text('Regiments Only'), findsNothing);
    expect(find.text('Show All Units'), findsNothing);
  });

  testWidgets(
      'UnitSelectionScreen shows only characters when filter is set to charactersOnly',
      (WidgetTester tester) async {
    // Create a test ProviderContainer with overrides
    final container = ProviderContainer(
      overrides: [
        regimentRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    // Build the widget tree
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: UnitSelectionScreen(
            faction: 'dweghom',
            initialFilter: UnitFilter.charactersOnly,
            title: 'Select Character',
            onUnitSelected: (_) {},
          ),
        ),
      ),
    );

    // Wait for async operations to complete
    await tester.pumpAndSettle();

    // Verify that only character units are shown
    expect(find.text('Character 1'), findsOneWidget);
    expect(find.text('Character 2'), findsOneWidget);
    expect(find.text('Regiment 1'), findsNothing);
    expect(find.text('Regiment 2'), findsNothing);
    expect(find.text('Regiment 3'), findsNothing);
  });

  testWidgets('UnitSelectionScreen correctly handles search functionality',
      (WidgetTester tester) async {
    // Create a test ProviderContainer with overrides
    final container = ProviderContainer(
      overrides: [
        regimentRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    // Build the widget tree
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: UnitSelectionScreen(
            faction: 'dweghom',
            initialFilter: UnitFilter.all, // Show all units
            title: 'Search Test',
            onUnitSelected: (_) {},
          ),
        ),
      ),
    );

    // Wait for async operations to complete
    await tester.pumpAndSettle();

    // Verify all units are initially shown
    expect(find.text('Character 1'), findsOneWidget);
    expect(find.text('Character 2'), findsOneWidget);
    expect(find.text('Regiment 1'), findsOneWidget);
    expect(find.text('Regiment 2'), findsOneWidget);
    expect(find.text('Regiment 3'), findsOneWidget);

    // Enter search query
    await tester.enterText(find.byType(TextField), '2');
    await tester.pumpAndSettle();

    // Verify only matching units are shown
    expect(find.text('Character 1'), findsNothing);
    expect(find.text('Character 2'), findsOneWidget);
    expect(find.text('Regiment 1'), findsNothing);
    expect(find.text('Regiment 2'), findsOneWidget);
    expect(find.text('Regiment 3'), findsNothing);
  });
}
