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
          return ListView.builder(
            itemCount: regiments.length,
            itemBuilder: (context, index) {
              final regiment = regiments[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text(regiment.name),
                  subtitle: Text(_getRegimentSubtitle(regiment)),
                  trailing: Text(
                      '${regiment.type.toString().split('.').last} - ${regiment.regimentClass.toString().split('.').last}'),
                  onTap: () => onRegimentSelected(regiment),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading regiments: $error'),
        ),
      ),
    );
  }

  String _getRegimentSubtitle(Regiment regiment) {
    return 'M:${regiment.march} V:${regiment.volley} C:${regiment.clash} '
        'A:${regiment.attacks} W:${regiment.wounds} R:${regiment.resolve} '
        'D:${regiment.defense} E:${regiment.evasion}';
  }
}
