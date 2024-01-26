import 'package:flutter/material.dart';

class DisplayBox extends StatelessWidget {
  final String text;
  final String title;
  final VoidCallback? handleTap;
  const DisplayBox(
      {super.key, required this.title, required this.text, this.handleTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromARGB(255, 235, 235, 235)))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 23),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).hintColor,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
