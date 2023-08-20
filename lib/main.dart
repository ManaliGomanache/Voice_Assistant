import 'package:flutter/material.dart';
import 'home.dart';
import 'pallete.dart';

void main() {
  runApp(const VoiceAI());
}

class VoiceAI extends StatelessWidget {
  const VoiceAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.whiteColor,
        ),
      ),
      home: const HomePage(),
    );
  }
}
