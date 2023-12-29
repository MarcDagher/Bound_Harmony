import 'package:bound_harmony/screens/advice_screen.dart';
import 'package:bound_harmony/screens/profile_screen.dart';
import 'package:bound_harmony/screens/suggestions_screen.dart';
import 'package:bound_harmony/screens/surveys_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter boundHarmonyRouter = GoRouter(routes: <RouteBase>[
  /// Profile Screen
  ///
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const ProfileScreen();
    },
  ),

  /// Advice Screen
  ///
  GoRoute(
    path: '/advice',
    builder: (BuildContext context, GoRouterState state) {
      return const AdviceScreen();
    },
  ),

  /// Suggestions Screen
  ///
  GoRoute(
    path: '/suggestions',
    builder: (BuildContext context, GoRouterState state) {
      return const SuggestionsScreen();
    },
  ),

  /// Surveys Screen
  ///
  GoRoute(
    path: '/surveys',
    builder: (BuildContext context, GoRouterState state) {
      return const SurveysScreen();
    },
  ),
]);
