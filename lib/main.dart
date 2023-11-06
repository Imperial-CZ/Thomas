import 'package:flutter/material.dart';
import 'package:thomas/ui/screens/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thomas",
      home: HomeScreen(),
    );
  }
}
