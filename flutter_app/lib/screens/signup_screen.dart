import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final dio = Dio();
  bool empty = false;
  bool emailTaken = false;
  bool success = false;

  Map<String, String> formData = {'username': "", 'email': "", 'password': ""};

  void registerRequest(formData) async {
    try {
      final response = await dio.post(
        options: Options(contentType: "application/json"),
        '${Requests.baseUrl}register',
        data: {
          "username": formData['username'],
          "email": formData['email'],
          "password": formData['password'],
          "birthdate": "15-01-2003"
        },
      );

      if (response.data['status'] == "success") {
        setState(() {
          success = true;
          emailTaken = false;
        });
        context.goNamed('Log In');
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 302) {
        setState(() {
          emailTaken = true;
          success = false;
        });
      }
    }
  }

  void handleInput(String field, String newField) {
    setState(() {
      formData[field] = newField;
    });
    print(formData);
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

                  // if not all fields are filled
                  if (empty == true)
                    const Text(
                      "All fields are required",
                      style: TextStyle(color: Colors.red),
                    ),

                  // if username exists in DB
                  if (emailTaken == true)
                    const Text(
                      "Email has already been used",
                      style: TextStyle(color: Colors.red),
                    ),

                  // if user created successfully
                  if (success == true)
                    const Text(
                      "Account created successfully",
                      style: TextStyle(color: Colors.red),
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
                    // check for empty input fields
                    handlePressed: () {
                      if (formData['username'] == "" ||
                          formData['email'] == "" ||
                          formData['password'] == "") {
                        setState(() {
                          empty = true;
                        });
                      } else {
                        setState(() {
                          empty = false;
                        });
                        registerRequest(formData);
                      }
                    },
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
