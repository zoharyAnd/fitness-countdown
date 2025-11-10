import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      primary: Colors.black,
      secondary: Color.fromARGB(255, 240, 240, 240),
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        surface: Colors.black,
        primary: Colors.white,
        secondary: Color.fromARGB(255, 55, 51, 51)));
