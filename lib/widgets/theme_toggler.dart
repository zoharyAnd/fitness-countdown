import 'package:flutter/material.dart';

class ThemeToggler extends StatefulWidget {
  const ThemeToggler(
      {super.key, required this.isDarkMode, required this.toggleTheme});

  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  State<ThemeToggler> createState() => _ThemeTogglerState();
}

class _ThemeTogglerState extends State<ThemeToggler> {
  @override
  Widget build(BuildContext context) {
    final themePrimaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ElevatedButton(
            child: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: themePrimaryColor),
            onPressed: () {
              widget.toggleTheme();
            }));
  }
}
