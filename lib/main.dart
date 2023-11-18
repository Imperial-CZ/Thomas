import 'package:flutter/material.dart';
import 'package:thomas/ui/screens/home/home_screen.dart';
import 'package:flame/flame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thomas",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
