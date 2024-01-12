import 'package:bound_harmony/providers/auth_provider.dart';
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
  //
  final formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (value.emailTaken == true ||
                          value.successSignUp == true)
                        const SizedBox(height: 30)
                      else
                        const SizedBox(
                          height: 15,
                        ),

                      /// Username Input Field
                      ///
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextInputField(
                          handleChangeController: usernameController,
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
                          handleChangeController: emailController,
                          placeholder: 'Email',
                          handleValidation: (email) =>
                              !RegExp(r'^[\w-]+(\.[\w-]+)*@(hotmail\.com|gmail\.com|yahoo\.com|outlook\.com)$')
                                      .hasMatch(emailController.text)
                                  ? "Invalid email format"
                                  : email!.isEmpty
                                      ? "Email is required"
                                      : null,
                        ),
                      ),

                      /// Birthdate Input Field
                      ///
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextInputField(
                          handleChangeController: birthdateController,
                          placeholder: 'Birthdate (dd-mm-year)',
                          handleValidation: (birthdate) => !RegExp(
                                      r'^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[0-2])-\d{4}$')
                                  .hasMatch(birthdateController.text)
                              ? "Format must be Day-Month-Year (eg. 01-01-2020)"
                              : birthdate!.isEmpty
                                  ? "Birthdate is required"
                                  : null,
                        ),
                      ),

                      /// password Input Field
                      ///
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextInputField(
                          handleChangeController: passwordController,
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
                      if (value.successSignUp == true)
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
                            formUsername: usernameController.text,
                            formEmail: emailController.text,
                            formPassword: passwordController.text,
                            formBirthdate: birthdateController.text);
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
