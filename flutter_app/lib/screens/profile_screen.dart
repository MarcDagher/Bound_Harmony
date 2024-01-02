import 'package:bound_harmony/reusables/display_box.dart';
import 'package:bound_harmony/reusables/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=
    //     0; // check if keyboard is in the UI
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ///////////////////// Column: Profile Image + Edit button ///////////////////////
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Column(
                  children: [
                    // if (!isKeyboard)
                    SizedBox(
                        width: 180,
                        height: 180,
                        child: Icon(Icons.account_circle,
                            size: 180, color: Theme.of(context).hintColor)),
                    // if (!isKeyboard)
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
              ),

              ///////////////////// Column: TextInputField - DisplayBox - TextInputField - Location - NavButton x2  ///////////////////////
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextInputField(
                        handleChange: (string) {
                          // print(string);
                        },
                        placeholder: 'Username'),
                  ),

                  // this will be a text. email is displayed from token
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Expanded(child: DisplayBox(text: 'My-Email@123.com')),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextInputField(
                        handleChange: (string) {
                          print(string);
                        },
                        placeholder: 'Location'),
                  ), // Figure out how to do that... depends on google api

                  // Navigation Buttons
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Theme.of(context).hintColor)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Incoming Requests',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Theme.of(context).hintColor,
                          )
                        ],
                      ),
                      onPressed: () {
                        context.goNamed("Incoming Requests");
                      }),
                  const SizedBox(height: 5),

                  // Custom Navigation button
                  MaterialButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Partners',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          )
                        ],
                      ),
                      onPressed: () {
                        context.goNamed('My Partners');
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
