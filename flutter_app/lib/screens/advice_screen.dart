import 'package:bound_harmony/models/message.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class AdviceScreen extends StatefulWidget {
  const AdviceScreen({super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  late TextEditingController inputController = TextEditingController();

  /// This will be retreived from the database and organized in the provider to be put here
  /// the history needs to be retreived from the DB
  List<Message> messages = [
    Message(text: 'Yes Sure!', date: DateTime.now(), isSentByMe: false),
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
            'Advice',
            style: TextStyle(color: Theme.of(context).hintColor),
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
              // Color.fromARGB(255, 247, 182, 182),
              // Color.fromARGB(255, 248, 239, 239),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 250, 180, 180),
            ],
            transform: GradientRotation(10),
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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                // this child creates the time card and groups the elements (messages) according to their DateTime
                padding: const EdgeInsets.all(8),
                reverse: true,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: false,
                floatingHeader: false,
                // elements are the items that will be filling our list
                elements: messages,
                // sets the condition upon which the elements will be grouped
                // elements of the same date will be a group
                groupBy: (message) => DateTime(
                    message.date.year, message.date.month, message.date.day),

                /// building the group header (Date card)
                ///
                groupHeaderBuilder: (Message message) => Center(
                  /// styling the card
                  ///
                  child: Card(
                    color: Colors.grey[400],
                    child: Padding(
                      padding: const EdgeInsets.all(8),
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

                /// Building messages Card
                /// if its my message =>  align right : else left
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
                      controller: inputController,
                      style: TextStyle(color: Theme.of(context).hintColor),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(62, 201, 199, 199),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          hintText: 'Type your message here...',
                          hintStyle:
                              TextStyle(color: Theme.of(context).hintColor)),
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
                      onPressed: () {
                        final message = Message(
                            text: inputController.text,
                            date: DateTime.now(),
                            isSentByMe: true);
                        setState(() {
                          return messages.add(message);
                        });
                        inputController.clear();
                      },
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
