import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool loggedIn = true;
  bool hasAccount = true;
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    String currentNamedLocation =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    //// if user doesnt have account
    /// take to register

    //// if not loggied in
    /// go to login

    //// if logged in
    ///
    // if (hasAccount == true && loggedIn == true) {}
    // print('Im here for you $currentNamedLocation');
    // print(GoRouter.of(context).routeInformationProvider.value.uri);

    if (currentNamedLocation == '/onBoarding' ||
        currentNamedLocation == '/login' ||
        currentNamedLocation == '/login/signup' ||
        currentNamedLocation == '/login/connectionSetup') {
      return Scaffold(
        /// depending on The shell branch
        ///
        body: widget.navigationShell,
      );
    } else {
      return Scaffold(
        /// depending on The shell branch
        ///
        body: widget.navigationShell,

        /// Shell branch handler is in navbar
        ///
        bottomNavigationBar:
            MyNavigationBar(navigationShell: widget.navigationShell),
      );
    }
  }
}
