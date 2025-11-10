import 'package:fitness_countdown/widgets/countdown.dart';
import 'package:fitness_countdown/widgets/settings_popup.dart';
import 'package:fitness_countdown/widgets/theme_toggler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.title,
      required this.isDarkMode,
      required this.toggleTheme});

  final String title;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _sessionDuration = 10;
  int _nbOfSets = 2;
  int _pause = 5;

  void updateSettings(sessionDuration, nbOfSets, pause) {
    setState(() {
      _sessionDuration = sessionDuration;
      _nbOfSets = nbOfSets;
      _pause = pause;
    });
  }

  void _showPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 300,
          child: SettingsPopup(
              sessionDuration: _sessionDuration,
              nbOfSets: _nbOfSets,
              pause: _pause,
              updateSettings: updateSettings),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeBackground = Theme.of(context).colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.title),
        ),
        automaticallyImplyLeading: false,
        actions: [
          ThemeToggler(
              isDarkMode: widget.isDarkMode, toggleTheme: widget.toggleTheme)
        ],
      ),
      backgroundColor: themeBackground,
      body: Countdown(
          key: UniqueKey(),
          sessionDuration: _sessionDuration,
          nbOfSets: _nbOfSets,
          pause: _pause),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPopup(context),
        child: const Icon(Icons.settings),
      ),
    );
  }
}
