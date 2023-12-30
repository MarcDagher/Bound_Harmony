import 'package:bound_harmony/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IncomingRequestsScreen extends StatefulWidget {
  const IncomingRequestsScreen({super.key});

  @override
  State<IncomingRequestsScreen> createState() => _IncomingRequestsScreenState();
}

class _IncomingRequestsScreenState extends State<IncomingRequestsScreen> {
  List<User> requests = [
    User(email: 'person@email.com', name: 'Person 1'),
    User(email: 'person@email.com', name: 'Person 2'),
    User(email: 'person@email.com', name: 'Person 3'),
    User(email: 'person@email.com', name: 'Person 4'),
    User(email: 'person@email.com', name: 'Person 5'),
    User(email: 'person@email.com', name: 'Person 6')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Incoming Requests',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      //// END OF APPBAR /////

      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        ////// Closes a slide when another is open
        child: SlidableAutoCloseBehavior(
          child: ListView.builder(
            // itemBuiler is a callback function called for each item in the in the list (BuildContext, indeex of the item in the list)
            // It returns the widget for the corresponding list item. This depends on the itemCount.
            itemBuilder: (context, index) {
              final name = requests[index].name;
              final email = requests[index].email;
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
                      onPressed: (context) => handleRequest(index, 'Accept'),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => handleRequest(index, 'Reject'),
                      backgroundColor: Colors.red,
                      icon: Icons.cancel,
                      label: 'Reject',
                    ),
                  ],
                ),

                // the child represents the design of each individual listTile

                child: buildUserListTile(name, email, context),
              );
            },
            itemCount: requests.length,
          ),
        ),
      ),
    );
  }

  void handleRequest(int index, String action) {
    // final user = requests[index];
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
  Widget buildUserListTile(String name, String email, BuildContext context) =>
      Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 206, 179, 179))),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              title: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.favorite,
                      size: 35,
                      color: Color.fromARGB(255, 255, 102, 92),
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
