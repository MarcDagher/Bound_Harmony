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
    'fourth@123.com'
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
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final user = requests[index];
              return Slidable(
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.green,
                      icon: Icons.check,
                      label: 'Accept',
                      onPressed: (context) => handleRequest(index, 'Accept'),
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
                    ),
                  ],
                ),
                child: buildUserListTile(user),
              );
            },
            itemCount: requests.length,
          ),
        ),
      ),
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

  Widget buildUserListTile(user) => ListTile(
        // contentPadding: EdgeInsets.all(16),
        title: Text(
          user,
          style: TextStyle(fontSize: 16),
        ),
      );
}
