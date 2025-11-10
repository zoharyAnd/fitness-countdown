import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Countdown extends StatefulWidget {
  const Countdown(
      {super.key,
      required this.sessionDuration,
      required this.nbOfSets,
      required this.pause});

  final int sessionDuration;
  final int nbOfSets;
  final int pause;

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late double _percentage = 1.0;
  late int _initialCounter = 0;
  late int _counter = 0;
  late int _pauseCounter = 0;
  late int _setsCompleted = 0;
  late bool _pausing = false;
  final player = AudioPlayer();

  Timer? _timer;
  Timer? _pauseTimer;

  void playCounter(int aCounter) {
    switch (aCounter) {
      case 1:
        player.play(AssetSource('sounds/1.mp3'));
        break;
      case 2:
        player.play(AssetSource('sounds/2.mp3'));
        break;
      case 3:
        player.play(AssetSource('sounds/3.mp3'));
        break;
      default:
        break;
    }
  }

  void _startCountdown() {
    player.play(AssetSource('sounds/start.mp3'));

    if (_timer != null) {
      _timer!.cancel();
    }

    if (_pauseTimer != null) {
      _pauseTimer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
          _percentage = (_counter * 100 / _initialCounter) / 100;
          _pausing = false;
          playCounter(_counter);
        } else {
          _timer!.cancel();
          _setsCompleted++;

          if (_setsCompleted < widget.nbOfSets) {
            _pausing = true;
            _counter = _initialCounter;
            _percentage = 1.0;
            player.play(AssetSource('sounds/pause.mp3'));

            _pauseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
              setState(() {
                _pauseCounter--;
                playCounter(_pauseCounter);
              });
            });

            // Wait for the pause before starting the countdown again
            Future.delayed(Duration(seconds: widget.pause), () {
              _startCountdown(); // Start the countdown again
            });
          } else {
            player.play(AssetSource('sounds/congrats.mp3'));
          }
        }
      });
    });
  }

  void _resetCountdown() {
    setState(() {
      _counter = _initialCounter;
      _percentage = 1.0;
      _setsCompleted = 0;
      _pausing = false;
    });
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _initialCounter = widget.sessionDuration;
    _counter = widget.sessionDuration;
    _pauseCounter = widget.pause;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pauseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeSecondary = Theme.of(context).colorScheme.secondary;
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Text(
                  "Session: ${widget.nbOfSets} sets of ${widget.sessionDuration} seconds"),
              Text("Pause: ${widget.pause} seconds"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                    onPressed: _resetCountdown,
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (states) => themeSecondary),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 15, right: 20, bottom: 15, left: 20),
                      child: Text(
                        'RESTART SESSION',
                        style: TextStyle(fontSize: 16),
                      ),
                    )),
              ),
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStateProperty.resolveWith(
                    (states) => 0), // Set elevation to 0
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) => const Color.fromARGB(61, 168, 165, 165)),
                fixedSize: WidgetStateProperty.all(const Size(200, 200)),
              ),
              onPressed: () {
                if (_counter == 0 || _counter == widget.sessionDuration) {
                  _resetCountdown();
                  _startCountdown();
                }
              },
              child: CircularPercentIndicator(
                  radius: 100,
                  percent: _percentage,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    _pausing ? "$_pauseCounter" : "$_counter",
                    style: const TextStyle(fontSize: 40),
                  ),
                  progressColor: _pausing
                      ? const Color.fromARGB(255, 246, 2, 128)
                      : const Color.fromARGB(255, 0, 236, 209),
                  lineWidth: 15,
                  backgroundColor: Colors.transparent,
                  animateFromLastPercent: true)),
          Text(
            "Remaining: ${widget.nbOfSets - _setsCompleted} sets",
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    ));
  }
}
