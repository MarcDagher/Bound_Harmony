import 'package:flutter/material.dart';

class DisplayBox extends StatelessWidget {
  final String text;
  final VoidCallback? handleTap;
  const DisplayBox({super.key, required this.text, this.handleTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: handleTap,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Theme.of(context).hintColor)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
