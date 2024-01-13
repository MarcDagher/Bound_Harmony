import 'package:bound_harmony/providers/survey_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //////// PERSONAL SURVEY - ON CLICK - GO TO QUESTIONS
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.darken),
                              image: const AssetImage("assets/wallpaper 4.jpg"),
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: MaterialButton(
                          padding: const EdgeInsets.only(
                              left: 15, right: 5, top: 15, bottom: 15),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            context
                                .read<SurveysProvider>()
                                .successSavingPersonalSurveyResponse = false;
                            context.goNamed("Personal Survey");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Go To Personal Survey',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).hintColor),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Theme.of(context).hintColor,
                              )
                            ],
                          ),
                        ),
                      )),
                ),
                const SizedBox(height: 10),

                //////// Couples SURVEY - ON CLICK - GO TO QUESTIONS
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.darken),
                              image: const AssetImage("assets/wallpaper 4.jpg"),
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: MaterialButton(
                          padding: const EdgeInsets.only(
                              left: 15, right: 5, top: 15, bottom: 15),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            context
                                .read<SurveysProvider>()
                                .successSavingCouplesSurveyResponse = false;
                            context.goNamed("Couples Survey");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Go To Couple's Survey",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).hintColor),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Theme.of(context).hintColor,
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
