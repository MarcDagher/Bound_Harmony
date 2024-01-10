import 'dart:async';

import 'package:bound_harmony/models/survey_model.dart';
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
  List<Response> personalSurveyResponses = [
    // Response(questionId: 1, response: ""),
    // Response(questionId: 2, response: ""),
    // Response(questionId: 3, response: ""),
    // Response(questionId: 4, response: ""),
    // Response(questionId: 5, response: ""),
    // Response(questionId: 6, response: ""),
    // Response(questionId: 7, response: ""),
    // Response(questionId: 8, response: ""),
    // Response(questionId: 9, response: ""),
    // Response(questionId: 10, response: ""),
    // Response(questionId: 11, response: ""),
    // Response(questionId: 12, response: ""),
    // Response(questionId: 13, response: ""),
    // Response(questionId: 14, response: ""),
    // Response(questionId: 15, response: ""),
    // Response(questionId: 16, response: ""),
    // Response(questionId: 17, response: ""),
    // Response(questionId: 18, response: ""),
    // Response(questionId: 19, response: ""),
    // Response(questionId: 20, response: ""),
  ];
  @override
  Widget build(BuildContext context) {
    getSurveyRequest(id) async {
      await context.read<SurveysProvider>().getSurvey(id);
    }

    getSurveyRequest(1);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("Couple's Survey"),
        ),
      ),
      //////////// END OF APPBAR
      body: Consumer<SurveysProvider>(builder: (context, value, child) {
        // print("Inside screen: ${value.questions.length}");
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
                              option: option,
                              chosenOption: option,
                              listOfOptions: value.questions[index]!.options),
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
                  handlePressed: () {
                    print("From button: ${value.questions[0]!.options}");
                  },
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

  Widget buildRadioOption({option, chosenOption, listOfOptions}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RadioListTile(
        title: Text(option, overflow: TextOverflow.clip),
        value: chosenOption,
        groupValue: listOfOptions,
        onChanged: (value) {
          print("chosenOption: $chosenOption, listOfOptions: $listOfOptions");
        },
        shape: ContinuousRectangleBorder(
            side: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.only(left: 6),
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

// List options = ["potato", "onions"];
// List answers = ["Yes", "No"];
// String currentOption = "";
// String currentAnswer = "";

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
