import 'package:flutter/material.dart';
import 'package:bound_harmony/reusables/text_input.dart';
import 'package:bound_harmony/reusables/button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ///////////////////// Column: Logo + Title ///////////////////////
            Column(
              children: [
                if (!isKeyboard)
                  Image.asset(
                    "assets/logo.png",
                    height: 170,
                    width: 170,
                  ), // when keyboard appears hide logo
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 45,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            ///////////////////// Column: INPUT FIELDs  ///////////////////////
            const Column(
              children: [
                TextInputField(placeholder: 'Username'),
                SizedBox(height: 5),
                TextInputField(placeholder: 'Email'),
                SizedBox(height: 5),
                TextInputField(placeholder: 'Password'),
                SizedBox(height: 5),
                TextInputField(placeholder: 'Birthdate'),
              ],
            ),

            ///////////////////// Column: BUTTON + Text ///////////////////////
            Column(
              children: [
                Row(
                  children: [
                    Button(
                      text: 'Log In',
                      handlePressed: () {},
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 0),
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
