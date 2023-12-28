import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';

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
          const Text(
            'Check your personalized suggestions:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //////// ON CLICK - GO TO Date Builder

                buildSurveyBox(
                    'Date Builder',
                    const Color.fromARGB(255, 226, 217, 215),
                    const Color(0xFF5CD3FF)),
                const SizedBox(height: 15),

                //////// ON CLICK - GO TO Date Bonding Activities
                buildSurveyBox(
                    'Bonding Activities',
                    const Color.fromARGB(255, 241, 214, 174),
                    const Color.fromARGB(255, 236, 55, 70)),
                const SizedBox(height: 15),

                //////// ON CLICK - GO TO Date Bonding Activities
                buildSurveyBox(
                  'Gift Ideas',
                  const Color.fromARGB(255, 150, 200, 180),
                  const Color.fromARGB(255, 50, 120, 150),
                ),
              ],
            ),
          )
        ]),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }

  buildSurveyBox(String text, Color color1, Color color2) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
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
        ],
      ),
    );
  }
}
