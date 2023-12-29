import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SurveysScreen extends StatelessWidget {
  const SurveysScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Surveys'),
        ),
      ),

      //////// END OF APPBAR
      ///
      ///

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(children: [
          const Row(
            children: [
              Text(
                'Pick a survey',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //////// PERSONAL SURVEY - ON CLICK - GO TO QUESTIONS
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.goNamed('Take Survey');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 226, 217, 215),
                                    Color(0xFF5CD3FF)
                                  ]),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            child: const Center(
                                child: Text(
                              'Personal Survey',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                //////// Couples SURVEY - ON CLICK - GO TO QUESTIONS
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.goNamed('Take Survey');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 241, 214, 174),
                                    Color.fromARGB(255, 236, 55, 70)
                                  ]),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            child: const Center(
                                child: Text("Couple's Survey",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      // bottomNavigationBar: MyNavigationBar(navigationShell: widget.navigationShell),
    );
  }
}
