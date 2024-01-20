import 'package:bound_harmony/providers/suggestions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DateBuilderScreen extends StatelessWidget {
  const DateBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future getSuggestions() async {
      final suggestions =
          await context.read<SuggestionsProvider>().getSuggestions("date");
      return suggestions;
    }

    // getSuggestions();

    Map<String, List<String>> places = {
      "date1": [
        "assets/logo.png",
        "Place/Activity Name",
        "This is the description of the date"
      ],
      "date2": [
        "assets/logo.png",
        "Place/Activity Name",
        "This is the description of the date"
      ],
      "date3": [
        "assets/logo.png",
        "Place/Activity Name",
        "This is the description of the date"
      ],
      "date4": [
        "assets/logo.png",
        "Place/Activity Name",
        "This is the description of the date"
      ],
      "date5": [
        "assets/logo.png",
        "Place/Activity Name",
        "This is the description of the date"
      ],
      "date6": [
        "assets/logo.png",
        "Place/Activity Name",
        "This is the description of the date"
      ],
    };

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).hintColor),
        leadingWidth: 30,
        title: Text('Date Builder',
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
            return Center(child: Text("Loading ... "));
          }
        },
      ),
    );
  }

  //////// CARD BUILDER METHOD
  ///
  cardBuilder({
    required BuildContext context,
    required String name,
    required String businessStatus,
    required dynamic openingHours,
    required String placeId,
    required dynamic plusCode,
    required dynamic photos,
    required List types,
    required dynamic rating,
    required dynamic userRatingsTotal,
    required dynamic vicinity,
    required dynamic queryType,
  }) {
    // print("businessStatus: $businessStatus");
    // print("openingHours: $openingHours");
    // print("plusCode: $plusCode");
    // print("photos: $photos");
    // print("types: $types");
    print(photos == "no photos" ? photos : photos[0]['html_attributions'][0]);
    // print("userRatingsTotal: $userRatingsTotal");
    // print("vicinity: $vicinity");
    // print("queryType: $queryType");
    final validatedOpeningHours = openingHours == "no opening hours"
        ? "Opening hours not listed for this place"
        : "Open now: ${openingHours['open_now']}";
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).hintColor,
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(businessStatus,
                    style: const TextStyle(color: Colors.white)), // Top texts 1
                Text(validatedOpeningHours,
                    style: const TextStyle(color: Colors.white)) // Top texts 2
              ]),
              //  SEPARATOR
              const SizedBox(
                height: 15,
              ),
              // SEPARATOR
              Text(name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20)), // Center text name
              // RATINGS
              const SizedBox(
                height: 15,
              ),
              Row(
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
                        color: Color.fromARGB(255, 255, 186, 57), fontSize: 12),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Text(
                "Location: $vicinity",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              if (photos == "no photos")
                const Text(
                  "Link is not listed for this place",
                  style: TextStyle(color: Colors.white),
                ),
              if (photos != "no photos")
                MaterialButton(
                    color: Colors.white,
                    child: Text(
                      'More Details',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
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
                    })
            ]),
      ),
    );
  }
}

// openingHours: {open_now: true}
// plusCode: {compound_code: 4M42+PW Byblos, Lebanon, global_code: 8G6Q4M42+PW}
// photos: [{height: 2848, html_attributions: [<a href="https://maps.google.com/maps/contrib/118096579659904185522">Victory Byblos Hotel &amp; Spa</a>], photo_reference: AWU5eFgY5q91xs3FEJBESwx-1dHaJlNcEsPeNIGFKo8qfU8whpBnN_jMbPrgLsvWCF0azknvgwHoa2XA9xDe_WWk3j_EQOm9vjFbsUqgF0_VdPGLADiU69uHq3jk1-FwKUR9BQacH9v1Y7Gi5UJ3VHLtWgYG30oZ81_dg1z51ARLN-LGhVHW, width: 4288}]
// types: [night_club, parking, bar, lodging, spa, point_of_interest, establishment]
