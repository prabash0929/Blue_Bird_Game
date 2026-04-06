import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  final double birdY;
  const Bird({super.key, required this.birdY});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, birdY),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Image.asset('assets/images/bird.png'),
      ),
    );
  }
}