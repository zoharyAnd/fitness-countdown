import 'package:fitness_countdown/pages/splashpage.dart';
import 'package:fitness_countdown/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness countdown',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(
          isDarkMode: _isDarkMode,
          toggleTheme: () {
            setState(() {
              _isDarkMode = !_isDarkMode;
            });
          }),
    );
  }
}
