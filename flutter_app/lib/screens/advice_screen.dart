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
        toolbarHeight: 35,
        backgroundColor: const Color.fromARGB(255, 122, 116, 116),
        title: const Text(
          'Advice',
          style: TextStyle(color: Colors.white),
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
              // Color.fromARGB(255, 255, 255, 255),
              // Color.fromARGB(255, 250, 180, 180),
              Color.fromARGB(255, 63, 60, 60),
              Color.fromARGB(255, 122, 116, 116),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: message.isSentByMe
                        ? const Color.fromARGB(255, 241, 241, 241)
                        : const Color.fromARGB(255, 247, 83, 83),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
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
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: inputController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 119, 118, 118)),
                              borderRadius: BorderRadius.circular(15)),
                          filled: false,
                          fillColor: const Color.fromARGB(255, 85, 82, 82),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 119, 118, 118),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          hintText: 'Type your message here...',
                          hintStyle: const TextStyle(color: Colors.white)),
                    ),
                  ),

                  //// Handle submit button
                  ///
                  ///
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        // side: const BorderSide(
                        //     color: Color.fromARGB(255, 119, 118, 118),
                        //     width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 48,
                      minWidth: 0,
                      // color: const Color.fromARGB(255, 85, 82, 82),
                      color: Theme.of(context).primaryColor,
                      child: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (inputController.text.isNotEmpty) {
                          final message = Message(
                              text: inputController.text,
                              date: DateTime.now(),
                              isSentByMe: true);
                          setState(() {
                            return messages.add(message);
                          });
                          inputController.clear();
                        }
                      },
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
