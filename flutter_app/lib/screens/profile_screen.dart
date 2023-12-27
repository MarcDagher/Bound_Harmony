import 'package:flutter/material.dart';
import 'package:bound_harmony/reusables/text_input.dart';
import 'package:bound_harmony/reusables/button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=
        0; // check if keyboard is in the UI
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          ///////////////////// Main Column ///////////////////////
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ///////////////////// Column: Profile Image + Edit button ///////////////////////
              Column(
                children: [
                  Container(
                      width: 180,
                      height: 180,
                      child: Icon(Icons.account_circle,
                          size: 180, color: Theme.of(context).hintColor)),
                  Text(
                    'Edit Profile Picture',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).primaryColor),
                  )
                ],
              ),

              ///////////////////// Column: INPUT FIELDs  ///////////////////////
              Column(
                children: [
                  const TextInputField(placeholder: 'Username'),

                  const SizedBox(height: 5),

                  // this will be a text. email is displayed from token
                  // display box
                  const TextInputField(placeholder: 'Email non changeable'),

                  const SizedBox(height: 5),

                  const TextInputField(
                      placeholder:
                          'Location'), // Figure out how to do that... depends on google api

                  const SizedBox(height: 5),

                  // Custom Navigation button
                  Row(children: [
                    Button(text: 'Incoming Requests', handlePressed: () {})
                  ]),

                  const SizedBox(height: 5),

                  // Custom Navigation button
                  Row(children: [
                    Button(text: 'Partners', handlePressed: () {})
                  ])
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
