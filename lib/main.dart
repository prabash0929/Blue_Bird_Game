import 'package:flutter/material.dart';
import 'game_page.dart';

void main() {
  runApp(const BlueBirdApp());
}

class BlueBirdApp extends StatelessWidget {
  const BlueBirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blue Bird Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GamePage(),
    );
  }
}