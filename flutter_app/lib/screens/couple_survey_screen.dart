import 'package:bound_harmony/models/survey_model.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/providers/survey_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/navigation_button.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:bound_harmony/widgets%20for%20conditional%20UI/connection_status_false.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouplesSurveyScreen extends StatefulWidget {
  const CouplesSurveyScreen({super.key});

  @override
  State<CouplesSurveyScreen> createState() => _CouplesSurveyScreenState();
}

class _CouplesSurveyScreenState extends State<CouplesSurveyScreen> {
  // The list of Response Models I will send to the provider's method, where I will divide and send to database
  final List<CoupleSurveyResponse> coupleSurveyResponses = [
    CoupleSurveyResponse(questionId: 21, questionType: "radio", response: ""),
    CoupleSurveyResponse(
        questionId: 22,
        questionType: "checkbox",
        checkboxes: [],
        isChecked: []),
    CoupleSurveyResponse(
        questionId: 23,
        questionType: "checkbox",
        checkboxes: [],
        isChecked: []),
    CoupleSurveyResponse(
        questionId: 24,
        questionType: "checkbox",
        checkboxes: [],
        isChecked: []),
    CoupleSurveyResponse(questionId: 25, questionType: "radio", response: ""),
    CoupleSurveyResponse(questionId: 26, questionType: "radio", response: ""),
    CoupleSurveyResponse(questionId: 27, questionType: "radio", response: ""),
    CoupleSurveyResponse(
        questionId: 28,
        questionType: "checkbox",
        checkboxes: [],
        isChecked: []),
    CoupleSurveyResponse(questionId: 29, questionType: "text", response: ""),
  ];

  bool coupleSurveyComplete = false;
  validateInputs(model) {
    /// if radio button
    // print("In validate: ${model.questionType}");
    if (model.questionType == "radio") {
      if (model.response!.isEmpty) {
        return;
      }
      // print("radio: ${model.response}");

      /// if checkbox
    } else if (model.questionType == "checkbox") {
      if (model.checkboxes!.isEmpty) {
        return;
      }

      /// if input
    } else if (model.questionType == "text") {
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
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final token = preferences.get('token');
      await context.read<SurveysProvider>().getSurvey(id, token);
    }

    getSurveyRequest(2);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        leading: BackButton(
          color: Theme.of(context).hintColor,
        ),
        title: Text(
          "Couple's Survey",
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      ),
      //////////// END OF APPBAR
      ///
      body: Consumer<SurveysProvider>(builder: (context, value, child) {
        /// Responses saved successfully
        ///
        if (value.successSavingCouplesSurveyResponse == true) {
          return Center(
              child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Color.fromARGB(255, 134, 133, 133),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(
                    children: [
                      Icon(
                        // Icons.article,
                        // Icons.add_task_outlined,
                        Icons.check_box,
                        color: Colors.white,
                        size: 100,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Your responses have been saved.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: NavigationButton(
                            text: "Go To Suggestions",
                            textAndRightIconColor: Colors.white,
                            buttonColor: Theme.of(context).primaryColor,
                            handlePressed: () {
                              context.goNamed("Suggestions");
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: NavigationButton(
                            text: "Go To Advice",
                            textAndRightIconColor:
                                Theme.of(context).primaryColor,
                            buttonColor: Colors.white,
                            handlePressed: () {
                              context.goNamed("Advice");
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ));

          /// If user doesn't have a current partner
          ///
        } else if (value.couplesSurveyRejected == true) {
          return Consumer<ConnectionProvider>(
              builder: (context, value, child) => NotConnectedBox(
                  text:
                      "Complete your personal survey and\n make sure you are connected to your partner.",
                  //  Go to my partners and send a request or get some advice!"
                  handlePressedMyPartners: () {
                    value.successSendRequest = false;
                    value.messageSendRequest = "";
                    context.goNamed("My Partners");
                  },
                  handlePressedAdvice: () {
                    context.goNamed("Advice");
                  }));

          /// If user has a current partner
          ///
        } else {
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
                              question:
                                  value.questions[questionIndex]!.question),

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

                          /// If checkbox.
                          /// I used "i" from the for loop, to give it as an indicator and have access to isChecked
                          ///
                          if (value.questions[questionIndex]!.type ==
                              "checkbox")
                            for (int i = 0;
                                i <
                                    value.questions[questionIndex]!.options
                                        .length;
                                i++)
                              buildCheckbox(
                                  option: value
                                      .questions[questionIndex]!.options[i],
                                  questionIndex: questionIndex,
                                  indicator: i),

                          /// If Input
                          ///
                          if (value.questions[questionIndex]!.type == "text")
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
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
                      for (CoupleSurveyResponse model
                          in coupleSurveyResponses) {
                        final success = validateInputs(model);
                        if (success != true) {
                          return;
                        }
                      }

                      // prepare token
                      final SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      final token = preferences.get('token');
                      // send request
                      await value.saveCouplesSurveyResponses(
                          token, coupleSurveyResponses);
                    },
                  ),
                ),
              ],
            ),
          );
        }
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
        title: Text(option,
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w600)),
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
            borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.only(left: 6),
        activeColor: Theme.of(context).primaryColor,
        fillColor: MaterialStateColor.resolveWith(
            (states) => Theme.of(context).primaryColor),
        tileColor: const Color.fromARGB(40, 161, 161, 161),
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
        title: Text(option,
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w600)),
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Theme.of(context).primaryColor,
        checkColor: Colors.white,
        side: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        tileColor: const Color.fromARGB(61, 207, 207, 207),
        contentPadding: const EdgeInsets.only(left: 7, right: 0),
        shape: ContinuousRectangleBorder(
            side: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(20)),

        /// value is the bool inside the question's isChecked array, inside the model at index "indicator"
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
