import 'package:bound_harmony/providers/suggestions_provider.dart';
import 'package:bound_harmony/reusable%20widgets/navigation_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future getSuggestions(String type) async {
      final suggestions =
          await context.read<SuggestionsProvider>().getSuggestions(type);
      return suggestions;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Suggestions For You'),
        ),
      ),

      //////// END OF APPBAR
      ///
      ///

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //////// ON CLICK - GO TO Date Builder

                Expanded(
                  child: NavigationBox(
                      navigationButtonColor: Colors.white,
                      textAndButtonColor: Theme.of(context).hintColor,
                      handlePressed: () {
                        context.read<SuggestionsProvider>().dates = [];
                        getSuggestions('date');
                        context.goNamed('Date Builder and Bonding Activities',
                            pathParameters: {'type': 'date'});
                      },
                      imagePath: "assets/wallpaper 8.jpg",
                      title: "Date Builder"),
                ),

                const SizedBox(
                  height: 10,
                ),

                //////// ON CLICK - GO TO Date Bonding Activities
                Expanded(
                  child: NavigationBox(
                      navigationButtonColor: Colors.white,
                      textAndButtonColor: Theme.of(context).hintColor,
                      handlePressed: () {
                        context.read<SuggestionsProvider>().bondingActivities =
                            [];
                        getSuggestions('bonding');
                        context.goNamed('Date Builder and Bonding Activities',
                            pathParameters: {'type': 'bonding'});
                      },
                      imagePath: "assets/wallpaper 7.jpg",
                      title: "Bonding Activities"),
                ),

                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  buildSuggestionBox(String text, Color color1, Color color2, String route,
      BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.goNamed(route);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color1, color2]),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: Center(
                    child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
