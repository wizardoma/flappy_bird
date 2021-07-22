import 'dart:async';
import 'dart:math';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double _birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = _birdYaxis;
  bool isGameStarted = false;

  void _jump() {
    setState(() {
      time = 0;
      initialHeight = _birdYaxis;
    });
  }

  void _startGame() {
    isGameStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        _birdYaxis = initialHeight - height;
      });
      if (_birdYaxis > 1) {
        timer.cancel();
        isGameStarted = true;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (isGameStarted) {
                  _jump();
                } else {
                  _startGame();
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 0),
                alignment: Alignment(0, _birdYaxis),
                color: Colors.blue,
                child: MyBird(),
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.green,
          ))
        ],
      ),
    );
  }
}
