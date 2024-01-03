import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:flutter/material.dart';

class TakeSurveyScreen extends StatelessWidget {
  const TakeSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> questions = {
      "What's your name?": ["option1", "option2", "option3"],
      "What's your name?1": ["option1", "option2", "option3"],
      "What's your name?2": ["option1", "option2", "option3"],
      "What's your name?3": ["option1", "option2", "option3"],
      "What's your name?4": ["option1", "option2", "option3"],
      "What's your name?5": ["option1", "option2", "option3"],
      "What's your name?44": ["option1", "option2", "option3"],
      "What's your name?52": ["option1", "option2", "option3"],
      "What's your name?246": ["option1", "option2", "option3"],
      "What's your name?235": ["option1", "option2", "option3"],
      "What's your name?354": ["option1", "option2", "option3"],
      "What's your name?346": ["option1", "option2", "option3"],
      "What's your name?654": ["option1", "option2", "option3"],
      "What's your name?265": ["option1", "option2", "option3"],
      "What's your name?526": ["option1", "option2", "option3"],
      "What's your name?2465": ["option1", "option2", "option3"],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("Couple's Survey"),
        ),
      ),
      //////////// END OF APPBAR

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Expanded(
              ///////// BUILDING SURVEY'S QUESTIONS AND LOOPING OVER OPTIONS
              ///
              ///
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final entry = questions.entries.elementAt(index);
                  return Column(
                    children: [
                      buildQuestion(entry.key, Theme.of(context).hintColor),
                      for (String option in entry.value)
                        buildOption(option, Theme.of(context).hintColor,
                            Theme.of(context).primaryColor),
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
      ),
    );
  }

  /////// BUILDER METHODS
  ///
  ///
  Widget buildQuestion(question, textColor) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 30),
          child: Text(
            question,
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget buildOption(option, grey, red) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
          decoration: BoxDecoration(
              border: Border.all(color: grey),
              borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            title: Text(
              option,
              style: TextStyle(color: grey),
            ),
            leading: Icon(size: 15, Icons.radio_button_off, color: red),
            horizontalTitleGap: 0.5,
          ),
        ),
        const SizedBox(height: 5)
      ],
    );
  }
}
