import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';

class GiftIdeasScreen extends StatelessWidget {
  const GiftIdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map gifts = {
      "gift1": ["Gift Name", "gift image", "Gift description"],
      "gift2": ["Gift Name", "gift image", "gift description"],
      "gift3": ["Gift Name", "gift image", "gift description"],
      "gift4": ["Gift Name", "gift image", "gift description"],
      "gift5": ["Gift Name", "gift image", "gift description"],
      "gift6": ["Gift Name", "gift image", "gift description"],
      "gift7": ["Gift Name", "gift image", "gift description"],
      "gift8": ["Gift Name", "gift image", "gift description"],
      "gift9": ["Gift Name", "gift image", "gift description"],
      "gift10": ["Gift Name", "gift image", "gift description"],
      "gift11": ["Gift Name", "gift image", "gift description"],
      "gift12": ["Gift Name", "gift image", "gift description"],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Gift Ideas'),
        ),
      ),

      //// End of AppBar
      ///
      ///
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, crossAxisSpacing: 5),
          itemCount: gifts.length,
          itemBuilder: (contex, index) {
            final gift = gifts.entries.elementAt(index);

            return giftCardBuilder(gift.value[1], gift.value[0], gift.value[2],
                Theme.of(context).hintColor);
          },
        ),
      ),
      // bottomNavigationBar: const MyNavigationBar(),
    );
  }

  //////// Card Builder method
  ///
  ///
  Widget giftCardBuilder(
      String image, String name, String description, Color nameColor) {
    //// main card container
    ///
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[300],
        ),

        /////// Column joining the three (image frame, name, description)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 10),
              child: Row(
                ////// Expanded row to give full width to image frame
                ///
                children: [
                  Expanded(
                    child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(child: Text(image))),
                  ),
                ],
              ),
            ),

            ///// Row to align the texts to start
            ///
            ///
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),

                    ////// Column of texts
                    ///
                    ///
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: nameColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            description,
                            style: TextStyle(color: nameColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
