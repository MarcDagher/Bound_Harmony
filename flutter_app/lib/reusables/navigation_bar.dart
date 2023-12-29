import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MyNavigationBar extends StatefulWidget {
  StatefulNavigationShell navigationShell;

  MyNavigationBar({super.key, required this.navigationShell});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  /// method for handling navigation branches
  ///
  void changeBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SlidingClippedNavBar(
      backgroundColor: Colors.white,
      onButtonPressed: (index) {
        setState(() {
          selectedIndex = index;
        });
        changeBranch(selectedIndex);
      },
      iconSize: 30,
      activeColor: Colors.black,
      selectedIndex: selectedIndex,
      barItems: [
        BarItem(title: 'Surveys', icon: Icons.border_color_outlined),
        BarItem(title: 'Suggestions', icon: Icons.assistant),
        BarItem(title: 'Advice', icon: Icons.all_inclusive_sharp),
        BarItem(title: 'Profile', icon: Icons.account_circle_rounded)
      ],
    );
  }
}


// all_inclusive_sharp -- alt_route_sharp 

// survey: app_registration_rounded -- article_outlined -- assignment -- border_color_outlined -- chrome_reader_mode_rounded -- edit_road_rounded

// advice: assistant - beenhere_outlined

// BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: const Color.fromARGB(255, 233, 232, 232),
//       selectedItemColor: const Color.fromARGB(255, 243, 67, 67),
//       unselectedItemColor: const Color.fromARGB(255, 190, 186, 186),
//       selectedLabelStyle:
//           TextStyle(color: const Color.fromARGB(255, 190, 186, 186)),
//       currentIndex: currentIndex,
//       items: const [
//         BottomNavigationBarItem(
//             icon: Icon(Icons.border_color_outlined), label: 'Surveys'),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.assistant), label: 'Suggestions'),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.all_inclusive_sharp), label: 'Advice'),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle_rounded), label: 'Profile')
//       ],
//       onTap: (int newIndex) {
//         setState(() {
//           currentIndex = newIndex;
//         });
//         context.go(routes[currentIndex]);
//       },
//     );