import 'package:bound_harmony/providers/suggestions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateBuilderScreen extends StatelessWidget {
  const DateBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future getSuggestions() async {
      final suggestions = context.read<SuggestionsProvider>().getSuggestions();
      return suggestions;
    }

    getSuggestions();

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
          print("In consumer");
          print(value.status);
          print(value.failedMessage);
          if (value.status == "failed") {
            return Center(child: Text(value.failedMessage!));
          } else if (value.status == "success") {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final place = places.entries.elementAt(index);

                      /////// CARD BUILDER METHOD
                      ///
                      return cardBuilder(place.value[0], place.value[1],
                          place.value[2], Theme.of(context).hintColor);
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
  cardBuilder(String image, String name, String description, Color nameColor) {
    //// Padding between boxes
    ///
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            //// this padding is for the white box to not take the full space
            ///
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 5),
              ////// image container
              ///
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                  ////// THE FLEXIBLE WIDGET ALLOWS THE TEXT TO WRAP AND TAKE THE SPACE NECESSARY
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: nameColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            description,
                          ),
                        ),
                      ],
                    ),
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
