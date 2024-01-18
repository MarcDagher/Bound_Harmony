import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/reusable%20widgets/navigation_button.dart';
import 'package:bound_harmony/reusable%20widgets/user_tile_builder.dart';
import 'package:bound_harmony/widgets%20for%20conditional%20UI/connection_status_false.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class IncomingRequestsScreen extends StatefulWidget {
  const IncomingRequestsScreen({super.key});

  @override
  State<IncomingRequestsScreen> createState() => _IncomingRequestsScreenState();
}

class _IncomingRequestsScreenState extends State<IncomingRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    ///
    /// fetch user's incoming pending requests (Changes requests to the current pending list)
    getdata() async {
      final token = await context.read<AuthProvider>().getToken();
      await context.read<ConnectionProvider>().displayIncomingRequests(token);
    }

    getdata();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).hintColor,
        ),
        leadingWidth: 30,
        backgroundColor: Colors.white,
        title: Text(
          'Incoming Requests',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      ),

      //// END OF APPBAR /////

      body: Consumer<ConnectionProvider>(builder: (context, value, child) {
        /// If user is connected to a partner
        if (value.currentPartner == true) {
          return Center(
              child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Color.fromARGB(255, 134, 133, 133),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.white,
                        size: 100,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "You're Already In A Relationship!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: NavigationButton(
                            text: "Go To Suggestions",
                            textAndRightIconColor: Colors.white,
                            buttonColor: Theme.of(context).primaryColor,
                            handlePressed: () {
                              context.goNamed("Suggestions");
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: NavigationButton(
                            text: "Go To Advice",
                            textAndRightIconColor:
                                Theme.of(context).primaryColor,
                            buttonColor: Colors.white,
                            handlePressed: () {
                              context.goNamed("Advice");
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: NavigationButton(
                            text: "Go To Couples Survey",
                            textAndRightIconColor: Colors.white,
                            buttonColor: Theme.of(context).hintColor,
                            handlePressed: () {
                              context.goNamed("Couples Survey");
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        }

        // If user isn't connected to a partner
        else if (value.currentPartner == false) {
          /// If User doesn't have any requests
          ///
          if (value.noRequests == true) {
            return NotConnectedBox(
                text:
                    "Don't have a partner? No Problem!\nGo to my partners and send a request or go get some advice!",
                textFirstButton: "My Partners",
                handlePressedFirstButton: () {
                  value.successSendRequest = false;
                  value.messageSendRequest = "";
                  context.goNamed("My Partners");
                },
                textSecondButton: 'Advice',
                handlePressedSecondButton: () {
                  context.goNamed("Advice");
                });

            /// If User has requests
            ///
          } else if (value.successDisplayRequests == true) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              ////// Closes a slide when another is open
              child: SlidableAutoCloseBehavior(
                child: ListView.builder(
                  // itemBuiler is a callback function called for each item in the in the list (BuildContext, indeex of the item in the list)
                  // It returns the widget for the corresponding list item. This depends on the itemCount.
                  itemBuilder: (context, index) {
                    final name = value.listOfRequests?[index]["requester_name"];
                    final email = value.listOfRequests?[index]["requester"];
                    //// EACH BOX IS A SLIDABLE WITH A START ACTION AND AN ENDACTION
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.green,
                            autoClose: true,
                            icon: Icons.check,
                            label: 'Accept',
                            onPressed: (context) async {
                              handleRequest(index, 'Accept',
                                  value.listOfRequests?[index]['id']);
                            },
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              handleRequest(index, 'Reject',
                                  value.listOfRequests?[index]['id']);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.cancel,
                            label: 'Reject',
                          ),
                        ],
                      ),

                      // the child represents the design of each individual listTile
                      child: UserListTile(
                          name: name,
                          email: email,
                          context: context,
                          icon: Icons.favorite,
                          iconColor: const Color.fromARGB(255, 255, 102, 92)),
                    );
                  },
                  itemCount: value.listOfRequests?.length,
                ),
              ),
            );

            /// If requests haven't loaded yet
            ///
          } else {
            return const Center(child: Text("Loading..."));
          }
        } else {
          return const Center(child: Text("Loading"));
        }
      }),
    );
  }

  void handleRequest(int index, String action, requestID) async {
    final token = await context.read<AuthProvider>().getToken();

    switch (action) {
      case 'Accept':

        /// change user's currentPartner to true and notify listeners
        await context
            .read<ConnectionProvider>()
            .respondToRequest(token, requestID, 'accepted');

      case 'Reject':

        /// Remove the rejected request by listening to the listOfRequests in provider
        await context
            .read<ConnectionProvider>()
            .respondToRequest(token, requestID, 'rejected');
        break;
      default:
    }
  }
}
