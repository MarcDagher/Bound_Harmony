import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ConnectionSetupScreen extends StatelessWidget {
  const ConnectionSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=
    //     0; // check if keyboard is in the UI
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        ///////////////////// Main Column ///////////////////////
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ///////////////////// Logo  ///////////////////////

            Image.asset("assets/logo.png"), // when keyboard appears hide logo

            ///////////////////// Column: Titles ///////////////////////
            Consumer<ConnectionProvider>(
              builder: (context, value, child) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Welcome To Bound Harmony!',
                      style: TextStyle(
                          fontSize: 26, color: Theme.of(context).hintColor),
                    ),
                  ),
                  if (value.successSendRequest != false &&
                      value.successSendRequest != true)
                    Text(
                      "Here you will connect to your partner",
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).hintColor),
                    ),
                  if (value.successSendRequest == false)
                    Text(
                      value.messageSendRequest,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).primaryColor),
                    ),
                  if (value.successSendRequest == true)
                    Text(
                      value.messageSendRequest,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).primaryColor),
                    ),
                ],
              ),
            ),

            ///////////////////// Column: Input + BUTTON ///////////////////////
            Consumer<ConnectionProvider>(
              builder: (context, value, child) => Column(
                children: [
                  if (value.successSendRequest != true)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Form(
                        key: formKey,
                        child: TextInputField(
                            handleChangeController: emailController,
                            handleValidation: (email) => email!.isEmpty
                                ? "Email is required"
                                : !RegExp(r'^[\w-]+(\.[\w-]+)*@(hotmail\.com|gmail\.com|yahoo\.com|outlook\.com)$')
                                        .hasMatch(emailController.text)
                                    ? "Invalid email format"
                                    : null,
                            placeholder: "Enter your partner's email"),
                      ),
                    ),
                  if (value.successSendRequest != true)
                    Button(
                      text: 'Send Request',
                      handlePressed: () async {
                        if (formKey.currentState!.validate()) {
                          final token =
                              await context.read<AuthProvider>().getToken();
                          // print("from screen's button: $token");
                          context
                              .read<ConnectionProvider>()
                              .sendRequest(emailController.text, token);
                        }
                      },
                    ),
                  if (value.successSendRequest == true)
                    MaterialButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 15),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Go to profile',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            )
                          ],
                        ),
                        onPressed: () {
                          context.goNamed('Profile');
                        })
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
