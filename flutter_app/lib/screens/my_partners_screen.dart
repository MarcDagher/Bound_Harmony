import 'package:bound_harmony/models/user.dart';
import 'package:bound_harmony/reusables/button.dart';
import 'package:bound_harmony/reusables/display_box.dart';
import 'package:bound_harmony/reusables/text_input.dart';
import 'package:flutter/material.dart';

class MyPartnersScreen extends StatefulWidget {
  const MyPartnersScreen({Key? key}) : super(key: key);

  @override
  _MyPartnersScreenState createState() => _MyPartnersScreenState();
}

class _MyPartnersScreenState extends State<MyPartnersScreen> {
  // Fetch partner history from the database
  List<User> partners = [
    User(email: 'person@email.com', name: 'Person 1'),
    User(email: 'person@email.com', name: 'Person 2'),
    User(email: 'person@email.com', name: 'Person 3'),
    User(email: 'person@email.com', name: 'Person 4'),
    User(email: 'person@email.com', name: 'Person 5'),
    User(email: 'person@email.com', name: 'Person 6')
  ];
  bool currentPartner = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'My History',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        //// End of AppBar
        ///
        ///
        body: ListView.builder(
          itemCount:
              1, // Set to 1, because we are using a single ListTile for the entire UI
          itemBuilder: (context, index) {
            // Widgets to be displayed conditionally
            List<Widget> widgets = [];

            // If no partners, display a message and input request bar
            if (partners.isEmpty) {
              widgets.add(
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 80),
                  child: Column(
                    children: [
                      Text("You don't have any previous partners"),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              );
            }

            // If has partners and a current, display all except the last one. The last one in red
            if (partners.isNotEmpty && currentPartner) {
              //   final name = partners[index].name;
              // final email = partners[index].email;
              for (int i = 0; i < partners.length - 1; i++) {
                widgets.add(
                  Column(
                    children: [
                      buildUserListTile(
                          partners[i].name,
                          partners[i].email,
                          context,
                          Icons.accessibility_sharp,
                          Theme.of(context).hintColor),
                      const SizedBox(height: 5),
                    ],
                  ),
                );
              }

              // Creating the red button that can disconnect on click
              widgets.add(buildUserListTile(
                      partners[partners.length - 1].name,
                      partners[partners.length - 1].email,
                      context,
                      Icons.favorite,
                      Theme.of(context).primaryColor)
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: MaterialButton(
                  //         color: Theme.of(context).primaryColor,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         onPressed: () {},
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 17),
                  //           child: Row(
                  //             children: [
                  //               Text(
                  //                 partners[partners.length - 1].name,
                  //                 style: const TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 20,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  );
            }

            // If has partners without a current, display all + input request bar
            if (partners.isNotEmpty && !currentPartner) {
              for (User partner in partners) {
                widgets.add(
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: buildUserListTile(
                            partner.name,
                            partner.email,
                            context,
                            Icons.accessibility_sharp,
                            Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                );
              }
            }

            // Create input field and the button
            if ((partners.isNotEmpty && !currentPartner) ||
                (partners.isEmpty)) {
              widgets.add(
                Column(
                  children: [
                    const TextInputField(
                        placeholder: "Enter your partner's email"),
                    const SizedBox(height: 5),
                    Button(text: 'Send Request', handlePressed: () {}),
                  ],
                ),
              );
            }

            // Return the list of widgets inside a single ListTile
            return ListTile(
              title: Column(
                children: widgets,
              ),
            );
          },
        ),
      ),
    );
  }

  // I did it here to avoid creating a separate file for only a one time import
  Widget buildUserListTile(String name, String email, BuildContext context,
          IconData icon, Color iconColor) =>
      Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.2, color: Color.fromARGB(255, 206, 179, 179))),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      icon,
                      size: 35,
                      color: iconColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
