import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/reusable%20widgets/display_box.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // final usernameController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ///////////////////// Column: Profile Image + Edit button ///////////////////////
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 80.0,
                      // child: Icon(Icons.account_circle),
                      backgroundImage: AssetImage("assets/logo.png"),
                    ),
                    Positioned(
                        bottom: 20.0,
                        right: 20.0,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    buildBottomSheet(context));
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.teal,
                            size: 30,
                          ),
                        ))
                  ],
                ),
              ),

              ///////////////////// Column: TextInputField - DisplayBox - TextInputField - Location - NavButton x2  ///////////////////////
              Column(
                children: [
                  Consumer<AuthProvider>(
                    builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: DisplayBox(
                            text:
                                "Username: ${value.preferences?.getString('username')}")),
                  ),
                  // this will be a text. email is displayed from token
                  Consumer<AuthProvider>(builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: DisplayBox(
                                text:
                                    "Email: ${value.preferences?.get('email')}"),
                          ),
                        ],
                      ),
                    );
                  }),

                  Consumer<AuthProvider>(builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: DisplayBox(
                                text:
                                    "Birthdate: ${value.preferences?.get('birthdate')}"),
                          ),
                        ],
                      ),
                    );
                  }),

                  const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: DisplayBox(
                          text:
                              'Location: Still need to figure this out')), // Figure out how to do that... depends on google api

                  // Navigation Buttons
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Theme.of(context).hintColor)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Incoming Requests',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Theme.of(context).hintColor,
                          )
                        ],
                      ),
                      onPressed: () {
                        context.goNamed("Incoming Requests");
                      }),
                  const SizedBox(height: 5),

                  // Custom Navigation button
                  MaterialButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Partners',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          )
                        ],
                      ),
                      onPressed: () {
                        context.goNamed('My Partners');
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBottomSheet(context) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(children: [
      Text(
        "Choose Profile Photo",
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton.icon(
            onPressed: () {}, icon: Icon(Icons.camera), label: Text("Camera")),
        TextButton.icon(
            onPressed: () {}, icon: Icon(Icons.image), label: Text("Gallery")),
      ])
    ]),
  );
}






// SizedBox(
                    //     width: 180,
                    //     height: 180,
                    //     child: Icon(Icons.account_circle,
                    //         size: 180, color: Theme.of(context).hintColor)),




                    // Text(
                    //   'Edit Profile Picture',
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w500,
                    //       color: Theme.of(context).primaryColor,
                    //       decoration: TextDecoration.underline,
                    //       decorationColor: Theme.of(context).primaryColor),
                    // )