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
  String username = "";
  String email = "";
  String password = "";
  String birthdate = "";

  void Function(String)? handleUsername(String newUsername) {
    setState(() {
      username = newUsername;
    });
    print(username);
  }

  void Function(String)? handleEmail(String newEmail) {
    setState(() {
      email = newEmail;
    });
    print(email);
  }

  void Function(String)? handlePassword(String newPassword) {
    setState(() {
      password = newPassword;
    });
    print(password);
  }

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
                  child: Image.asset(
                    "assets/logo.png",
                  ),
                ), // when keyboard appears hide logo
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextInputField(
                        handleChange: (text) => handleUsername(text),
                        placeholder: 'Username'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextInputField(
                        handleChange: (text) => handleEmail(text),
                        placeholder: 'Email'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextInputField(
                        handleChange: (text) => handlePassword(text),
                        placeholder: 'Password'),
                  ),
                ],
              ),
            ),

            ///////////////////// Column: BUTTON + Text ///////////////////////
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 10),
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
