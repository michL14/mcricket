import 'package:flutter/material.dart';
import 'package:mcricket/homepage.dart';
import 'package:mcricket/settings.dart';
import 'package:mcricket/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = const ColorScheme(
      primary: Color(0xFF92CFA5), // Couleur principale
      secondary: Color(0xFFF27457), // Couleur secondaire
      surface: Color(0xFFECE8E8), // Couleur de surface
      background: Color(0xFFECE8E8), // Couleur d'arrière-plan
      error: Color(0xFFF44336), // Couleur d'erreur
      onPrimary:
          Color(0xFFECE8E8), // Couleur de texte sur la couleur principale
      onSecondary:
          Color(0xFFECE8E8), // Couleur de texte sur la couleur secondaire
      onSurface:
          Color(0xFF000000), // Couleur de texte sur la couleur de surface
      onBackground:
          Color(0xFF000000), // Couleur de texte sur la couleur d'arrière-plan
      onError: Color(0xFFFFFFFF), // Couleur de texte sur la couleur d'erreur
      brightness: Brightness.light, // Luminosité du thème
    );
    return MaterialApp(
      theme: ThemeData(
        colorScheme: myColorScheme,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MyHomepage(),
        '/homepage': (context) => const MyHomepage(),
        '/splash': (context) => const SplashScreen(),
        '/settings': (context) => const Settings(),
      },
    );
  }
}
