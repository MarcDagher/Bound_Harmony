import 'dart:async';

import 'package:bound_harmony/providers/survey_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TakeSurveyScreen extends StatefulWidget {
  const TakeSurveyScreen({super.key});

  @override
  State<TakeSurveyScreen> createState() => _TakeSurveyScreenState();
}

class _TakeSurveyScreenState extends State<TakeSurveyScreen> {
  List options = ["potato", "onions"];
  List answers = ["Yes", "No"];
  String currentOption = "";
  String currentAnswer = "";
  @override
  Widget build(BuildContext context) {
    getSurveyRequest(id) async {
      await context.read<SurveysProvider>().getSurvey(id);
    }

    // getSurveyRequest(1);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("Couple's Survey"),
        ),
      ),
      //////////// END OF APPBAR
      body: Consumer<SurveysProvider>(builder: (context, value, child) {
        print("Inside screen: ${value.questions}");
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                ///////// BUILDING SURVEY'S QUESTIONS AND LOOPING OVER OPTIONS
                ///
                ///
                child: ListView.builder(
                  itemCount: value.questions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        buildQuestion(value.questions[index]!.question,
                            Theme.of(context).hintColor),
                        for (String option in value.questions[index]!.options)
                          buildRadioOption(
                              option: option, value: 0, groupValue: 0),
                      ],
                    );
                  },
                ),
              ),

              /////// REUSABLE SUBMIT BUTTON
              ///
              ///
              Button(
                  text: 'Submit',
                  handlePressed: () {},
                  // When all questions are answered change color to primary red
                  color: Theme.of(context).hintColor),
              const SizedBox(height: 10)
            ],
          ),
        );
      }),
    );
  }

  /////// BUILDER METHODS
  ///
  ///
  Widget buildQuestion(question, textColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 30),
        child: Text(question,
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.w700),
            overflow: TextOverflow.clip),
      ),
    );
  }

  Widget buildRadioOption({option, value, groupValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RadioListTile(
        title: Text(option, overflow: TextOverflow.clip),
        value: value,
        groupValue: groupValue,
        onChanged: (value) {},
        shape: ContinuousRectangleBorder(
            side: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.only(left: 6),
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }
}





// return Column(
        //   children: [
        //     RadioListTile(
        //       title: Text(options[0]),
        //       value: options[0],
        //       groupValue: currentOption,
        //       onChanged: (value) {
        //         setState(() {
        //           currentOption = value;
        //         });
        //         print(currentOption);
        //       },
        //     ),
        //     RadioListTile(
        //       title: Text(options[1]),
        //       value: options[1],
        //       groupValue: currentOption,
        //       onChanged: (value) {
        //         setState(() {
        //           currentOption = value;
        //         });
        //         print(currentOption);
        //       },
        //     ),
        //     RadioListTile(
        //       title: Text(answers[0]),
        //       value: answers[0],
        //       groupValue: currentAnswer,
        //       onChanged: (value) {
        //         setState(() {
        //           currentAnswer = value;
        //         });
        //         print(currentAnswer);
        //       },
        //     ),
        //     RadioListTile(
        //       title: Text(answers[1]),
        //       value: answers[1],
        //       groupValue: currentAnswer,
        //       onChanged: (value) {
        //         setState(() {
        //           currentAnswer = value;
        //         });
        //         print(currentAnswer);
        //       },
        //     ),
        //   ],
        // );