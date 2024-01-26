import 'package:bound_harmony/models/message.dart';
import 'package:bound_harmony/providers/messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdviceScreen extends StatefulWidget {
  const AdviceScreen({super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: const Color.fromARGB(255, 141, 138, 138),
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
          color: Color.fromARGB(255, 141, 138, 138),
        ),
        child: Column(
          children: [
            Expanded(
              /// create the time card and group elements (messages) according to their DateTime
              ///
              ///
              child: Consumer<MessagesProvider>(
                builder: (context, value, child) =>
                    GroupedListView<Message, DateTime>(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.all(8),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: false,
                  floatingHeader: false,
                  // elements are the items found in the list
                  elements: value.conversation,
                  // sets the grouping condition: same date
                  groupBy: (message) => DateTime(
                      message.date.year, message.date.month, message.date.day),

                  /// building the group header (Date card)
                  ///
                  groupHeaderBuilder: (Message message) => Center(
                    /// styling the card
                    ///
                    child: Card(
                      color: Theme.of(context).hintColor,
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
                    child: Padding(
                      padding: message.isSentByMe
                          ? const EdgeInsets.only(left: 35)
                          : const EdgeInsets.only(right: 35),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: message.isSentByMe
                            ? const Color.fromARGB(255, 241, 241, 241)
                            : Theme.of(context).primaryColor,
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
              ),
            ),

            // If error in saving prompt
            Consumer<MessagesProvider>(
              builder: (context, value, child) {
                if (value.somethingWentWrong.isNotEmpty) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 4, bottom: 4, right: 35),
                    child: Text(
                      value.somethingWentWrong,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 5,
                  );
                }
              },
            ),

            // If waiting for response
            Consumer<MessagesProvider>(
              builder: (context, value, child) {
                if (value.waiting == true) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 4, bottom: 4, right: 35),
                    child: Text(
                      "waiting",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 5,
                  );
                }
              },
            ),

            /// Styling input field
            ///
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Theme.of(context).hintColor,
                      controller: inputController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).hintColor),
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 48,
                      minWidth: 0,
                      // color: const Color.fromARGB(255, 85, 82, 82),
                      color: Theme.of(context).primaryColor,
                      child: const Icon(Icons.send, color: Colors.white),
                      onPressed: () async {
                        if (inputController.text.isNotEmpty) {
                          final message = Message(
                              text: inputController.text,
                              date: DateTime.now(),
                              isSentByMe: true);
                          inputController.clear();
                          await context
                              .read<MessagesProvider>()
                              .sendMessage(message);
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
