import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IncomingRequestsScreen extends StatefulWidget {
  const IncomingRequestsScreen({super.key});

  @override
  State<IncomingRequestsScreen> createState() => _IncomingRequestsScreenState();
}

class _IncomingRequestsScreenState extends State<IncomingRequestsScreen> {
  List requests = [
    'first@123.com',
    'second@123.com',
    'third@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
    'fourth@123.com',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Incoming Requests',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),

      //// END OF APPBAR /////

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        ////// Closes a slide when another is open
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: ListView.builder(
            // itemBuiler is a callback function called for each item in the in the list (BuildContext, indeex of the item in the list)
            // It returns the widget for the corresponding list item. This depends on the itemCount.
            itemBuilder: (context, index) {
              final user = requests[index];
              //// EACH BOX IS A SLIDABLE WITH A STARTACTIONN AND AN ENDACTION
              return Slidable(
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.green,
                      icon: Icons.check,
                      label: 'Accept',
                      onPressed: (context) => handleRequest(index, 'Accept'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => handleRequest(index, 'Reject'),
                      backgroundColor: Colors.red,
                      icon: Icons.cancel,
                      label: 'Reject',
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),

                // the child represents the design of each individual listTile

                child: buildUserListTile(user),
              );
            },
            itemCount: requests.length,
          ),
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }

  void handleRequest(int index, String action) {
    final user = requests[index];
    setState(() => requests.removeAt(index)); // this will only remove from UI

    switch (action) {
      case 'Accept':

      /// Remove all of the requests and adjust database:
      /// change user's current status to true
      case 'Reject':

        /// Remove the rejected one
        /// add to db the rejected status

        break;
      default:

      ///
    }
  }

// I did it here to avoid creating a separate file for only a one time import
  Widget buildUserListTile(user) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).hintColor),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              title: Text(
                user,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      );
}
