import 'package:bound_harmony/providers/suggestions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

    if (type == "date") {
      getSuggestions("date");
    } else {
      getSuggestions("bonding");
    }
    // print(type);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).hintColor),
        leadingWidth: 30,
        title: Text(type == "date" ? 'Date Builder' : "Bonding Activities",
            style: TextStyle(color: Theme.of(context).hintColor)),
      ),

      ///// END OF APPBAR
      ///
      ///
      body: Consumer<SuggestionsProvider>(
        builder: (context, value, child) {
          // print("In consumer ${value.places}");
          if (value.status == "failed") {
            return Center(child: Text(value.failedMessage!));
          } else if (value.status == "success") {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView.builder(
                    itemCount: value.places.length,
                    itemBuilder: (context, index) {
                      // final place = places.entries.elementAt(index);

                      /////// CARD BUILDER METHOD
                      ///
                      return cardBuilder(
                          context: context,
                          businessStatus: value.places[index].businessStatus,
                          name: value.places[index].name,
                          openingHours: value.places[index].openingHours,
                          photos: value.places[index].photos,
                          placeId: value.places[index].placeId,
                          plusCode: value.places[index].plusCode,
                          rating: value.places[index].rating,
                          types: value.places[index].types,
                          userRatingsTotal:
                              value.places[index].userRatingsTotal,
                          vicinity: value.places[index].vicinity,
                          queryType: value.places[index].queryType);
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
  cardBuilder({
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
              // Padding(
              //   padding: const EdgeInsets.only(top: 15),
              //   child: Wrap(
              //     alignment: WrapAlignment.spaceEvenly,
              //     spacing: 7,
              //     runSpacing: 2,
              //     children: [
              //       for (String type in types)
              //         Text(
              //           type,
              //           style: TextStyle(
              //               color: Theme.of(context).hintColor,
              //               fontWeight: FontWeight.w600),
              //           overflow: TextOverflow.ellipsis,
              //         )
              //     ],
              //   ),
              // )
            ]),
      ),
    );
  }
}

// openingHours: {open_now: true}
// plusCode: {compound_code: 4M42+PW Byblos, Lebanon, global_code: 8G6Q4M42+PW}
// photos: [{height: 2848, html_attributions: [<a href="https://maps.google.com/maps/contrib/118096579659904185522">Victory Byblos Hotel &amp; Spa</a>], photo_reference: AWU5eFgY5q91xs3FEJBESwx-1dHaJlNcEsPeNIGFKo8qfU8whpBnN_jMbPrgLsvWCF0azknvgwHoa2XA9xDe_WWk3j_EQOm9vjFbsUqgF0_VdPGLADiU69uHq3jk1-FwKUR9BQacH9v1Y7Gi5UJ3VHLtWgYG30oZ81_dg1z51ARLN-LGhVHW, width: 4288}]
// types: [night_club, parking, bar, lodging, spa, point_of_interest, establishment]
