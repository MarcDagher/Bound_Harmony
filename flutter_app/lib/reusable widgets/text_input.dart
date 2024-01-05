import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final Function(String) handleChange;
  final String? Function(String?)? handleValidation;
  final String placeholder;
  const TextInputField(
      {super.key,
      required this.placeholder,
      required this.handleChange,
      this.handleValidation});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: handleValidation,
      onChanged: handleChange,
      obscureText: placeholder == "Password",
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
                strokeAlign: double.infinity,
                color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelStyle: TextStyle(
            color: Theme.of(context).hintColor,
          ),
          labelText: placeholder,
          labelStyle: TextStyle(
            color: Theme.of(context).hintColor,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20)),
    );
  }
}
