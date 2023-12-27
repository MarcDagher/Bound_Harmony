import 'package:bound_harmony/screens/connection_setup_screen.dart';
import 'package:bound_harmony/screens/incoming_requests_screen.dart';
import 'package:bound_harmony/screens/login_screen.dart';
import 'package:bound_harmony/screens/my_partners_screen.dart';
import 'package:bound_harmony/screens/onBoarding_screen.dart';
import 'package:bound_harmony/screens/profile_screen.dart';
import 'package:bound_harmony/screens/signup_screen.dart';
import 'package:bound_harmony/screens/surveys_screen.dart';
import 'package:flutter/material.dart';

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
      home: const SurveysScreen(),
    );
  }
}
