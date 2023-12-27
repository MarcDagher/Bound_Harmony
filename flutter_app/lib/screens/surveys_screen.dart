import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';

class SurveysScreen extends StatelessWidget {
  const SurveysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape:
            const Border.symmetric(horizontal: BorderSide(color: Colors.black)),
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Surveys'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(children: [
          const Row(
            children: [
              Text(
                'Pick a survey',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 250,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: const Center(
                          child: Text(
                        'Personal Survey',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 250,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: const Center(
                          child: Text("Couple's Survey",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600))),
                    ),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
