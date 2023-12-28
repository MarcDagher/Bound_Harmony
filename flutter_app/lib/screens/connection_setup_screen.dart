import 'package:bound_harmony/reusables/button.dart';
import 'package:bound_harmony/reusables/text_input.dart';
import 'package:flutter/material.dart';

class ConnectionSetupScreen extends StatelessWidget {
  const ConnectionSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=
        0; // check if keyboard is in the UI
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
                if (!isKeyboard)
                  Text(
                    'Welcome To Bound Harmony!',
                    style: TextStyle(
                        fontSize: 26, color: Theme.of(context).hintColor),
                  ),
                const SizedBox(height: 10),
                Text(
                  "Here you will connect to your partner",
                  style: TextStyle(
                      fontSize: 15, color: Theme.of(context).hintColor),
                )
              ],
            ),

            ///////////////////// Column: Input + BUTTON ///////////////////////
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextInputField(placeholder: "Enter your partner's email"),
                const SizedBox(height: 25),
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
