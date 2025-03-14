// lib/presentation/screens/regiment_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/regiment_provider.dart';
import '../../domain/models/regiment.dart';

class RegimentSelectionScreen extends ConsumerWidget {
  final String faction;
  final Function(Regiment) onRegimentSelected;

  const RegimentSelectionScreen({
    super.key,
    required this.faction,
    required this.onRegimentSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regimentsAsyncValue = ref.watch(regimentsByFactionProvider(faction));

    return Scaffold(
      appBar: AppBar(
        title: Text('Select $faction Regiment'),
      ),
      body: regimentsAsyncValue.when(
        data: (regiments) {
          // Split regiments into characters and regular regiments
          final characterRegiments =
              regiments.where((r) => r.isCharacter()).toList();
          final regularRegiments =
              regiments.where((r) => !r.isCharacter()).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Regular regiments section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Regiments',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (regularRegiments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No regiments available for this faction'),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: regularRegiments.length,
                    itemBuilder: (context, index) {
                      return _buildRegimentCard(
                          context, regularRegiments[index]);
                    },
                  ),

                // Character stands section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                  child: Text(
                    'Character Stands',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (characterRegiments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                        Text('No character stands available for this faction'),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: characterRegiments.length,
                    itemBuilder: (context, index) {
                      return _buildRegimentCard(
                        context,
                        characterRegiments[index],
                        isCharacter: true,
                      );
                    },
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading regiments: $error'),
        ),
      ),
    );
  }

  Widget _buildRegimentCard(BuildContext context, Regiment regiment,
      {bool isCharacter = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Icon(
          isCharacter ? Icons.person : _getRegimentTypeIcon(regiment.type),
        ),
        title: Text(regiment.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_getRegimentSubtitle(regiment)),
            if (regiment.specialRules.isNotEmpty)
              Text(
                'Special: ${regiment.specialRules.take(3).join(", ")}${regiment.specialRules.length > 3 ? "..." : ""}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        isThreeLine: regiment.specialRules.isNotEmpty,
        trailing: Chip(
          label: Text(
            '${regiment.type.toString().split('.').last} - ${regiment.regimentClass.toString().split('.').last}',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        onTap: () => onRegimentSelected(regiment),
      ),
    );
  }

  String _getRegimentSubtitle(Regiment regiment) {
    return 'M:${regiment.march ?? "-"} V:${regiment.volley} C:${regiment.clash} '
        'A:${regiment.attacks} W:${regiment.wounds} R:${regiment.resolve ?? "-"} '
        'D:${regiment.defense} E:${regiment.evasion}';
  }

  IconData _getRegimentTypeIcon(RegimentType type) {
    switch (type) {
      case RegimentType.infantry:
        return Icons.people;
      case RegimentType.cavalry:
        return Icons.sports_handball;
      case RegimentType.brute:
        return Icons.fitness_center;
      case RegimentType.monster:
        return Icons.pets;
      case RegimentType.chariot:
        return Icons.directions_car;
      default:
        return Icons.group;
    }
  }
}
