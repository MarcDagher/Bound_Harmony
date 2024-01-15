import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/user_provider.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
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
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // late TextEditingController inputController;

  // @override
  // void initState() {
  //   super.initState();
  //   inputController = TextEditingController();
  //   print("init");
  // }

  // @override
  // void dispose() {
  //   print("dispose");
  //   inputController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=
    //     0; // check if keyboard is in the UI
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
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
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  return Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: TextInputField(
                            handleChangeController: emailController,
                            placeholder: 'Email',
                            handleValidation: (email) => email!.isEmpty
                                ? "Email is required"
                                : !RegExp(r'^[\w-]+(\.[\w-]+)*@(hotmail\.com|gmail\.com|yahoo\.com|outlook\.com)$')
                                        .hasMatch(email)
                                    ? "Invalid email format"
                                    : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 20),
                          child: TextInputField(
                            handleChangeController: passwordController,
                            placeholder: 'Password',
                            handleValidation: (password) => password!.isEmpty
                                ? "Password is required"
                                : null,
                          ),
                        ),

                        // success
                        if (value.successLogin == true)
                          const Text(
                            "Success.",
                            style: TextStyle(color: Colors.red),
                          ),

                        // wrong credentials
                        if (value.wrongCredentials == true)
                          Text(
                            "Wrong credentials.",
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                      ],
                    ),
                  );
                },
              ),

              ///////////////////// Column: BUTTON + Text ///////////////////////
              Column(
                children: [
                  Consumer<AuthProvider>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Button(
                        text: 'Log In',
                        handlePressed: () async {
                          if (formKey.currentState!.validate()) {
                            await context.read<AuthProvider>().logInRequest(
                                emailController.text, passwordController.text);

                            if (value.successLogin == true) {
                              value.emailTaken = false;
                              value.successLogin = false;
                              value.successSignUp = false;
                              value.wrongCredentials = false;
                              context.goNamed('Connection Setup');
                              await context.read<UserProvider>().getImage();
                              emailController.clear();
                              passwordController.clear();
                              // context.goNamed('Profile');
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          value.emailTaken = false;
                          value.successLogin = false;
                          value.successSignUp = false;
                          value.wrongCredentials = false;
                          context.goNamed('Sign Up');
                        },
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
