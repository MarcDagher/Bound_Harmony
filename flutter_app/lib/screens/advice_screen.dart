import 'dart:ui';

import 'package:bound_harmony/models/message.dart';
import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class AdviceScreen extends StatefulWidget {
  const AdviceScreen({super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  List<Message> messages = [
    Message(
        text: 'Yes Sure!',
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'Yes Sure!',
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'Yes Sure!',
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'Yes Sure!',
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'Yes Sure!',
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Chat with Cupid',
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),

      ////// End of AppBar
      ///
      ///
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 253, 158, 158),
              Color.fromARGB(255, 248, 239, 239),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              ///// Just like a regural ListView, I used this to group messages by date
              ///
              ///
              child: GroupedListView<Message, DateTime>(
                padding: const EdgeInsets.all(8),
                reverse: true,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: false,
                floatingHeader: true,
                // elements are the items that will be filling our list
                elements: messages,
                // sets the condition upon which the elements will be grouped
                // elements of the same date will be a group
                groupBy: (message) => DateTime(
                    message.date.year, message.date.month, message.date.day),

                /// building the group header (Date card)
                ///
                groupHeaderBuilder: (Message message) => SizedBox(
                  child: Center(
                    child: Card(
                      color: Colors.grey[400],
                      child: Padding(
                        padding: const EdgeInsets.all(8),

                        /// styling the card
                        ///
                        child: Text(
                          DateFormat.yMMMd().format(message.date),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),

                /// Building messages Card
                /// if its my => message align right : else left
                itemBuilder: (context, Message message) => Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Card(
                    color: message.isSentByMe
                        ? const Color.fromARGB(255, 241, 241, 241)
                        : const Color.fromARGB(255, 247, 83, 83),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isSentByMe
                              ? Theme.of(context).hintColor
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// Styling input field
            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).hintColor),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(132, 201, 199, 199),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          hintText: 'Type your message here...',
                          hintStyle:
                              TextStyle(color: Theme.of(context).hintColor)),

                      /// handling submit
                      ///
                      ///// FOR THE HANDLING OF THE MESSAGES, USE ONCHANGED AND CREATE A CONTROLLER. THEN HAVE A BUTTON SUBMIT THE CHANGED VALUES ONCLICK
                      onSubmitted: (text) {
                        final message = Message(
                            text: text, date: DateTime.now(), isSentByMe: true);
                        setState(() {
                          return messages.add(message);
                        });
                      },
                    ),
                  ),

                  //// Handle submit button
                  ///
                  ///
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 5,
                      onPressed: () {},
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
