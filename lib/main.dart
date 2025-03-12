// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/combat_calculator_screen.dart';
import 'presentation/themes/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ConquestCalculatorApp(),
    ),
  );
}

class ConquestCalculatorApp extends StatelessWidget {
  const ConquestCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conquest Calculator',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const CombatCalculatorScreen(),
    );
  }
}
