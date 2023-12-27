import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            ///////////////////// Logo + Title ///////////////////////
            Image.asset("assets/login_logo.png"),
            Text(
              'Log In',
              style: TextStyle(
                  fontSize: 55,
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600),
            ),

            ///////////////////// INPUT FIELD  ///////////////////////
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Theme.of(context).hintColor)),
              child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 17))),
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 17))),
            ),
          ],
        ),
      )),
    );
  }
}
