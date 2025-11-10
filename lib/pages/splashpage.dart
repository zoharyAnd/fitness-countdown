// ignore_for_file: use_build_context_synchronously

import 'package:fitness_countdown/pages/homepage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key, required this.isDarkMode, required this.toggleTheme});
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000));

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomePage(
              title: "Fitness Countdown",
              isDarkMode: widget.isDarkMode,
              toggleTheme: widget.toggleTheme),
        ));
  }

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/images/timer.gif')),
            Text(
              'FITNESS COUNTDOWN',
              style: TextStyle(color: Colors.white),
            )
          ],
        )));
  }
}
