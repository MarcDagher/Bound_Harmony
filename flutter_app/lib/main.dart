import 'package:bound_harmony/screens/incoming_requests_screen.dart';
import 'package:bound_harmony/screens/my_partners_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:bound_harmony/configurations/bound_harmony_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bound Harmony',

      //// Design themes + setup
      ///
      ///
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

      //// Go Router
      ///
      ///
      routerConfig: boundHarmonyRouter,
    );
  }
}

// Screens [ 
//AdviceScreen,  [ Looks Good ] 
//BondingActivitiesScreen, [ Looks Good ]
//ConnectionSetupScreen, [ Looks Good ]
//DateBuilderScreen,  [ Looks Good ]
//GiftIdeasScreen, [ Looks Good ]
//IncomingRequestsScreen, [ Looks Good -- could use more colors]
//LogInScreen,  [ Looks Good ]
//MyPartnersScreen, [ Looks Good  ]
//OnBoardingScreen, [ Looks Good ]
//ProfileScreen, [ Looks Good ]
//SignUpScreen, [ Looks Good ] 
//SuggestionsScreen, [ Looks Good ]
//SurveysScreen, [ Looks Good ]
//TakeSurveyScreen [ Looks Good ]
//] 