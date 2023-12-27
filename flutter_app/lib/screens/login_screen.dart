import 'package:flutter/material.dart';
import 'package:flutter_app/reusables/button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        ///////////////////// Main Column ///////////////////////
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ///////////////////// Column: Logo + Title ///////////////////////
            Column(
              children: [
                if (!isKeyboard) Image.asset("assets/login_logo.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 55,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            ///////////////////// Column: INPUT FIELDs  ///////////////////////
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).hintColor)),
                  child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 17))),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).hintColor)),
                  child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 17))),
                ),
              ],
            ),

            ///////////////////// Column: BUTTON + Text ///////////////////////

            Column(
              children: [
                Row(
                  children: [
                    Button(
                      text: 'hello',
                      handlePressed: () {},
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 0),
                  child: Text(
                    "Don't have an account? Sign Up",
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
