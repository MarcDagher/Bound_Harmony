import 'package:bound_harmony/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  // final List screens = [SurveysScreen(), SuggestionsScreen(), AdviceScreen(), ProfileScreen()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 233, 232, 232),
      fixedColor: const Color.fromARGB(255, 233, 98, 98),
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
      // selectedIndex: screens[currentIndex],
      // onDestinationSelected: (int index) {
      //   setState(() {
      //     currentIndex = index
      //   });
      // },
    );
  }
}


// all_inclusive_sharp -- alt_route_sharp 

// survey: app_registration_rounded -- article_outlined -- assignment -- border_color_outlined -- chrome_reader_mode_rounded -- edit_road_rounded

// advice: assistant - beenhere_outlined