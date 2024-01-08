import 'package:bound_harmony/models/user.dart';
import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:bound_harmony/reusable%20widgets/user_tile_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPartnersScreen extends StatefulWidget {
  const MyPartnersScreen({Key? key}) : super(key: key);

  @override
  _MyPartnersScreenState createState() => _MyPartnersScreenState();
}

class _MyPartnersScreenState extends State<MyPartnersScreen> {
  // List<User> partners = [
  //   // User(email: 'person@email.com', username: 'Person 1', password: '...'),
  //   // User(email: 'person@email.com', username: 'Person 2', password: '...'),
  //   // User(email: 'person@email.com', username: 'Person 3', password: '...'),
  //   // User(email: 'person@email.com', username: 'Person 4', password: '...'),
  //   // User(email: 'person@email.com', username: 'Person 5', password: '...'),
  //   // User(email: 'person@email.com', username: 'Person 6', password: '...')
  // ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController requestController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    getPartnersList() async {
      final token = await context.read<AuthProvider>().getToken();
      // ignore: use_build_context_synchronously
      await context.read<ConnectionProvider>().getPartners(token);
    }

    getPartnersList();

    return Scaffold(
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
      body: Consumer<ConnectionProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount:
              1, // Set to 1, because we are using a single ListTile for the entire UI
          itemBuilder: (context, index) {
            print(
                "Auth Connection Status in screen: ${context.read<AuthProvider>().preferences?.get('connection_status')}");

            print("List In screen: ${value.listOfPartners}");
            // Widgets to be displayed conditionally
            List<Widget> widgets = [];

            // If no partners, display a message and input request bar
            if (value.listOfPartners.isEmpty) {
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

            // Create input field and the button if:
            // i have partner without current, or no partners at all
            if ((value.listOfPartners.isNotEmpty &&
                    context
                            .read<AuthProvider>()
                            .preferences
                            ?.get('connection_status') ==
                        'false') ||
                (value.listOfPartners.isEmpty)) {
              widgets.add(
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: TextInputField(
                          handleChangeController: requestController,
                          handleValidation: (email) => email!.isEmpty
                              ? "Email is required"
                              : !RegExp(r'^[\w-]+(\.[\w-]+)*@(hotmail\.com|gmail\.com|yahoo\.com|outlook\.com)$')
                                      .hasMatch(requestController.text)
                                  ? "Invalid email format"
                                  : null,
                          placeholder: "Enter your partner's email"),
                    ),
                    const SizedBox(height: 5),
                    Button(
                        text: 'Send Request',
                        handlePressed: () async {
                          if (formKey.currentState!.validate()) {
                            final token =
                                await context.read<AuthProvider>().getToken();
                            // ignore: use_build_context_synchronously
                            await context
                                .read<ConnectionProvider>()
                                .sendRequest(requestController.text, token);
                          }
                        }),
                    if (value.messageSendRequest.isNotEmpty)
                      Text(value.messageSendRequest)
                  ],
                ),
              );
            }

            // If has partners and a current, display all except the last one. The last one in red
            if (value.listOfPartners.isNotEmpty &&
                context
                        .read<AuthProvider>()
                        .preferences
                        ?.get('connection_status') ==
                    'true') {
              for (int i = 0; i < value.listOfPartners.length - 1; i++) {
                widgets.add(
                  Column(
                    children: [
                      buildUserListTile(
                          "add name to db response",
                          value.listOfPartners[i]["requester"],
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
                      'No name yet',
                      value.listOfPartners[value.listOfPartners.length - 1]
                          ['requester'],
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
            if (value.listOfPartners.isNotEmpty &&
                value.preferences?.get('connection_status') == 'false') {
              for (final partner in value.listOfPartners) {
                widgets.add(
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: buildUserListTile(
                            "no name",
                            partner["requester"],
                            context,
                            Icons.accessibility_sharp,
                            Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                );
              }
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
}
