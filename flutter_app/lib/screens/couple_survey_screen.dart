import 'package:bound_harmony/models/survey_model.dart';
import 'package:bound_harmony/providers/survey_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouplesSurveyScreen extends StatefulWidget {
  const CouplesSurveyScreen({super.key});

  @override
  State<CouplesSurveyScreen> createState() => _CouplesSurveyScreenState();
}

class _CouplesSurveyScreenState extends State<CouplesSurveyScreen> {
  final List list = [1, 2, 3, 4, 5];

  // The list of Response Models I will send to the provider's method, where I will divide and send to database
  final List<Response> coupleSurveyResponses = [
    Response(questionId: 21, response: ""),
    Response(questionId: 22, response: ""),
    Response(questionId: 23, response: ""),
    Response(questionId: 24, response: ""),
    Response(questionId: 25, response: ""),
    Response(questionId: 26, response: ""),
    Response(questionId: 27, response: ""),
    Response(questionId: 28, response: ""),
    Response(questionId: 29, response: ""),
  ];

  @override
  Widget build(BuildContext context) {
    // This method will fetch all questions and options of the Couple's Survey
    getSurveyRequest(id) async {
      await context.read<SurveysProvider>().getSurvey(id);
    }

    getSurveyRequest(2);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Couple's Survey"),
      ),
      //////////// END OF APPBAR
      body: Consumer<SurveysProvider>(builder: (context, value, child) {
        // print("Inside consumer: ${value.questions[0]!.type}");
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                ///////// BUILDING SURVEY'S QUESTIONS AND LOOPING OVER OPTIONS
                ///
                ///
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, questionIndex) {
                    return Column(
                      children: [
                        /// If radio buttons
                        ///
                        if (value.questions[questionIndex]!.type == "radio")
                          buildQuestion(
                              question:
                                  value.questions[questionIndex]!.question),
                        if (value.questions[questionIndex]!.type == "radio")
                          for (String option
                              in value.questions[questionIndex]!.options)
                            buildRadioOption(
                                option: option,
                                chosenOption:
                                    coupleSurveyResponses[questionIndex]
                                        .response,
                                questionIndex: questionIndex),
                      ],
                    );
                  },
                ),
              ),

              /////// REUSABLE SUBMIT BUTTON
              ///
              ///
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Button(
                    text: 'Submit',
                    handlePressed: () async {},

                    // When all questions are answered change color to primary red
                    color: Theme.of(context).hintColor),
              ),
            ],
          ),
        );
      }),
    );
  }

  /////// BUILDER METHODS
  ///
  ///
  Widget buildQuestion({required String question}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 30),
        child: Text(question,
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 20,
                fontWeight: FontWeight.w700),
            overflow: TextOverflow.clip),
      ),
    );
  }

  Widget buildRadioOption({
    required String option,
    required String chosenOption,
    required int questionIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RadioListTile(
        title: Text(option, overflow: TextOverflow.clip),
        value: option,
        groupValue: chosenOption,
        onChanged: (chosenResponse) {
          setState(() {
            coupleSurveyResponses[questionIndex].response =
                chosenResponse as String;
          });
          // print(
          //   "In setState, chosenOption: $chosenOption, chosenResponse: $chosenResponse, in list: ${coupleSurveyResponses[questionIndex].response}",
          // );
        },
        shape: ContinuousRectangleBorder(
            side: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.only(left: 6),
        activeColor: Theme.of(context).primaryColor,
        selectedTileColor: Colors.amber,
      ),
    );
  }
}
