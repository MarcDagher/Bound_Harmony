import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final dio = Dio();

  // response handleing
  bool emailTaken = false;
  bool success = false;

  //
  final formKey = GlobalKey<FormState>();

  Map<String, String> formData = {'username': "", 'email': "", 'password': ""};

  void handleInput(String field, String newField) {
    setState(() {
      formData[field] = newField;
    });
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
                  padding: const EdgeInsets.only(top: 30),
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

            Consumer<AuthProvider>(
              builder: (context, value, child) {
                // if (value.emailTaken == true) {
                //   setState(() {
                //     emailTaken = value.emailTaken!;
                //   });
                // }
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (value.emailTaken == true || value.success == true)
                        const SizedBox(height: 30)
                      else
                        const SizedBox(
                          height: 45,
                        ),

                      /// Username Input Field
                      ///
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextInputField(
                          handleChange: (text) => handleInput("username", text),
                          placeholder: 'Username',
                          handleValidation: (name) =>
                              name!.isEmpty ? "Username is required" : null,
                        ),
                      ),

                      /// email Input Field
                      ///
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextInputField(
                          handleChange: (text) => handleInput("email", text),
                          placeholder: 'Email',
                          handleValidation: (email) =>
                              !RegExp(r'^[\w-]+(\.[\w-]+)*@(hotmail\.com|gmail\.com|yahoo\.com|outlook\.com)$')
                                      .hasMatch(formData['email']!)
                                  ? "Invalid email format"
                                  : email!.isEmpty
                                      ? "Email is required"
                                      : null,
                        ),
                      ),

                      /// password Input Field
                      ///
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextInputField(
                          handleChange: (text) => handleInput('password', text),
                          placeholder: 'Password',
                          handleValidation: (password) => password!.length < 6
                              ? "Password must be at least 6 characters"
                              : null,
                        ),
                      ),

                      // if email is taken
                      if (value.emailTaken == true)
                        const Text(
                          "Email has already been used",
                          style: TextStyle(color: Colors.red),
                        ),

                      // if user created successfully
                      if (value.success == true)
                        const Text(
                          "Account created successfully",
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                );
              },
            ),

            ///////////////////// Column: BUTTON(with conditions) + Text(Navigator) ///////////////////////
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45, bottom: 10),
                  child: Button(
                    text: 'Create Account',
                    // check for invalid input fields
                    handlePressed: () async {
                      if (formKey.currentState!.validate()) {
                        // send request
                        await context.read<AuthProvider>().signUpRequest(
                            formData['username']!,
                            formData['email']!,
                            formData['password']!);

                        // print(context.watch<AuthProvider>().emailTaken);
                        // print(context.watch<AuthProvider>().success);
                        // print("success: $success, emailTaken: $emailTaken");
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
