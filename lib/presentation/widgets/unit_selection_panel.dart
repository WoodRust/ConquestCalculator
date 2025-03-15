// lib/presentation/widgets/unit_selection_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/combat_provider.dart';
import '../screens/unit_selection_screen.dart';
import 'target_selector.dart';

class UnitSelectionPanel extends ConsumerWidget {
  const UnitSelectionPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final combatNotifier = ref.read(combatProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Combat Setup title with Duel mode checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Combat Setup',
                    style: Theme.of(context).textTheme.titleLarge),
                Row(
                  children: [
                    const Text('Duel'),
                    const SizedBox(width: 4),
                    Switch(
                      value: combatState.isDuelMode,
                      onChanged: (value) {
                        combatNotifier.toggleDuelMode(value);
                        _showDuelModeToggleMessage(context, value);
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Character vs Character mode indicator
            if (combatState.isDuelMode ||
                combatState.attacker?.isCharacter() == true)
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Character vs Character Mode',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline, size: 16),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Character vs Character Combat'),
                            content: const Text(
                                'In character vs character mode, combat is resolved differently:\n\n'
                                '• Only characters can fight other characters\n'
                                '• No stand count selection is needed\n'
                                '• Characters cannot have other characters attached to them'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            // Attacker selection
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: combatState.selectionResetDueToModeChange
                              ? Theme.of(context)
                                  .colorScheme
                                  .errorContainer
                                  .withOpacity(0.3)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          // Absolutely ensure we display "Select a regiment" when null
                          'Attacker: ${combatState.attacker?.name ?? "Select a regiment"}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: combatState.selectionResetDueToModeChange
                                ? Theme.of(context).colorScheme.error
                                : null,
                          ),
                        ),
                      ),
                    ),
                    if (combatState.attacker != null &&
                        !combatState.attacker!.isCharacter() &&
                        !combatState.isDuelMode)
                      TargetSelector(
                        selectionLimit: 10,
                        initialValue: combatState.numAttackerStands,
                        onChanged: (value) =>
                            combatNotifier.updateAttackerStands(value),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _selectAttacker(context, ref),
                      child: const Text('Select'),
                    ),
                    if (combatState.attacker != null &&
                        !combatState.attacker!.isCharacter() &&
                        combatState.canAttachCharacterToAttacker() &&
                        !combatState.isDuelMode)
                      IconButton(
                        icon: const Icon(Icons.person_add),
                        tooltip: combatState.attackerCharacter == null
                            ? 'Add character stand'
                            : 'Change character stand',
                        onPressed: () => _selectAttackerCharacter(context, ref),
                      ),
                  ],
                ),
              ],
            ),

            // Display attached character info with remove button
            if (combatState.attackerCharacter != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Character: ${combatState.attackerCharacter!.name}',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    // Remove button next to character info
                    IconButton(
                      icon: const Icon(Icons.person_remove, size: 18),
                      tooltip: 'Remove character stand',
                      onPressed: () => ref
                          .read(combatProvider.notifier)
                          .detachCharacterFromAttacker(),
                    ),
                  ],
                ),
              ),
            ],

            if (combatState.attacker != null) ...[
              // Attacker special rules section
              if (combatState.attacker!.specialRules.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('Special Rules',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: [
                    if (combatState.attacker!.hasSpecialRule('cleave'))
                      FilterChip(
                        label: const Text('Cleave'),
                        selected:
                            combatState.specialRulesInEffect['cleave'] ?? true,
                        onSelected: (bool selected) => combatNotifier
                            .toggleSpecialRule('cleave', selected),
                      ),
                    if (combatState.attacker!.hasSpecialRule('flurry'))
                      FilterChip(
                        label: const Text('Flurry'),
                        selected:
                            combatState.specialRulesInEffect['flurry'] ?? true,
                        onSelected: (bool selected) => combatNotifier
                            .toggleSpecialRule('flurry', selected),
                      ),
                    if (combatState.attacker!.hasSpecialRule('phalanx'))
                      FilterChip(
                        label: const Text('Phalanx'),
                        selected:
                            combatState.specialRulesInEffect['phalanx'] ?? true,
                        onSelected: (bool selected) => combatNotifier
                            .toggleSpecialRule('phalanx', selected),
                      ),
                  ],
                ),
              ],
            ],

            const SizedBox(height: 16),

            // Defender selection
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: combatState.selectionResetDueToModeChange
                              ? Theme.of(context)
                                  .colorScheme
                                  .errorContainer
                                  .withOpacity(0.3)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          // Absolutely ensure we display "Select a regiment" when null
                          'Defender: ${combatState.defender?.name ?? "Select a regiment"}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: combatState.selectionResetDueToModeChange
                                ? Theme.of(context).colorScheme.error
                                : null,
                          ),
                        ),
                      ),
                    ),
                    if (combatState.defender != null &&
                        !combatState.defender!.isCharacter() &&
                        !combatState.isDuelMode)
                      TargetSelector(
                        selectionLimit: 10,
                        initialValue: combatState.numDefenderStands,
                        onChanged: (value) =>
                            combatNotifier.updateDefenderStands(value),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _selectDefender(context, ref),
                      child: const Text('Select'),
                    ),
                    if (combatState.defender != null &&
                        !combatState.defender!.isCharacter() &&
                        combatState.canAttachCharacterToDefender() &&
                        !combatState.isDuelMode)
                      IconButton(
                        icon: const Icon(Icons.person_add),
                        tooltip: combatState.defenderCharacter == null
                            ? 'Add character stand'
                            : 'Change character stand',
                        onPressed: () => _selectDefenderCharacter(context, ref),
                      ),
                  ],
                ),
              ],
            ),

            // Display attached character info with remove button
            if (combatState.defenderCharacter != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Character: ${combatState.defenderCharacter!.name}',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    // Remove button next to character info
                    IconButton(
                      icon: const Icon(Icons.person_remove, size: 18),
                      tooltip: 'Remove character stand',
                      onPressed: () => ref
                          .read(combatProvider.notifier)
                          .detachCharacterFromDefender(),
                    ),
                  ],
                ),
              ),
            ],

            if (combatState.defender != null) ...[
              // Defender special rules section
              if (combatState.defender!.specialRules.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('Special Rules',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: [
                    if (combatState.defender!.hasSpecialRule('shield'))
                      FilterChip(
                        label: const Text('Shield'),
                        selected:
                            combatState.specialRulesInEffect['shield'] ?? true,
                        onSelected: (bool selected) => combatNotifier
                            .toggleSpecialRule('shield', selected),
                      ),
                    // Add other defender-specific special rules here
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  void _showDuelModeToggleMessage(BuildContext context, bool isDuelMode) {
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // Clear any existing messages
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(isDuelMode ? Icons.person : Icons.people, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isDuelMode
                    ? 'Switched to Duel Mode. All selections have been reset.'
                    : 'Exited Duel Mode. All selections have been reset.',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: isDuelMode
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _selectAttacker(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);
    final combatState = ref.read(combatProvider);

    // In duel mode, only allow character selection
    final UnitFilter initialFilter = combatState.isDuelMode
        ? UnitFilter.charactersOnly
        : UnitFilter.regimentsOnly;
    final Set<UnitFilter> allowedFilters = combatState.isDuelMode
        ? {UnitFilter.charactersOnly} // Only show characters in duel mode
        : {
            UnitFilter.all,
            UnitFilter.regimentsOnly,
            UnitFilter.charactersOnly
          }; // Show all normally

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Dweghom'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnitSelectionScreen(
                    faction: 'dweghom',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Dweghom ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateAttacker(regiment);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.castle),
            title: const Text('Hundred Kingdoms'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnitSelectionScreen(
                    faction: 'hundred_kingdoms',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Hundred Kingdoms ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateAttacker(regiment);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.nordic_walking),
            title: const Text('Nords'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnitSelectionScreen(
                    faction: 'nords',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Nords ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateAttacker(regiment);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          // Add more factions here as you create their JSON files
          ListTile(
            leading: const Icon(Icons.more_horiz),
            title: const Text('More Factions...'),
            onTap: () {
              Navigator.pop(context);
              _showMoreFactions(context, ref, true);
            },
          ),
        ],
      ),
    );
  }

  // Method to use the unified UnitSelectionScreen for character selection
  void _selectAttackerCharacter(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);
    final combatState = ref.read(combatProvider);

    if (combatState.attacker == null) return;

    // Don't allow character attachment in duel mode
    if (combatState.isDuelMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Characters cannot be attached in duel mode'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get the faction of the currently selected attacker regiment
    // Convert to lowercase and replace spaces with underscores for file path
    final String attackerFaction =
        combatState.attacker!.faction.toLowerCase().replaceAll(' ', '_');

    // Navigate directly to the unified selection screen with character filter
    // and restrict available filters to characters only
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UnitSelectionScreen(
          faction: attackerFaction,
          initialFilter: UnitFilter.charactersOnly,
          allowedFilters: {
            UnitFilter.charactersOnly
          }, // Only allow character selection
          title: 'Select ${combatState.attacker!.faction} Character',
          onUnitSelected: (character) {
            if (character.isCharacter()) {
              combatNotifier.attachCharacterToAttacker(character);
              Navigator.pop(context);
            } else {
              // Show error if somehow a non-character is selected
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Only character stands can be attached to regiments'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _selectDefender(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);
    final combatState = ref.read(combatProvider);

    // In duel mode, only allow character selection
    final UnitFilter initialFilter = combatState.isDuelMode
        ? UnitFilter.charactersOnly
        : UnitFilter.regimentsOnly;
    final Set<UnitFilter> allowedFilters = combatState.isDuelMode
        ? {UnitFilter.charactersOnly} // Only show characters in duel mode
        : {
            UnitFilter.all,
            UnitFilter.regimentsOnly,
            UnitFilter.charactersOnly
          }; // Show all normally

    // If attacker is a character in non-duel mode, restrict defender to characters too
    final bool characterVsCharacterMode = !combatState.isDuelMode &&
        (combatState.attacker?.isCharacter() ?? false);

    if (characterVsCharacterMode) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Notice'),
              subtitle: const Text(
                  'When attacker is a character in normal mode, defender must also be a character. Consider using Duel Mode for character vs character combat.'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Dweghom'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnitSelectionScreen(
                    faction: 'dweghom',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Dweghom ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateDefender(regiment);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.castle),
            title: const Text('Hundred Kingdoms'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnitSelectionScreen(
                    faction: 'hundred_kingdoms',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Hundred Kingdoms ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateDefender(regiment);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.nordic_walking),
            title: const Text('Nords'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnitSelectionScreen(
                    faction: 'nords',
                    initialFilter: initialFilter,
                    allowedFilters: allowedFilters,
                    title:
                        'Select Nords ${combatState.isDuelMode ? "Character" : "Regiment"}',
                    onUnitSelected: (regiment) {
                      // Ensure selected unit matches the required type
                      if (combatState.isDuelMode && !regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'In duel mode, only character units can be selected'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!combatState.isDuelMode &&
                          regiment.isCharacter()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Characters must be attached to regiments in normal mode'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        combatNotifier.updateDefender(regiment);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          // Add more factions here as you create their JSON files
          ListTile(
            leading: const Icon(Icons.more_horiz),
            title: const Text('More Factions...'),
            onTap: () {
              Navigator.pop(context);
              _showMoreFactions(context, ref, false);
            },
          ),
        ],
      ),
    );
  }

  // Method to use the unified UnitSelectionScreen for character selection
  void _selectDefenderCharacter(BuildContext context, WidgetRef ref) async {
    final combatNotifier = ref.read(combatProvider.notifier);
    final combatState = ref.read(combatProvider);

    if (combatState.defender == null) return;

    // Don't allow character attachment in duel mode
    if (combatState.isDuelMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Characters cannot be attached in duel mode'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get the faction of the currently selected defender regiment
    // Convert to lowercase and replace spaces with underscores for file path
    final String defenderFaction =
        combatState.defender!.faction.toLowerCase().replaceAll(' ', '_');

    // Navigate directly to the unified selection screen with character filter
    // and restrict available filters to characters only
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UnitSelectionScreen(
          faction: defenderFaction,
          initialFilter: UnitFilter.charactersOnly,
          allowedFilters: {
            UnitFilter.charactersOnly
          }, // Only allow character selection
          title: 'Select ${combatState.defender!.faction} Character',
          onUnitSelected: (character) {
            if (character.isCharacter()) {
              combatNotifier.attachCharacterToDefender(character);
              Navigator.pop(context);
            } else {
              // Show error if somehow a non-character is selected
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Only character stands can be attached to regiments'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showMoreFactions(BuildContext context, WidgetRef ref, bool isAttacker) {
    final combatState = ref.read(combatProvider);

    // In duel mode, only allow character selection
    final UnitFilter initialFilter = combatState.isDuelMode
        ? UnitFilter.charactersOnly
        : UnitFilter.regimentsOnly;
    final Set<UnitFilter> allowedFilters = combatState.isDuelMode
        ? {UnitFilter.charactersOnly} // Only show characters in duel mode
        : {
            UnitFilter.all,
            UnitFilter.regimentsOnly,
            UnitFilter.charactersOnly
          }; // Show all normally

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Faction'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Old Dominion'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UnitSelectionScreen(
                        faction: 'old_dominion',
                        initialFilter: initialFilter,
                        allowedFilters: allowedFilters,
                        title:
                            'Select Old Dominion ${combatState.isDuelMode ? "Character" : "Regiment"}',
                        onUnitSelected: (regiment) {
                          // Ensure selected unit matches the required type
                          if (combatState.isDuelMode &&
                              !regiment.isCharacter()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'In duel mode, only character units can be selected'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          } else if (!combatState.isDuelMode &&
                              regiment.isCharacter()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Characters must be attached to regiments in normal mode'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (isAttacker) {
                            ref
                                .read(combatProvider.notifier)
                                .updateAttacker(regiment);
                          } else {
                            ref
                                .read(combatProvider.notifier)
                                .updateDefender(regiment);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
              // Additional factions...
              ListTile(
                title: const Text('Spires'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UnitSelectionScreen(
                        faction: 'spires',
                        initialFilter: initialFilter,
                        allowedFilters: allowedFilters,
                        title:
                            'Select Spires ${combatState.isDuelMode ? "Character" : "Regiment"}',
                        onUnitSelected: (regiment) {
                          // Ensure selected unit matches the required type
                          if (combatState.isDuelMode &&
                              !regiment.isCharacter()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'In duel mode, only character units can be selected'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          } else if (!combatState.isDuelMode &&
                              regiment.isCharacter()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Characters must be attached to regiments in normal mode'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (isAttacker) {
                            ref
                                .read(combatProvider.notifier)
                                .updateAttacker(regiment);
                          } else {
                            ref
                                .read(combatProvider.notifier)
                                .updateDefender(regiment);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
              // More factions...
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
