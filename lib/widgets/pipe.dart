import 'package:flutter/material.dart';

class Pipe extends StatelessWidget {
  final double pipeX; // horizontal position (-1 to 1)
  final double pipeGap; // vertical gap between top and bottom pipe
  const Pipe({super.key, required this.pipeX, required this.pipeGap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Top pipe
        Positioned(
          left: (pipeX + 1) / 2 * screenWidth, // convert -1..1 to 0..width
          top: 0,
          child: Container(
            width: 60,
            height: (screenHeight / 2) - pipeGap * screenHeight / 2,
            decoration: BoxDecoration(
              color: Colors.lightGreen[400], // light green color
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45, blurRadius: 4, offset: Offset(2, 2))
              ],
            ),
          ),
        ),

        // Bottom pipe
        Positioned(
          left: (pipeX + 1) / 2 * screenWidth,
          top: (screenHeight / 2) + pipeGap * screenHeight / 2,
          child: Container(
            width: 60,
            height: (screenHeight / 2) - pipeGap * screenHeight / 2,
            decoration: BoxDecoration(
              color: Colors.lightGreen[400], // light green color
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45, blurRadius: 4, offset: Offset(2, 2))
              ],
            ),
          ),
        ),
      ],
    );
  }
}