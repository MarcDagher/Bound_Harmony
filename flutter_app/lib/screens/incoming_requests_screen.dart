import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/reusable%20widgets/navigation_button.dart';
import 'package:bound_harmony/reusable%20widgets/user_tile_builder.dart';
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
        backgroundColor: Colors.white,
        title: Text(
          'Incoming Requests',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Theme.of(context).hintColor),
        ),
      ),

      //// END OF APPBAR /////

      body: Consumer<ConnectionProvider>(builder: (context, value, child) {
        if (value.currentPartner == true) {
          return const Center(child: Text("You're already in a relationship!"));
        } else if (value.currentPartner == false) {
          /// If User doesn't have any requests
          ///
          if (value.noRequests == true) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(
                child: Container(
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).hintColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Don't have a partner? No Problem! \nGo to my partners and send a request or go get some advice!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Column(children: [
                        NavigationButton(
                            text: "My Partners",
                            textAndRightIconColor: Colors.white,
                            buttonColor: Theme.of(context).primaryColor,
                            handlePressed: () {
                              value.successSendRequest = false;
                              value.messageSendRequest = "";
                              context.goNamed("My Partners");
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: NavigationButton(
                              text: "Advice",
                              textAndRightIconColor:
                                  Theme.of(context).primaryColor,
                              buttonColor: Colors.white,
                              handlePressed: () {
                                context.goNamed("Advice");
                              }),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            );

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
