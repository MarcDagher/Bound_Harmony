import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';

class BondingActivitiesScreen extends StatelessWidget {
  const BondingActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> places = {
      "place1": [
        "assets/logo.png",
        "Activity Name",
        "This is the description of the place"
      ],
      "place2": [
        "assets/logo.png",
        "Activity Name",
        "This is the description of the place"
      ],
      "place3": [
        "assets/logo.png",
        "Activity Name",
        "This is the description of the place"
      ],
      "place4": [
        "assets/logo.png",
        "Activity Name",
        "This is the description of the place"
      ],
      "place5": [
        "assets/logo.png",
        "Activity Name",
        "This is the description of the place"
      ],
      "place6": [
        "assets/logo.png",
        "Activity Name",
        "This is the description of the place"
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Suggestions For You'),
        ),
      ),

      ///// END OF APPBAR
      ///
      ///
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places.entries.elementAt(index);

                /////// CARD BUILDER METHOD
                ///
                return cardBuilder(
                    place.value[0], place.value[1], place.value[2]);
              })),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }

  //////// CARD BUILDER METHOD
  ///
  cardBuilder(String image, String name, String description) {
    //// Padding between boxes
    ///
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            //// this padding is for the grey box to not take the full space
            ///
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 5),
              ////// image container
              ///
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
                //// should be a real image
                ///
                child: Center(child: Text(image)),
              ),
            ),

            ////// Aligning the texts to a column inside a row
            ///
            ///
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      Text(description),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
