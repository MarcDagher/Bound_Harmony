import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String placeholder;
  const TextInputField({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).hintColor)),
      child: TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholder,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 18))),
    );
  }
}
