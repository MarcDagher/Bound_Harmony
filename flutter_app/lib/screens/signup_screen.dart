import 'package:dio/dio.dart';
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
  final dio = Dio();

  Map<String, String> formData = {'username': "", 'email': "", 'password': ""};

  void getHttp() async {
    final response = await dio.post(
      'http://192.168.1.66:8000/api/register',
      data: {
        "username": formData['username'],
        "email": formData['email'],
        "password": formData['password'],
        "birthdate": "15-01-2003"
      },
    );
    print(response.data.toString());
  }

  void handleInput(String field, String newField) {
    setState(() {
      formData[field] = newField;
    });
    print(formData);
  }

  void handleSubmit(Map<String, String> formData) {
    // post request
    getHttp();
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
                        handleChange: (text) => handleInput("username", text),
                        placeholder: 'Username'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextInputField(
                        handleChange: (text) => handleInput("email", text),
                        placeholder: 'Email'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextInputField(
                        handleChange: (text) => handleInput('password', text),
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
                    handlePressed: () => handleSubmit(formData),
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
