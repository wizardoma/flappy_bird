import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double _birdYaxis = 0;
  double time = 0;
  double height = 0;
  int _score = 0;
  int _bestScore = 0;
  double initialHeight = _birdYaxis;
  bool isGameStarted = false;
  double barrierTopHeight = 1;
  double barrierBottomHeight = 1;
  GlobalKey barrierTopKey = GlobalKey();
  GlobalKey barrierBottomKey = GlobalKey();
  GlobalKey birdKey = GlobalKey();

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
        barrierBottomHeight -= 0.025;
        barrierTopHeight -= 0.025;
        _score = (_score + 0.1).ceil();
        if (_score > _bestScore) {
          _bestScore = _score;
        }

        if (barrierBottomHeight < -1) {
          barrierBottomHeight = 1;
        }
        if (barrierTopHeight < -1) {
          barrierTopHeight = 1;
        }
      });
      if (_birdYaxis > 1.1 || _birdYaxis < -1.05) {
        _resetGame(timer);
      }
      print("top " +
          barrierTopKey.currentContext!
              .findRenderObject()!
              .paintBounds
              .toString());
      print("bottom " +
          barrierBottomKey.currentContext!
              .findRenderObject()!
              .paintBounds
              .toString());
      print("bird " +
          birdKey.currentContext!.findRenderObject()!.paintBounds.toString());
    });
  }

  void _resetGame(Timer timer) {
    timer.cancel();

    setState(() {
      barrierBottomHeight = 1;
      barrierTopHeight = 1;
      _score = 0;
      time = 0;
      height = 0;
      isGameStarted = false;
      _birdYaxis = 0;
      initialHeight = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Game is over"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(children: [
              GestureDetector(
                onTap: () {
                  if (isGameStarted) {
                    _jump();
                  } else {
                    _startGame();
                  }
                },
                child: AnimatedContainer(
                  key: birdKey,
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(0, _birdYaxis),
                  color: Colors.blue,
                  child: MyBird(),
                ),
              ),
              AnimatedContainer(
                key: barrierTopKey,
                alignment: Alignment(barrierTopHeight, 1.1),
                duration: Duration(milliseconds: 0),
                child: MyBarrier(
                  height: 200.0,
                ),
              ),
              AnimatedContainer(
                key: barrierBottomKey,
                alignment: Alignment(barrierBottomHeight, -1.1),
                duration: Duration(milliseconds: 0),
                child: MyBarrier(
                  height: 200.0,
                ),
              ),
              if (!isGameStarted)
                Container(
                  alignment: Alignment(0, -0.3),
                  child: Text(
                    "T A P  T O  P L A Y",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
            ]),
          ),
          Container(
            height: 10,
            color: Colors.red,
          ),
          Expanded(
              child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            child: Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SCORE"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(_score.toString()),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("BEST"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(_bestScore.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
