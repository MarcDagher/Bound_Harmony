import 'package:bound_harmony/models/user.dart';
import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/reusable%20widgets/user_tile_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

    /// get user's connection status "true" or "false"
    getConnectionStatus() async {
      await context.read<AuthProvider>().saveAllPreferences();
      print(
          "Inside method(screen) 1:  ${context.read<AuthProvider>().preferences?.get('connection_status')}");
      print(
          "Inside method(screen) 2: ${context.read<AuthProvider>().prefConnectionStatus}");
    }

    // getConnectionStatus();
    // final connectionStatus = context.read<AuthProvider>().prefConnectionStatus;
    // print("Inside screen conn-status: $connectionStatus");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Incoming Requests',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      //// END OF APPBAR /////

      body: Consumer<AuthProvider>(
        builder: (context, value, child) {
          /// If user already has a connection (prefConnectionStatus = "true")
          ///
          print("In baba consumer: ${value.prefConnectionStatus}");
          print(
              "In baba 2 consumer: ${value.preferences!.getString('connection_status')}");

          if (value.preferences!.get('connection_status') == "true") {
            return const Center(
                child: Text("You're already in a relationship!"));
          }

          /// If user doesn't have a connection (prefConnectionStatus = "false")
          ///
          else if (value.preferences!.get('connection_status') == "false") {
            /// gets incoming requests (pending ones)
            ///
            getdata();
            return Consumer<ConnectionProvider>(
                builder: (context, value, child) {
              /// If User doesn't have any requests
              ///
              if (value.noRequests == true) {
                return Center(
                  child: Text(
                    value.messageDisplayRequests,
                    style: TextStyle(
                        color: Theme.of(context).hintColor, fontSize: 17),
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
                        final name =
                            value.listOfRequests?[index]["requester_name"];
                        final email = value.listOfRequests?[index]["requester"];
                        //// EACH BOX IS A SLIDABLE WITH A STARTACTIONN AND AN ENDACTION
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
                                  await getConnectionStatus();
                                },
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  // print(
                                  //     "From Reject on pressed: $index, ${value.listOfRequests?[index]}");
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
                          child: buildUserListTile(
                              name,
                              email,
                              context,
                              Icons.favorite,
                              const Color.fromARGB(255, 255, 102, 92)),
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
            });
          } else {
            return const Center(child: Text("Loading"));
          }
        },
      ),
    );
  }

  void handleRequest(int index, String action, requestID) async {
    final token = await context.read<AuthProvider>().getToken();

    switch (action) {
      case 'Accept':

        /// Remove all of the requests and adjust database:
        /// change user's current status to true

        await context
            .read<ConnectionProvider>()
            .respondToRequest(token, requestID, 'accepted');

      case 'Reject':

        /// Remove the rejected request by listening to the listOfRequests in controller
        /// list of requests will be updated when request's status becomes rejected
        await context
            .read<ConnectionProvider>()
            .respondToRequest(token, requestID, 'rejected');

        break;
      default:

      ///
    }
  }
}
