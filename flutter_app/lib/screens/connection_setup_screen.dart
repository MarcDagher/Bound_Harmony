import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnectionSetupScreen extends StatelessWidget {
  const ConnectionSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=
    //     0; // check if keyboard is in the UI
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Welcome To Bound Harmony!',
                    style: TextStyle(
                        fontSize: 26, color: Theme.of(context).hintColor),
                  ),
                ),
                Text(
                  "Here you will connect to your partner",
                  style: TextStyle(
                      fontSize: 15, color: Theme.of(context).hintColor),
                )
              ],
            ),

            ///////////////////// Column: Input + BUTTON ///////////////////////
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: TextInputField(
                      handleChange: (string) {},
                      placeholder: "Enter your partner's email"),
                ),
                Button(
                  text: 'Send Request',
                  handlePressed: () {},
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
