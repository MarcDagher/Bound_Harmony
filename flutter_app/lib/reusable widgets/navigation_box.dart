import 'package:flutter/material.dart';

class NavigationBox extends StatelessWidget {
  final VoidCallback handlePressed;
  final String imagePath;

  const NavigationBox(
      {super.key, required this.handlePressed, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.darken),
                image: AssetImage("${imagePath}"),
                fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: MaterialButton(
            padding:
                const EdgeInsets.only(left: 15, right: 5, top: 15, bottom: 15),
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: handlePressed,
            // ()

            // {

            // context
            //     .read<SurveysProvider>()
            //     .successSavingPersonalSurveyResponse = false;
            // context.goNamed("Personal Survey");
            // },
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
        ));
  }
}
