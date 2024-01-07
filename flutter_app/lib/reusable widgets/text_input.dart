import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String placeholder;
  final Function(String)? handleChange;
  final String? Function(String?)? handleValidation;
  final TextEditingController? handleChangeController;
  const TextInputField(
      {super.key,
      required this.placeholder,
      this.handleChange,
      this.handleValidation,
      this.handleChangeController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // functionalities
      validator: handleValidation,
      onChanged: handleChange,
      obscureText: placeholder == "Password",
      controller: handleChangeController,
      // styling
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
                strokeAlign: double.infinity,
                color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(10),
          ),

          /// Focused Border
          ///
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(10),
          ),

          /// Error Border
          ///
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10)),
          errorStyle: TextStyle(color: Theme.of(context).primaryColor),

          /// focused error border
          ///
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10)),
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
