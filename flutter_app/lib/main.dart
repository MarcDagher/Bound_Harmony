// import 'package:bound_harmony/screens/connection_setup_screen.dart';
import 'package:bound_harmony/screens/login_screen.dart';
import 'package:bound_harmony/screens/signup_screen.dart';
// import 'package:bound_harmony/screens/my_partners_screen.dart';
// import 'package:bound_harmony/screens/onBoarding_screen.dart';
// import 'package:bound_harmony/screens/profile_screen.dart';
// import 'package:bound_harmony/screens/signup_screen.dart';
// import 'package:bound_harmony/screens/suggestions_screen.dart';
// import 'package:bound_harmony/screens/surveys_screen.dart';
// import 'package:bound_harmony/screens/take_survey_screen.dart';
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
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            shape: Border.symmetric(
                horizontal: BorderSide(width: 0.2, color: Color(0xFF544B4C)))),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFF03E3F),
        hintColor: const Color(0xFF544B4C),
        fontFamily: "Nunito",
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}

// Screens [ 
//AdviceScreen,  [ Looks Good ] 
//BondingActivitiesScreen, [ Looks Good ]
//ConnectionSetupScreen, [ ------------- Not Loading ---------------- ]
//DateBuilderScreen,  [ Looks Good ]
//GiftIdeasScreen, [ Looks Good ]
//IncomingRequestsScreen, [ Needs ListView Builder maybe ]
//LogInScreen,  [ Looks Good ]
//MyPartnersScreen, [  Needs ListView Builder maybe  ]
//OnBoardingScreen, [ Looks Good ]
//ProfileScreen, [ Looks Good ]
//SignUpScreen, [ ------------- Not Loading ---------------- ]
//SuggestionsScreen, [ Looks Good ]
//SurveysScreen, [ Looks Good ]
//TakeSurveyScreen [ Looks Good ]
//] 