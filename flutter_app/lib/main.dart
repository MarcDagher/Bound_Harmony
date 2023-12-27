import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bound Harmony',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFF03E3F),
        hintColor: const Color(0xFF544B4C),
        fontFamily: "Nunito",
        useMaterial3: true,
      ),
      home: const LogInScreen(),
    );
  }
}
