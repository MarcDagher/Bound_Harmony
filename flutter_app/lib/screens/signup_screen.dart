import 'package:flutter/material.dart';
import 'package:bound_harmony/reusables/text_input.dart';
import 'package:bound_harmony/reusables/button.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    // final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=
    //     0; // check if keyboard is in the UI
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            ///////////////////// Column: Logo + Title ///////////////////////
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Image.asset(
                    "assets/logo.png",
                  ),
                ), // when keyboard appears hide logo
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextInputField(placeholder: 'Username'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextInputField(placeholder: 'Email'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextInputField(placeholder: 'Password'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextInputField(placeholder: 'Birthdate'),
                ),
              ],
            ),

            ///////////////////// Column: BUTTON + Text ///////////////////////
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Button(
                    text: 'Create Account',
                    handlePressed: () {},
                  ),
                ),
                GestureDetector(
                  onTap: () => context.goNamed('Log In'),
                  child: Text(
                    "If you have an account Sign In",
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
