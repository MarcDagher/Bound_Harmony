import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

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
    //// if doesnt have accout
    /// take to register

    //// if not loggied in
    /// go to login

    //// if logged in
    ///
    // if (hasAccount == true && loggedIn == true) {
    return Scaffold(
      /// depending on The shell branch
      ///
      body: widget.navigationShell,

      /// Shell branch handler is in navbar
      ///
      bottomNavigationBar:
          MyNavigationBar(navigationShell: widget.navigationShell),
    );
    // }
  }
}

// SlidingClippedNavBar(
//         backgroundColor: Colors.white,
//         onButtonPressed: (index) {
//           setState(() {
//             selectedIndex = index;
//           });
//           changeBranch(selectedIndex);
//         },
//         iconSize: 30,
//         activeColor: Colors.black,
//         selectedIndex: selectedIndex,
//         barItems: [
//           BarItem(title: 'Surveys', icon: Icons.border_color_outlined),
//           BarItem(title: 'Suggestions', icon: Icons.assistant),
//           BarItem(title: 'Advice', icon: Icons.all_inclusive_sharp),
//           BarItem(title: 'Profile', icon: Icons.account_circle_rounded)
//         ],
//         fontSize: 16,
//         fontWeight: FontWeight.w800,
//       ),
