import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback
      handlePressed; //  a type definition that represents a callback function that takes no arguments and returns void
  final String text;
  final Color? color;
  final Color? borderAndTextColor;

  const Button(
      {super.key,
      required this.text,
      required this.handlePressed,
      this.color,
      this.borderAndTextColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            color: color ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: borderAndTextColor != null
                  ? BorderSide(color: borderAndTextColor as Color, width: 2)
                  : BorderSide.none,
            ),
            onPressed: handlePressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: Text(text,
                  style: TextStyle(
                      color: borderAndTextColor != null
                          ? borderAndTextColor as Color
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20)),
            ),
          ),
        ),
      ],
    );
  }
}
