import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// method for handling navigation branches
  ///
  void changeBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 233, 232, 232),
        selectedItemColor: const Color.fromARGB(255, 243, 67, 67),
        unselectedItemColor: const Color.fromARGB(255, 190, 186, 186),
        selectedLabelStyle:
            TextStyle(color: const Color.fromARGB(255, 190, 186, 186)),
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.border_color_outlined), label: 'Surveys'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assistant), label: 'Suggestions'),
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inclusive_sharp), label: 'Advice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: 'Profile')
        ],
        onTap: (int newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
          changeBranch(selectedIndex);
        },
      ),
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
