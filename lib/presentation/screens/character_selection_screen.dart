// lib/presentation/screens/character_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/regiment_provider.dart';
import '../../domain/models/regiment.dart';

class CharacterSelectionScreen extends ConsumerWidget {
  final String faction;
  final Function(Regiment) onCharacterSelected;

  const CharacterSelectionScreen({
    super.key,
    required this.faction,
    required this.onCharacterSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regimentsAsyncValue = ref.watch(regimentsByFactionProvider(faction));

    return Scaffold(
      appBar: AppBar(
        title: Text('Select $faction Character'),
      ),
      body: regimentsAsyncValue.when(
        data: (regiments) {
          // Filter to show only character regiments
          final characterRegiments =
              regiments.where((regiment) => regiment.isCharacter()).toList();

          if (characterRegiments.isEmpty) {
            return const Center(
              child: Text('No character stands available for this faction'),
            );
          }

          return ListView.builder(
            itemCount: characterRegiments.length,
            itemBuilder: (context, index) {
              final character = characterRegiments[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text(character.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_getCharacterStats(character)),
                      if (character.specialRules.isNotEmpty)
                        Text(
                            'Special Rules: ${character.specialRules.join(", ")}',
                            overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.person),
                  onTap: () => onCharacterSelected(character),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading characters: $error'),
        ),
      ),
    );
  }

  String _getCharacterStats(Regiment character) {
    return 'M:${character.march} V:${character.volley} C:${character.clash} '
        'A:${character.attacks} W:${character.wounds} R:${character.resolve} '
        'D:${character.defense} E:${character.evasion}';
  }
}
