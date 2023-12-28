import 'package:bound_harmony/reusables/text_input.dart';
import 'package:flutter/material.dart';
import 'package:bound_harmony/reusables/button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
                      "assets/logo.png"), // when keyboard appears hide logo
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Log In',
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
                TextInputField(placeholder: 'Email'),
                SizedBox(
                  height: 5,
                ),
                TextInputField(placeholder: 'Password')
              ],
            ),

            ///////////////////// Column: BUTTON + Text ///////////////////////
            Column(
              children: [
                Button(
                  text: 'Log In',
                  handlePressed: () {},
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
