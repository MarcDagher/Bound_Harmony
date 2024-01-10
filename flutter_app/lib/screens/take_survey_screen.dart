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
    Response(questionId: 1, response: ""),
    Response(questionId: 2, response: ""),
    Response(questionId: 3, response: ""),
    Response(questionId: 4, response: ""),
    Response(questionId: 5, response: ""),
    Response(questionId: 6, response: ""),
    Response(questionId: 7, response: ""),
    Response(questionId: 8, response: ""),
    Response(questionId: 9, response: ""),
    Response(questionId: 10, response: ""),
    Response(questionId: 11, response: ""),
    Response(questionId: 12, response: ""),
    Response(questionId: 13, response: ""),
    Response(questionId: 14, response: ""),
    Response(questionId: 15, response: ""),
    Response(questionId: 16, response: ""),
    Response(questionId: 17, response: ""),
    Response(questionId: 18, response: ""),
    Response(questionId: 19, response: ""),
    Response(questionId: 20, response: ""),
  ];

  bool personalSurveyComplete = false;

  checkIfComplete(context, personalSurveyResponses) {
    for (Response response in personalSurveyResponses) {
      if (response.response == "") {
        setState(() {
          personalSurveyComplete = false;
        });
        return;
      }
    }
    setState(() {
      personalSurveyComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    getSurveyRequest(id) async {
      await context.read<SurveysProvider>().getSurvey(id);
    }

    getSurveyRequest(1);

    Color buttonColor = personalSurveyComplete == true
        ? Theme.of(context).primaryColor
        : Theme.of(context).hintColor;

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
                  itemBuilder: (context, questionIndex) {
                    return Column(
                      children: [
                        buildQuestion(value.questions[questionIndex]!.question,
                            Theme.of(context).hintColor),
                        for (String option
                            in value.questions[questionIndex]!.options)
                          buildRadioOption(
                              option: option,
                              chosenOption: option,
                              listOfOptions:
                                  value.questions[questionIndex]!.options,
                              questionIndex: questionIndex),
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
                    print(
                        "From button: ${personalSurveyResponses[1].response}");
                  },
                  // When all questions are answered change color to primary red
                  color: buttonColor),
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

  Widget buildRadioOption({
    required String option,
    required String chosenOption,
    required listOfOptions,
    required int questionIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RadioListTile(
        title: Text(option, overflow: TextOverflow.clip),
        value: chosenOption,
        groupValue: personalSurveyResponses[questionIndex].response,
        onChanged: (chosenResponse) {
          setState(() {
            personalSurveyResponses[questionIndex].response =
                chosenResponse as String;
          });
          checkIfComplete(context, personalSurveyResponses);

          print(personalSurveyComplete);
          // print(
          //     "chosenResponse: $chosenResponse, listOfOptions: $listOfOptions, questionIndex: $questionIndex");
          // print(
          //     "After set state: ${personalSurveyResponses[questionIndex].response}");
        },
        shape: ContinuousRectangleBorder(
            side: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.only(left: 6),
        // activeColor: Theme.of(context).primaryColor,
        selectedTileColor: Colors.amber,
      ),
    );
  }
}
