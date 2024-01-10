import 'package:flutter/material.dart';

const Color correct = Color(0xFF32AB58);
const Color incorrect = Color(0xFFAB3232);
const Color neutral = Color(0xFFE7E7E7);
const Color background = Color(0xFF1A3464);

class Question {
  final int id;
  final String question;
  final List options;

  Question({required this.id, required this.options, required this.question});

  // override the toString method to print the questions on console
  @override
  String toString() {
    return "Question(id: $id, question: $question, options: $options)";
  }
}
