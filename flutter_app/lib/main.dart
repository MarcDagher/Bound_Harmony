import 'package:bound_harmony/configurations/app_router.dart';
import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/providers/messages_provider.dart';
import 'package:bound_harmony/providers/survey_provider.dart';
import 'package:bound_harmony/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SurveysProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessagesProvider(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Bound Harmony',
        //// Design themes + setup
        ///
        ///
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
              shape: Border.symmetric(
                  horizontal:
                      BorderSide(width: 0.2, color: Color(0xFF544B4C)))),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFF03E3F),
          hintColor: const Color(0xFF544B4C),
          fontFamily: "Nunito",
          useMaterial3: true,
        ),

        //// Go Router
        ///
        ///
        routerConfig: AppNavigation.router,
      ),
    );
  }
}
