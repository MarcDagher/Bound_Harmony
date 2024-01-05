import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final dio = Dio();
  Map<String, String> formData = {'email': "", 'password': ""};
  bool empty = false;
  bool success = false;
  bool wrongCredentials = false;

  void handleInput(String field, String newField) {
    setState(() {
      formData[field] = newField;
    });
  }

  // void signInRequest() async {
  //   try {
  //     final response = await dio.post("${Requests.baseUrl}/login", data: {
  //       "email": formData['email'],
  //       "password": formData['password'],
  //     });
  //     print(response.data);
  //     print(response.data);
  //     if (response.data['status'] == "success") {
  //       setState(() {
  //         success = true;
  //         empty = false;
  //         wrongCredentials = false;
  //       });
  //       // context.goNamed('Connection Setup');
  //     }
  //   } on DioException catch (e) {
  //     print(e.response!.statusCode);
  //     if (e.response!.statusCode == 401) {
  //       setState(() {
  //         empty = false;
  //         wrongCredentials = true;
  //         success = false;
  //       });
  //     }
  //   }
  // }

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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: TextInputField(
                      handleChange: (text) {
                        handleInput('email', text);
                      },
                      placeholder: 'Email'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  child: TextInputField(
                      handleChange: (text) {
                        handleInput('password', text);
                      },
                      placeholder: 'Password'),
                ),

                // empty fields
                if (empty == true)
                  const Text(
                    "All fields are required.",
                    style: TextStyle(color: Colors.red),
                  ),

                // wrong email or password
                if (wrongCredentials == true)
                  const Text(
                    "Wrong credentials.",
                    style: TextStyle(color: Colors.red),
                  ),

                // success
                if (success == true)
                  const Text(
                    "Success.",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),

            ///////////////////// Column: BUTTON + Text ///////////////////////
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Button(
                    text: 'Log In',
                    handlePressed: () {
                      if (formData['email'] == "" ||
                          formData['password'] == "") {
                        setState(() {
                          empty = true;
                        });
                      } else {
                        context.read<AuthProvider>().signInRequest(
                            formData['email'], formData['password']);
                      }
                    },
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
