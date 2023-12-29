import 'package:bound_harmony/main_view.dart';
import 'package:bound_harmony/screens/advice_screen.dart';
import 'package:bound_harmony/screens/bonding_activities_screen.dart';
import 'package:bound_harmony/screens/date_builder_screen.dart';
import 'package:bound_harmony/screens/gift_ideas_screen.dart';
import 'package:bound_harmony/screens/incoming_requests_screen.dart';
import 'package:bound_harmony/screens/my_partners_screen.dart';
import 'package:bound_harmony/screens/profile_screen.dart';
import 'package:bound_harmony/screens/suggestions_screen.dart';
import 'package:bound_harmony/screens/surveys_screen.dart';
import 'package:bound_harmony/screens/take_survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  /// Private constructor meaning that instances of this class can't be created from outside it
  ///
  AppNavigation._();

  /// the initial route that the application will navigate to when it starts
  ///
  static String initalRoute = '/profile';

  /// Private Navigators keys section
  /// GlobalKey instances are used to uniquely identify navigators in the app
  // the debug label is for easier identification
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final rootNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final rootNavigatorAdvice =
      GlobalKey<NavigatorState>(debugLabel: 'shellAdvice');
  static final rootNavigatorSurveys =
      GlobalKey<NavigatorState>(debugLabel: 'shellSurveys');
  static final rootNavigatorSuggestions =
      GlobalKey<NavigatorState>(debugLabel: 'shellSuggestions');

  /// The main router of the application
  ///
  static final GoRouter router = GoRouter(

      /// Go Router Configuration
      ///
      // the initial route of the app with its navigator key
      // the navigator key identifies the root navigator of the app
      initialLocation: initalRoute,
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics:
          false, // turn true and check debug console for routes

      /// route congiguration
      ///
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return MainView(
                navigationShell: navigationShell,
              );
            },
            //Each StatefulShellBranch represents a different "branch" or part of the application. A branch is essentially a section of the app that has its own navigation stack. In this example, there's a branch for the profile screen.
            branches: <StatefulShellBranch>[
              // Branch Surveys
              StatefulShellBranch(navigatorKey: rootNavigatorSurveys, routes: [
                GoRoute(
                  path: '/surveys',
                  name: 'Surveys',
                  builder: (context, state) {
                    return SurveysScreen(
                      key: state.pageKey,
                    );
                  },
                  routes: [
                    /// Surveys sub-route Take Survey
                    ///
                    GoRoute(
                      path: 'takeSurvey',
                      name: 'Take Survey',
                      builder: (context, state) {
                        return TakeSurveyScreen(
                          key: state.pageKey,
                        );
                      },
                    )
                  ],
                ),
              ]),

              // Branch Suggestions
              StatefulShellBranch(
                  navigatorKey: rootNavigatorSuggestions,
                  routes: [
                    GoRoute(
                        path: '/suggestions',
                        name: 'Suggestions',
                        builder: (context, state) {
                          return SuggestionsScreen(
                            key: state.pageKey,
                          );
                        },
                        routes: [
                          /// Suggestions sub-route Date Builder
                          ///
                          GoRoute(
                            path: 'dateBuilder',
                            name: 'Date Builder',
                            builder: (context, state) {
                              return DateBuilderScreen(
                                key: state.pageKey,
                              );
                            },
                          ),

                          /// Suggestions sub-route Bonding Activities
                          ///
                          GoRoute(
                            path: 'bondingActivities',
                            name: 'Bonding Activities',
                            builder: (context, state) {
                              return BondingActivitiesScreen(
                                key: state.pageKey,
                              );
                            },
                          ),

                          /// Suggestions sub-route Gift Ideas
                          ///
                          GoRoute(
                            path: 'giftIdeas',
                            name: 'Gift Ideas',
                            builder: (context, state) {
                              return GiftIdeasScreen(
                                key: state.pageKey,
                              );
                            },
                          ),
                        ]),
                  ]),

              // Branch Advice
              StatefulShellBranch(navigatorKey: rootNavigatorAdvice, routes: [
                GoRoute(
                  path: '/advice',
                  name: 'Advice',
                  builder: (context, state) {
                    return AdviceScreen(
                      key: state.pageKey,
                    );
                  },
                ),
              ]),
              // Branch Profile
              //This is a class that represents a branch in the application. It contains a navigator key (navigatorKey) and a list of routes specific to that branch.
              StatefulShellBranch(navigatorKey: rootNavigatorProfile, routes: [
                GoRoute(
                  path: '/profile',
                  name: 'Profile',
                  builder: (context, state) {
                    return ProfileScreen(
                      key: state.pageKey,
                    );
                  },

                  /// Profile sub-screen: Incoming Requests
                  ///
                  routes: [
                    GoRoute(
                        path: 'incomingRequests',
                        name: 'Incoming Requests',
                        builder: (context, state) {
                          return IncomingRequestsScreen(
                            key: state.pageKey,
                          );
                        }),

                    /// Profile sub-screen: My Partners
                    ///
                    GoRoute(
                      path: 'myPartners',
                      name: 'My Partners',
                      builder: (context, state) {
                        return MyPartnersScreen(
                          key: state.pageKey,
                        );
                      },
                    )
                  ],
                ),
              ]),
            ]),
      ]);
}

// final GoRouter boundHarmonyRouter = GoRouter(routes: <RouteBase>[
//   /// Profile Screen
//   ///
//   GoRoute(
//     path: '/',
//     builder: (BuildContext context, GoRouterState state) {
//       return const ProfileScreen();
//     },
//   ),

//   /// Advice Screen
//   ///
//   GoRoute(
//     path: '/advice',
//     builder: (BuildContext context, GoRouterState state) {
//       return const AdviceScreen();
//     },
//   ),

//   /// Suggestions Screen
//   ///
//   GoRoute(
//     path: '/suggestions',
//     builder: (BuildContext context, GoRouterState state) {
//       return const SuggestionsScreen();
//     },
//   ),

//   /// Surveys Screen
//   ///
//   GoRoute(
//     path: '/surveys',
//     builder: (BuildContext context, GoRouterState state) {
//       return const SurveysScreen();
//     },
//   ),
// ]);
