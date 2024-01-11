import 'package:bound_harmony/models/survey_model.dart';
import 'package:bound_harmony/providers/survey_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
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

  bool? isChecked = false;
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
                  itemCount: value.questions.length,
                  itemBuilder: (context, questionIndex) {
                    return Column(
                      children: [
                        // if (value.questions[questionIndex]!.type == "radio" ||
                        //     value.questions[questionIndex]!.type == "checkbox")
                        buildQuestion(
                            question: value.questions[questionIndex]!.question),

                        /// If radio buttons
                        ///
                        if (value.questions[questionIndex]!.type == "radio")
                          for (String option
                              in value.questions[questionIndex]!.options)
                            buildRadioOption(
                                option: option,
                                chosenOption:
                                    coupleSurveyResponses[questionIndex]
                                        .response,
                                questionIndex: questionIndex),

                        /// If checbox
                        ///
                        if (value.questions[questionIndex]!.type == "checkbox")
                          for (String option
                              in value.questions[questionIndex]!.options)
                            buildCheckbox(option: option),

                        /// If Input
                        ///
                        if (value.questions[questionIndex]!.type == "text")
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: TextInputField(
                                placeholder: "Enter your response here..."),
                          )
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

  Widget buildCheckbox({required String option}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: CheckboxListTile(
        title: Text(option),
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Theme.of(context).primaryColor,
        checkColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 7, right: 0),
        shape: ContinuousRectangleBorder(
            side: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(8)),
        value: false,
        onChanged: (value) {
          ///
        },
      ),
    );
  }
}
