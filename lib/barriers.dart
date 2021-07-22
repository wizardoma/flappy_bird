import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double height;

  const MyBarrier({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 5),
        borderRadius: BorderRadius.circular(15),
        color: Colors.green,
      ),
    );
  }

}