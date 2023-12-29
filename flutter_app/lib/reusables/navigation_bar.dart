import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  final List routes = ['/surveys', '/suggestions', '/advice', '/'];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    int routesIndex = 0;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 233, 232, 232),
      fixedColor: const Color.fromARGB(255, 243, 67, 67),
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
      currentIndex: routesIndex,
      onTap: (int index) {
        setState(() {
          routesIndex = index;
        });
        context.go(routes[routesIndex]);
      },
    );
  }
}


// all_inclusive_sharp -- alt_route_sharp 

// survey: app_registration_rounded -- article_outlined -- assignment -- border_color_outlined -- chrome_reader_mode_rounded -- edit_road_rounded

// advice: assistant - beenhere_outlined