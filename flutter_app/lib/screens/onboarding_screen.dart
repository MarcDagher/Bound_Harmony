import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to navigate to the Log In page
    void navigateToLogin() {
      // Navigator.of(context).pushReplacementNamed('/login');
      context.goNamed('Log In');
    }

    // Use Future.delayed to wait for 6 seconds before navigating
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the Log In page after 6 seconds
      navigateToLogin();
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Image.asset("assets/logo.png")),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Bound Harmony',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
