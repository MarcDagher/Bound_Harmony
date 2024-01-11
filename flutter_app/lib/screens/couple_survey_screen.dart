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

  @override
  Widget build(BuildContext context) {
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
                  itemCount: list.length,
                  itemBuilder: (context, questionIndex) {
                    return Column(
                      children: [
                        buildQuestion(),
                        buildRadioOption(),
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
  Widget buildQuestion(
      // question, textColor
      ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 30),
        child: Text("Default Text",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 20,
                fontWeight: FontWeight.w700),
            overflow: TextOverflow.clip),
      ),
    );
  }

  Widget buildRadioOption(
      // {
      // required String option,
      // required String chosenOption,
      // required listOfOptions,
      // required int questionIndex,
      // }

      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RadioListTile(
        title: Text("Default Option", overflow: TextOverflow.clip),
        value: 0,
        groupValue: 0,
        onChanged: (chosenResponse) {},
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
