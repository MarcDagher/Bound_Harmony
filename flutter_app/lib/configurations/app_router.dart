import 'package:bound_harmony/main_view.dart';
import 'package:bound_harmony/screens/advice_screen.dart';
import 'package:bound_harmony/screens/bonding_activities_screen.dart';
import 'package:bound_harmony/screens/connection_setup_screen.dart';
import 'package:bound_harmony/screens/date_builder_screen.dart';
import 'package:bound_harmony/screens/gift_ideas_screen.dart';
import 'package:bound_harmony/screens/incoming_requests_screen.dart';
import 'package:bound_harmony/screens/login_screen.dart';
import 'package:bound_harmony/screens/my_partners_screen.dart';
import 'package:bound_harmony/screens/onboarding_screen.dart';
import 'package:bound_harmony/screens/profile_screen.dart';
import 'package:bound_harmony/screens/signup_screen.dart';
import 'package:bound_harmony/screens/suggestions_screen.dart';
import 'package:bound_harmony/screens/surveys_screen.dart';
import 'package:bound_harmony/screens/take_survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  /// Private constructor meaning that instances of this class can't be created from outside it
  ///
  AppNavigation._();

  // the debug label is for easier identification
  /// GlobalKey instances are used to uniquely identify the different navigators in the app
  /// Each NavigatorState coresponds to a branch in the app and these keys help manage and control the navigation state within the branches (The main screens of the branch and its sub-screens)
  /// Theses are used when defining branches to ensure that each branch has its own navigation state. This organization helps in managing navigation independently within the different sections
  static final rootNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final rootNavigatorAdvice =
      GlobalKey<NavigatorState>(debugLabel: 'shellAdvice');
  static final rootNavigatorSurveys =
      GlobalKey<NavigatorState>(debugLabel: 'shellSurveys');
  static final rootNavigatorSuggestions =
      GlobalKey<NavigatorState>(debugLabel: 'shellSuggestions');
  static final rootNavigatorAppStarters =
      GlobalKey<NavigatorState>(debugLabel: 'shellAppStarters');
  static final rootNavigatorAuth =
      GlobalKey<NavigatorState>(debugLabel: 'shellAppAuth');

  /// The main router of the application
  ///
  static final GoRouter router = GoRouter(

      // Identifies the root navigator of the app
      // This key is then used to uniquely identify and interact with the top-level navigator
      // The top level navigator manages stack of routes and determines which route is currently displayed.Each Navigator has its own state.
      // The navigatorKey inside the MaterialApp is used to obtain the NavigatorState of the top-level navigator. This key allows you to perform actions on the top-level navigator, such as pushing or popping routes.
      // The navigator key below is associated with the Navigator that the GoRouter manages. It doesn't represent the top-level navigator but the navigator specifically created for the routes defined within the GoRouter.
      navigatorKey: GlobalKey<NavigatorState>(),

      /// Go Router Configuration, initial route that the application will navigate to when it starts
      initialLocation: '/login/signup',
      // turn true and check debug console for routes
      debugLogDiagnostics: false,

      /// route congiguration
      ///
      routes: <RouteBase>[
        /// Helps manage navigation within different branches
        ///  An IndexedStack is a widget that shows only one of its children at a time, and the child to be displayed is determined by an index.
        ///  the index corresponds to the currently active "branch"
        StatefulShellRoute.indexedStack(

            /// context includes information about the location of the widget in the widget tree, theme data, media queries,
            /// The state parameter is an instance of the GoRouterState. It represents the state of the GoRouter at the point where this route is being built.
            /// navigationShell parameter is used to pass an instance of StatefulNavigationShell which represent the navigation structure of a specific branch within the application
            builder: (context, state, navigationShell) {
              return MainView(
                // to provide info of navigation structure
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
              // Branch AppStarters
              StatefulShellBranch(
                  navigatorKey: rootNavigatorAppStarters,
                  routes: [
                    /// AppStarters sub-route On Boarding
                    ///
                    GoRoute(
                      path: '/onBoarding',
                      name: 'On Boarding',
                      builder: (context, state) {
                        return OnBoardingScreen(
                          key: state.pageKey,
                        );
                      },
                    )
                  ]),
              StatefulShellBranch(navigatorKey: rootNavigatorAuth, routes: [
                /// AppStarters sub-route login
                ///
                GoRoute(
                    path: '/login',
                    name: 'Log In',
                    builder: (context, state) {
                      return LogInScreen(
                        key: state.pageKey,
                      );
                    },
                    routes: [
                      /// AppStarters sub-route login
                      ///
                      GoRoute(
                        path: 'signup',
                        name: 'Sign Up',
                        builder: (context, state) {
                          return SignUpScreen(
                            key: state.pageKey,
                          );
                        },
                      ),

                      /// AppStarters sub-route Connection Setup
                      ///
                      GoRoute(
                        path: 'connectionSetup',
                        name: 'Connection Setup',
                        builder: (context, state) {
                          return ConnectionSetupScreen(
                            key: state.pageKey,
                          );
                        },
                      ),
                    ]),
              ]),
            ])
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
