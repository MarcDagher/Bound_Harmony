import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback
      handlePressed; //  a type definition that represents a callback function that takes no arguments and returns void
  final String text;
  const Button({super.key, required this.text, required this.handlePressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: handlePressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17),
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
        ),
      ),
    );
  }
}
