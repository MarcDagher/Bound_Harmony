import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final Color? textAndRightIconColor;
  final Color? buttonColor;
  final String text;
  final VoidCallback handlePressed;
  const NavigationButton(
      {super.key,
      required this.text,
      required this.textAndRightIconColor,
      required this.buttonColor,
      required this.handlePressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: textAndRightIconColor),
            ),
            Icon(
              Icons.navigate_next,
              color: textAndRightIconColor,
            )
          ],
        ),
        onPressed: handlePressed);
  }
}
