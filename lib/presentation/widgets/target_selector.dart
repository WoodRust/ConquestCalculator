// lib/presentation/widgets/target_selector.dart
import 'package:flutter/material.dart';

class TargetSelector extends StatelessWidget {
  final int selectionLimit;
  final int initialValue;
  final ValueChanged<int> onChanged;
  final double textSize;

  const TargetSelector({
    super.key,
    required this.selectionLimit,
    required this.initialValue,
    required this.onChanged,
    this.textSize = 16, // Default text size
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: initialValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: TextStyle(
        color: Colors.deepPurple,
        fontSize: textSize, // Use the provided text size
      ),
      underline: Container(height: 2, color: Colors.deepPurpleAccent),
      onChanged: (int? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      items: List.generate(selectionLimit, (index) => index + 1)
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
