import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final Function(String) handleChange;
  final String placeholder;
  const TextInputField(
      {super.key, required this.placeholder, required this.handleChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).hintColor)),
      child: TextFormField(
          onChanged: handleChange,
          obscureText: placeholder == "Password",
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: placeholder,
              labelStyle: TextStyle(
                color: Theme.of(context).hintColor,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15))),
    );
  }
}
