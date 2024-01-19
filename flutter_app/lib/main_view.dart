import 'package:bound_harmony/reusable%20widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.navigationShell});

  // we use the navigationShell to customize a widget's behavior or appearance based on the current navigation state.
  // To determine how the UI should be structerd based on the current Navigation state
  // Different branches of the application may have distinct navigation structures, and the navigationShell provides information about the current structure.
  final StatefulNavigationShell navigationShell;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    String currentNamedLocation =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    if (currentNamedLocation == '/onBoarding' ||
        currentNamedLocation == '/login' ||
        currentNamedLocation == '/login/signup' ||
        currentNamedLocation == '/login/connectionSetup' ||
        currentNamedLocation == '/admin') {
      return Scaffold(
        /// If one of the above routes, return body without a navBar
        body: widget.navigationShell,
      );
    } else {
      return Scaffold(
        /// If none of the above routes, return body with a navBar
        body: widget.navigationShell,

        /// NavBar handles the branches(routes)
        bottomNavigationBar:
            MyNavigationBar(navigationShell: widget.navigationShell),
      );
    }
  }
}
