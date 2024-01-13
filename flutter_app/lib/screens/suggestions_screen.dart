import 'package:bound_harmony/reusable%20widgets/navigation_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Suggestions For You'),
        ),
      ),

      //////// END OF APPBAR
      ///
      ///

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //////// ON CLICK - GO TO Date Builder

                Expanded(
                  child: NavigationBox(
                      handlePressed: () {
                        context.goNamed('Date Builder');
                      },
                      imagePath: "assets/wallpaper 4.jpg",
                      title: "Date Builder"),
                ),

                const SizedBox(
                  height: 15,
                ),

                //////// ON CLICK - GO TO Date Bonding Activities
                buildSuggestionBox(
                    'Bonding Activities',
                    const Color.fromARGB(255, 241, 214, 174),
                    const Color.fromARGB(255, 236, 55, 70),
                    'Bonding Activities',
                    context),
                const SizedBox(height: 15),

                //////// ON CLICK - GO TO Date Bonding Activities
                buildSuggestionBox(
                    'Gift Ideas',
                    const Color.fromARGB(255, 150, 200, 180),
                    const Color.fromARGB(255, 50, 120, 150),
                    'Gift Ideas',
                    context),
              ],
            ),
          )
        ]),
      ),
    );
  }

  buildSuggestionBox(String text, Color color1, Color color2, String route,
      BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.goNamed(route);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color1, color2]),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: Center(
                    child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
