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

  Map<String, String> formData = {'username': "", 'email': "", 'password': ""};

  void postRegister(formData) async {
    try {
      final response = await dio.post(
        '${Requests.baseUrl}register',
        data: {
          "username": formData['username'],
          "email": formData['email'],
          "password": formData['password'],
          "birthdate": "15-01-2003"
        },
      );
      print("hello");
      print(response.data.toString());
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  void handleInput(String field, String newField) {
    setState(() {
      formData[field] = newField;
    });
    print(formData);
  }

  void handleSubmit(Map<String, String> formData) async {
    // post request
    postRegister(formData);
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
                  if (empty == true)
                    const Text(
                      "All fields are required",
                      style: TextStyle(color: Colors.red),
                    )
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
                        postRegister(formData);
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
