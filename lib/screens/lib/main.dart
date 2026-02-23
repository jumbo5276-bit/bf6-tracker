import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BF6App());
}

class BF6App extends StatelessWidget {
  const BF6App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BF6 Tracker',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
