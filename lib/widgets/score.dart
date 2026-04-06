import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final int score;
  const Score({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.85),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3), // glass effect
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          score.toString(),
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}