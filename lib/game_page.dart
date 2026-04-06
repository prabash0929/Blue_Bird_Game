import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'widgets/bird.dart';
import 'widgets/pipe.dart';
import 'widgets/score.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;

  double gravity = -4.9;
  double velocity = 2.5;

  Timer? gameTimer;
  bool gameStarted = false;

  // Pipes start off-screen right
  List<double> pipeX = [1.5, 3.0, 4.5];
  List<double> pipeGaps = []; // Random gaps for each pipe
  Random random = Random();

  int score = 0;

  @override
  void initState() {
    super.initState();
    // Initialize random gaps for each pipe
    pipeGaps = List.generate(pipeX.length, (_) => randomGap());
  }

  // Generate random gap between 0.5 and 0.8
  double randomGap() {
    return 0.2 + random.nextDouble() * 0.2;
  }

  void startGame() {
    gameStarted = true;

    gameTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      time += 0.03;
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;

        // Move pipes
        for (int i = 0; i < pipeX.length; i++) {
          pipeX[i] -= 0.02;

          // Reset pipe when off-screen left and assign new random gap
          if (pipeX[i] < -1.5) {
            pipeX[i] = pipeX.reduce(max) + 2.0;
            pipeGaps[i] = randomGap();
          }

          // Update score when bird passes pipe
          if (pipeX[i] < 0 && pipeX[i] > -0.02) {
            score++;
          }
        }
      });

      // Collision detection with individual pipe gaps
      for (int i = 0; i < pipeX.length; i++) {
        if (pipeX[i] < 0.1 &&
            pipeX[i] > -0.1 &&
            (birdY < -pipeGaps[i] || birdY > pipeGaps[i] + 0.4)) {
          gameOver(timer);
        }
      }

      if (birdY > 1) {
        gameOver(timer);
      }
    });
  }

  void gameOver(Timer timer) {
    timer.cancel();
    gameStarted = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
            child: Text(
              'Game Over',
              style: TextStyle(color: Colors.white),
            )),
        content: Text(
          'Score: $score',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              padding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text(
              'Play Again',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  void resetGame() {
    setState(() {
      birdY = 0;
      gameStarted = false;
      time = 0;
      initialPos = birdY;
      pipeX = [1.5, 3.0, 4.5]; // reset off-screen right
      pipeGaps = List.generate(pipeX.length, (_) => randomGap()); // reset gaps
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!gameStarted) {
          startGame();
        } else {
          jump();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            /// Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cloud.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// Bird
            Bird(birdY: birdY),

            /// Pipes with random gaps
            for (int i = 0; i < pipeX.length; i++)
              Pipe(pipeX: pipeX[i], pipeGap: pipeGaps[i]),

            /// Score
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Score(score: score),
              ),
            ),

            /// Start Button
            if (!gameStarted)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    startGame();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    "TAP TO PLAY",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}