import 'package:bound_harmony/models/survey_model.dart';
import 'package:bound_harmony/providers/survey_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CouplesSurveyScreen extends StatefulWidget {
  const CouplesSurveyScreen({super.key});

  @override
  State<CouplesSurveyScreen> createState() => _CouplesSurveyScreenState();
}

class _CouplesSurveyScreenState extends State<CouplesSurveyScreen> {
  // The list of Response Models I will send to the provider's method, where I will divide and send to database
  final List<CoupleSurveyResponse> coupleSurveyResponses = [
    CoupleSurveyResponse(questionId: 21, response: ""),
    CoupleSurveyResponse(questionId: 22, checkboxes: [], isChecked: []),
    CoupleSurveyResponse(questionId: 23, checkboxes: [], isChecked: []),
    CoupleSurveyResponse(questionId: 24, checkboxes: [], isChecked: []),
    CoupleSurveyResponse(questionId: 25, response: ""),
    CoupleSurveyResponse(questionId: 26, response: ""),
    CoupleSurveyResponse(questionId: 27, response: ""),
    CoupleSurveyResponse(questionId: 28, checkboxes: [], isChecked: []),
    CoupleSurveyResponse(questionId: 29, response: ""),
  ];

  bool coupleSurveyComplete = false;
  validateInputs(model) {
    /// if radio button
    if (model.questionId == 21 ||
        model.questionId == 25 ||
        model.questionId == 26 ||
        model.questionId == 27) {
      if (model.response!.isEmpty) {
        return;
      }
      // print("radio: ${model.response}");

      /// if checkbox
    } else if (model.questionId == 22 ||
        model.questionId == 23 ||
        model.questionId == 24 ||
        model.questionId == 28) {
      if (model.checkboxes!.isEmpty) {
        return;
      }

      /// if input
    } else if (model.questionId == 29) {
      if (model.response == "") {
        return;
      }
    }
    return true;
  }

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
                    //// For the checkboxes, loop over their options and add a false value
                    /// Inside their isChecked array inside the model. This will be used to control onChecked behavior with the indicator i
                    if (value.questions[questionIndex]!.type == "checkbox") {
                      for (int i = 0;
                          i < value.questions[questionIndex]!.options.length;
                          i++) {
                        coupleSurveyResponses[questionIndex]
                            .isChecked!
                            .add(false);
                      }
                    }
                    return Column(
                      children: [
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
                                        .response as String,
                                questionIndex: questionIndex),

                        /// If checkbox.
                        /// I used i from the for loop, to give it as an indicator and have access to isChecked
                        ///
                        if (value.questions[questionIndex]!.type == "checkbox")
                          for (int i = 0;
                              i <
                                  value
                                      .questions[questionIndex]!.options.length;
                              i++)
                            buildCheckbox(
                                option:
                                    value.questions[questionIndex]!.options[i],
                                questionIndex: questionIndex,
                                indicator: i),

                        /// If Input
                        ///
                        if (value.questions[questionIndex]!.type == "text")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            // child: Form(
                            child: TextInputField(
                                handleChange: (text) {
                                  setState(() {
                                    coupleSurveyResponses[8].response = text;
                                  });
                                  if (text == "") {
                                    setState(() {
                                      coupleSurveyComplete = false;
                                    });
                                    return;
                                  } else {
                                    for (CoupleSurveyResponse model
                                        in coupleSurveyResponses) {
                                      final success = validateInputs(model);
                                      if (success != true) {
                                        return;
                                      }
                                    }
                                  }
                                  setState(() {
                                    coupleSurveyComplete = true;
                                  });
                                },
                                placeholder: "Enter your response here..."),
                            // ),
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
                  // When all questions are answered change color to primary red
                  color: coupleSurveyComplete == false
                      ? Theme.of(context).hintColor
                      : Theme.of(context).primaryColor,
                  handlePressed: () async {
                    for (CoupleSurveyResponse model in coupleSurveyResponses) {
                      final success = validateInputs(model);
                      if (success != true) {
                        return;
                      }
                    }

                    // send request
                  },
                ),
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

          ///// validate completion of survey to change button's color
          for (CoupleSurveyResponse model in coupleSurveyResponses) {
            final success = validateInputs(model);
            if (success != true) {
              return;
            }
          }
          setState(() {
            coupleSurveyComplete = true;
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

  Widget buildCheckbox(
      {required String option,
      required int questionIndex,
      required int indicator}) {
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

        /// value is the bool inside the question's isChecked array inside the model at index indicator
        ///
        value: coupleSurveyResponses[questionIndex].isChecked![indicator],

        /// method to change selected isChecked value
        onChanged: (value) {
          setState(() {
            coupleSurveyResponses[questionIndex].isChecked![indicator] = value;
          });

          /// if isChecked, add to array
          if (coupleSurveyResponses[questionIndex].isChecked![indicator] ==
              true) {
            coupleSurveyResponses[questionIndex].checkboxes!.add(option);
          } else {
            coupleSurveyResponses[questionIndex].checkboxes!.remove(option);
          }

          ///// validate completion of survey to change button's color
          for (CoupleSurveyResponse model in coupleSurveyResponses) {
            final success = validateInputs(model);
            if (success != true) {
              setState(() {
                coupleSurveyComplete = false;
              });
              return;
            }
          }
          setState(() {
            coupleSurveyComplete = true;
          });
        },
      ),
    );
  }
}
