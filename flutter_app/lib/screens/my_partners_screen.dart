import 'package:bound_harmony/reusables/button.dart';
import 'package:bound_harmony/reusables/display_box.dart';
import 'package:bound_harmony/reusables/navigation_bar.dart';
import 'package:bound_harmony/reusables/text_input.dart';
import 'package:flutter/material.dart';

class MyPartnersScreen extends StatefulWidget {
  const MyPartnersScreen({super.key});

  @override
  State<MyPartnersScreen> createState() => _MyPartnersScreenState();
}

class _MyPartnersScreenState extends State<MyPartnersScreen> {
  //fetch partner history from the data base
  List partners = [
    'first@123.com',
    'first@123.com',
    'first@123.com',
    'first@123.com'
  ];
  bool currentPartner = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'My History',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          toolbarHeight: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              /////////////////// if no partners display message + input request bar
              if (partners.isEmpty)
                const Column(
                  children: [
                    DisplayBox(text: 'You have no partners'),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),

              ///////////////// if has partners and a current display all except last one. last one in red
              if (partners.isNotEmpty && currentPartner == true)
                for (int i = 0; i < partners.length - 1; i++)
                  Column(
                    children: [
                      DisplayBox(text: partners[i]),
                      const SizedBox(height: 5)
                    ],
                  ),

              ///////////////////////// creating the red button that can disconnect on click
              if (partners.isNotEmpty && currentPartner == true)
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          child: Row(
                            children: [
                              Text(partners[partners.length - 1],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              /////////////////////// if has partners without a current, display all + input request bar
              if (partners.isNotEmpty && currentPartner == false)
                for (String partner in partners)
                  Column(
                    children: [
                      DisplayBox(text: partner),
                      const SizedBox(height: 5)
                    ],
                  ),
              ////////////////////////// create input field and the button
              if ((partners.isNotEmpty && currentPartner == false) ||
                  (partners.isEmpty))
                Column(
                  children: [
                    const TextInputField(
                        placeholder: "Enter your partner's email"),
                    const SizedBox(height: 5),
                    Button(text: 'Send Request', handlePressed: () {})
                  ],
                ),
            ],
          ),
        ),
        bottomNavigationBar: const MyNavigationBar(),
      ),
    );
  }
}
