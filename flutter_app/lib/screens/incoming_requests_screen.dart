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
    getdata() async {
      final token = await context.read<AuthProvider>().getToken();
      await context.read<ConnectionProvider>().displayIncomingRequests(token);
      // print(context.read<ConnectionProvider>().listOfRequests);
    }

    getdata();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Incoming Requests',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      //// END OF APPBAR /////

      body: Consumer<ConnectionProvider>(builder: (context, value, child) {
        /// If User doesn't have any requests
        ///
        if (value.noRequests == true) {
          return Center(
            child: Text(
              value.messageDisplayRequests,
              style:
                  TextStyle(color: Theme.of(context).hintColor, fontSize: 17),
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
                          onPressed: (context) {
                            // handleRequest(index, 'Accept')
                            print(value.listOfRequests?[index]);
                            print(value.listOfRequests?[index]['id']);
                          },
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            print(
                                "From on pressed: $index, ${value.listOfRequests?[index]}");
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
          return const Center(child: Text("loading..."));
        }
      }),
    );
  }

  void handleRequest(int index, String action, requestID) async {
    // final user = requests[index];
    // setState(() => requests.removeAt(index)); // this will only remove from UI
    final token = await context.read<AuthProvider>().getToken();

    switch (action) {
      case 'Accept':

      /// Remove all of the requests and adjust database:
      /// change user's current status to true
      case 'Reject':
        await context
            .read<ConnectionProvider>()
            .respondToRequest(token, requestID, 'rejected');
        // setState(() => requests.removeAt(index));

        /// Remove the rejected one
        /// add to db the rejected status

        break;
      default:

      ///
    }
  }
}
