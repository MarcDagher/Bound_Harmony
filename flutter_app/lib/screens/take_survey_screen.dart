import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';

class TakeSurveyScreen extends StatelessWidget {
  const TakeSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(itemBuilder: itemBuilder),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}
