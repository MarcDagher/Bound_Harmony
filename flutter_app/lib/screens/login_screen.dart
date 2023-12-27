import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Image.asset("assets/login_logo.png"),
          Text(
            'Log In',
            style: TextStyle(fontSize: 45, color: Theme.of(context).hintColor),
          ),
        ],
      )),
    );
  }
}
