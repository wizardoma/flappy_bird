import 'dart:async';
import 'dart:math';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;

  void _jump() {
    initialHeight = _birdYaxis;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        if (((initialHeight - height) >= -1) && ((initialHeight - height) <= 1)){
        _birdYaxis = initialHeight - height; }
        else {
          _birdYaxis = 0;
        }

      });
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
              onTap: _jump,
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
