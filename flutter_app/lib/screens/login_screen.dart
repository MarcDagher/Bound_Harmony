import 'package:bound_harmony/reusables/text_input.dart';
import 'package:flutter/material.dart';
import 'package:bound_harmony/reusables/button.dart';
import 'package:go_router/go_router.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
          children: [
            ///////////////////// Column: Logo + Title ///////////////////////
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Image.asset("assets/logo.png"),
                ), // when keyboard appears hide logo
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
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
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: TextInputField(placeholder: 'Email'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 20),
                  child: TextInputField(placeholder: 'Password'),
                )
              ],
            ),

            ///////////////////// Column: BUTTON + Text ///////////////////////
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Button(
                    text: 'Log In',
                    handlePressed: () => context.goNamed('Connection Setup'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 0),
                  child: GestureDetector(
                    onTap: () => context.goNamed('Sign Up'),
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
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
