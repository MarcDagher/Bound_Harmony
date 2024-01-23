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
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          ///////////////////// Main Column ///////////////////////
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.93,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///////////////////// Logo  ///////////////////////

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset("assets/logo.png"),
                ), // when keyboard appears hide logo

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
                      if (value.successSendRequest != true)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Form(
                            key: formKey,
                            child: TextInputField(
                                handleChangeController: emailController,
                                handleValidation: (email) => email!.isEmpty
                                    ? "Email is required"
                                    : !RegExp(r'^[\w-]+(\.[\w-]+)*@(hotmail\.com|gmail\.com|yahoo\.com|outlook\.com)$')
                                            .hasMatch(emailController.text)
                                        ? "Invalid email format"
                                        : email ==
                                                context
                                                    .read<AuthProvider>()
                                                    .preferences!
                                                    .get("email")
                                            ? "Don't send requests to yourself"
                                            : null,
                                placeholder: "Enter your partner's email"),
                          ),
                        ),
                      if (value.successSendRequest == false)
                        Text(
                          value.messageSendRequest,
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                      if (value.successSendRequest == true)
                        Text(
                          value.messageSendRequest,
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                    ],
                  ),
                ),

                ///////////////////// Column: Input + BUTTON ///////////////////////
                Consumer<ConnectionProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      if (value.successSendRequest != true)
                        Button(
                          text: 'Send Request',
                          handlePressed: () async {
                            if (formKey.currentState!.validate()) {
                              final token =
                                  await context.read<AuthProvider>().getToken();

                              value.sendRequest(emailController.text, token);
                            }
                          },
                        ),
                      if (value.successSendRequest != true)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              context.goNamed("Profile");
                            },
                            child: Text(
                              "I'll do that later, take me to profile",
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      if (value.successSendRequest == true)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: MaterialButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 15),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Go to my profile',
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
                              }),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
