import 'dart:math';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _birdYaxis = 0;

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

  void _jump() async {
    setState(() {
      _birdYaxis = -0.8;
    });
    Future.delayed(
        Duration(milliseconds: 200),
        () => setState(() {
              _birdYaxis = 0;
            }));
  }
}
