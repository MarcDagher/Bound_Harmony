import 'package:bound_harmony/providers/suggestions_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/widgets%20for%20conditional%20UI/connection_status_false.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DateBuilderAndBondingActivitiesScreen extends StatelessWidget {
  final String type;
  const DateBuilderAndBondingActivitiesScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Future getSuggestions(String type) async {
      final suggestions =
          await context.read<SuggestionsProvider>().getSuggestions(type);
      return suggestions;
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).hintColor),
        leadingWidth: 50,
        title: Text(type == "date" ? 'Date Builder' : "Bonding Activities",
            style: TextStyle(color: Theme.of(context).hintColor)),
      ),

      ///// END OF APPBAR
      ///
      ///
      body: Consumer<SuggestionsProvider>(
        builder: (context, value, child) {
          if (value.status == "failed") {
            return NotConnectedBox(
                text: value.failedMessage!,
                textFirstButton: "My Partners",
                textSecondButton: "Couple's Survey",
                handlePressedFirstButton: () {
                  context.goNamed('My Partners');
                },
                handlePressedSecondButton: () {
                  context.goNamed('Couples Survey');
                });
          } else if (value.status == "success") {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView.builder(
                    itemCount: type == "bonding"
                        ? value.bondingActivities.length
                        : value.dates.length,
                    itemBuilder: (context, index) {
                      // final place = places.entries.elementAt(index);

                      /////// CARD BUILDER METHOD
                      ///
                      return Column(
                        children: [
                          cardBuilder(
                            context: context,
                            businessStatus: type == "bonding"
                                ? value.bondingActivities[index].businessStatus
                                : value.dates[index].businessStatus,
                            ////////////////////////////////////
                            name: type == "bonding"
                                ? value.bondingActivities[index].name
                                : value.dates[index].name,
                            ////////////////////////////////////
                            openingHours: type == "bonding"
                                ? value.bondingActivities[index].openingHours
                                : value.dates[index].openingHours,
                            ////////////////////////////////////
                            photos: type == "bonding"
                                ? value.bondingActivities[index].photos
                                : value.dates[index].photos,
                            ////////////////////////////////////
                            placeId: type == "bonding"
                                ? value.bondingActivities[index].placeId
                                : value.dates[index].placeId,
                            ////////////////////////////////////
                            plusCode: type == "bonding"
                                ? value.bondingActivities[index].plusCode
                                : value.dates[index].plusCode,
                            ////////////////////////////////////
                            rating: type == "bonding"
                                ? value.bondingActivities[index].rating
                                : value.dates[index].rating,
                            ////////////////////////////////////
                            types: type == "bonding"
                                ? value.bondingActivities[index].types
                                : value.dates[index].types,
                            ////////////////////////////////////
                            userRatingsTotal: type == "bonding"
                                ? value
                                    .bondingActivities[index].userRatingsTotal
                                : value.dates[index].userRatingsTotal,
                            ////////////////////////////////////
                            vicinity: type == "bonding"
                                ? value.bondingActivities[index].vicinity
                                : value.dates[index].vicinity,
                            ////////////////////////////////////
                            queryType: type == "bonding"
                                ? value.bondingActivities[index].queryType
                                : value.dates[index].queryType,
                          ),
                          if (type == "bonding" &&
                                  index == value.bondingActivities.length - 1 ||
                              type != "bonding" &&
                                  index == value.dates.length - 1)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Button(
                                text: 'Load More',
                                handlePressed: () async {
                                  if (type == "date") {
                                    await getSuggestions("date");
                                  } else {
                                    await getSuggestions("bonding");
                                  }
                                },
                                borderAndTextColor:
                                    const Color.fromARGB(255, 255, 87, 57),
                                color: Colors.white,
                              ),
                            )
                        ],
                      );
                    }));
          } else {
            return const Center(child: Text("Loading ... "));
          }
        },
      ),
    );
  }

  //////// CARD BUILDER METHOD
  ///
  Widget cardBuilder({
    required BuildContext context,
    required String name, // used
    required String businessStatus, // used
    required dynamic openingHours, // used
    required String placeId,
    required dynamic plusCode,
    required dynamic photos, // used
    required List types,
    required dynamic rating, // used
    required dynamic userRatingsTotal, // used
    required dynamic vicinity, // used
    required dynamic queryType,
  }) {
    final validatedOpeningHours = openingHours == "no opening hours"
        ? "Opening hours not listed for this place"
        : openingHours['open_now'] == true
            ? "Now Open"
            : "Closed";

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(businessStatus,
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w700)), // Top texts 1
                Text(validatedOpeningHours,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                    )) // Top texts 2
              ]),

              Padding(
                padding: const EdgeInsets.only(top: 45, bottom: 15),
                child: Text(name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 22)),
              ), // Center text name
              //
              // RATINGS
              //
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar(
                      direction: Axis.horizontal,
                      itemCount: 5,
                      initialRating: (rating is int)
                          ? rating.toDouble()
                          : rating is double
                              ? rating
                              : 0,
                      maxRating: 5,
                      minRating: 0,
                      allowHalfRating: true,
                      glow: true,
                      glowColor: const Color.fromARGB(255, 255, 186, 57),
                      itemSize: 25,
                      unratedColor: const Color.fromARGB(255, 255, 186, 57),
                      ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star_rounded,
                            color: Color.fromARGB(255, 255, 186, 57),
                          ),
                          half: const Icon(
                            Icons.star_half_rounded,
                            color: Color.fromARGB(255, 255, 186, 57),
                          ),
                          empty: const Icon(
                            Icons.star_border_rounded,
                            color: Color.fromARGB(255, 255, 186, 57),
                          )),
                      ignoreGestures: true,
                      onRatingUpdate: (value) => 0,
                    ),
                    Text(
                      userRatingsTotal == "no total ratings"
                          ? "0"
                          : "$userRatingsTotal",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 186, 57),
                          fontSize: 12),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 8),
                child: Text(
                  "Location: $vicinity",
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w700),
                ),
              ),

              //// Location Button
              ///
              if (photos == "no photos")
                Text(
                  "Link is not listed for this place",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              if (photos != "no photos")
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(240, 240, 62, 62),
                      Color.fromARGB(255, 250, 80, 68),
                      Color.fromARGB(255, 248, 154, 117)
                      // Color.fromARGB(209, 240, 62, 62),
                      // Color.fromARGB(249, 223, 118, 99),
                      // Color.fromARGB(255, 248, 170, 117)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: MaterialButton(
                    textColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () async {
                      final RegExp regex = RegExp(r'href="([^"]+)"');
                      final match =
                          regex.firstMatch(photos[0]['html_attributions'][0]);
                      final String url = match?.group(1) ?? '';

                      final newUrl = Uri.parse(url);
                      if (!await launchUrl(newUrl)) {
                        throw Exception('Could not launch $newUrl');
                      }
                    },
                    child: const Text(
                      'More Details',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
            ]),
      ),
    );
  }
}
