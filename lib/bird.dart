import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      height: 40,
      width: 40,
      child: Image.asset(
        "lib/images/bird.png",
      ),
    );
  }

}
