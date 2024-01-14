import 'package:bound_harmony/models/user.dart';
import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:bound_harmony/reusable%20widgets/user_tile_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MyPartnersScreen extends StatefulWidget {
  const MyPartnersScreen({Key? key}) : super(key: key);

  @override
  _MyPartnersScreenState createState() => _MyPartnersScreenState();
}

class _MyPartnersScreenState extends State<MyPartnersScreen> {
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
            // Widgets to be displayed conditionally
            List<Widget> widgets = [];

            // If has partners without a current, display all + input request bar
            if (value.listOfPartners.isNotEmpty &&
                value.currentPartner == false) {
              for (final partner in value.listOfPartners) {
                widgets.add(
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: UserListTile(
                            name: partner["requester_name"],
                            email: partner["requester"],
                            context: context,
                            icon: Icons.accessibility_sharp,
                            iconColor: Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                );
              }
            }

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
            // if has partner without current, or no partners at all
            if ((value.listOfPartners.isNotEmpty &&
                    value.currentPartner == false) ||
                (value.listOfPartners.isEmpty)) {
              widgets.add(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
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
                ),
              );
            }

            // If has partners and a current, display all except the last one. The last one is Slidable
            if (value.listOfPartners.isNotEmpty &&
                value.currentPartner == true) {
              for (int i = 0; i < value.listOfPartners.length - 1; i++) {
                widgets.add(
                  Column(
                    children: [
                      UserListTile(
                          name: value.listOfPartners[i]["requester_name"],
                          email: value.listOfPartners[i]["requester"],
                          context: context,
                          icon: Icons.accessibility_sharp,
                          iconColor: Theme.of(context).hintColor),
                      const SizedBox(height: 5),
                    ],
                  ),
                );
              }

              // Creating Slidable that can disconnect on click
              widgets.add(Slidable(
                  endActionPane:
                      ActionPane(motion: const BehindMotion(), children: [
                    SlidableAction(
                      onPressed: (context) async {
                        final token =
                            await context.read<AuthProvider>().getToken();
                        int? index;
                        for (int i = 0; i < value.listOfPartners.length; i++) {
                          if (value.listOfPartners[i]['status'] == 'accepted') {
                            index = i;
                          }
                        }
                        await value.disconnect(
                            token, value.listOfPartners[index!]["id"]);
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.cancel,
                      label: "Disconnect",
                    )
                  ]),
                  child: UserListTile(
                      name:
                          value.listOfPartners[value.listOfPartners.length - 1]
                              ["requester_name"],
                      email:
                          value.listOfPartners[value.listOfPartners.length - 1]
                              ['requester'],
                      context: context,
                      icon: Icons.favorite,
                      iconColor: Theme.of(context).primaryColor)));
            }

            // Return the list of widgets inside a single ListTile
            return Column(
              children: widgets,
            );
          },
        ),
      ),
    );
  }
}
