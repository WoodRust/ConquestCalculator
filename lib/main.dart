// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/combat_calculator_screen.dart';
import 'presentation/themes/app_theme.dart';
import 'data/sources/local/special_rules_service.dart';

void main() async {
  // Set preferred orientations
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style for status bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppTheme.claudeSurface,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Initialize the special rules service
  await SpecialRulesService().initialize();

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
      title: 'Conquest Combat Calculator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          ThemeMode.light, // Always use light theme for Claude.ai aesthetic
      home: const CombatCalculatorScreen(),
    );
  }
}
