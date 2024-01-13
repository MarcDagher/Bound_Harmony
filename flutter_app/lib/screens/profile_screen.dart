import 'dart:io';
import 'dart:typed_data';

import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/user_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/display_box.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              ///////////////////// Stack: Profile Image + Edit button ///////////////////////
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 80.0,
                            backgroundImage: FileImage(File(_image!.path)),
                          )
                        : const Icon(
                            Icons.account_circle,
                            size: 200,
                          ),

                    //// bottom sheet to choose image
                    ///
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          child: const Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                          onTap: () {
                            buildBottomSheet(context);
                          },
                        ))
                  ],
                ),
              ),

              ///////////////////// Column: Username - email - birthdate - Location - NavButton x2  ///////////////////////
              Column(
                children: [
                  Consumer<UserProvider>(
                    builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),

                        ////// username
                        child: DisplayBox(
                          // text: "Username: ${value.preferences?.getString('username')}" ,
                          text: value.newDefaultUsername == ""
                              ? "Username: ${context.read<AuthProvider>().preferences!.getString('username')}"
                              : "Username: ${value.newDefaultUsername}",
                          handleTap: () {
                            /// they have the same input field, so make the card for both the username and location
                            showDialog(
                                context: context,
                                builder: (context) {
                                  List formData = ["", ""];
                                  Color buttonColor =
                                      Theme.of(context).primaryColor;
                                  return AlertDialog(
                                    title: const Text("Edit Profile Info"),
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextInputField(
                                          placeholder: "New Username",
                                          handleChange: (text) {
                                            setState(() {
                                              formData[0] = text;
                                            });
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: TextInputField(
                                            placeholder: "New Location",
                                            handleChange: (text) {
                                              setState(() {
                                                formData[1] = text;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ///// Alert Submit Button
                                      ///
                                      Button(
                                          text: "Submit",
                                          color: buttonColor,
                                          handlePressed: () async {
                                            if (formData[0].isNotEmpty ||
                                                formData[1].isNotEmpty) {
                                              final SharedPreferences
                                                  preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              final token =
                                                  preferences.get('token');
                                              await value.updateProfileInfo(
                                                  token, formData[0]);
                                              if (value.newUsernameSuccess ==
                                                  true) {
                                                Navigator.of(context).pop();
                                                value.newUsernameSuccess =
                                                    false;
                                              }
                                            }
                                          })
                                    ],
                                  );
                                });
                          },
                        )),
                  ),

                  Consumer<AuthProvider>(builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            ////// email
                            child: DisplayBox(
                              text:
                                  "Email: ${context.read<AuthProvider>().preferences!.getString('email')}",
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  // Consumer<AuthProvider>(builder: (context, value, child) {
                  //   return
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                          ////// Birthdate
                          child: DisplayBox(
                              text:
                                  "Birthdate: ${context.read<AuthProvider>().preferences!.getString('birthdate')}"),
                        ),
                      ],
                    ),
                  ),
                  // }),

                  Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      ////// location
                      child: DisplayBox(
                        text: 'Location: Still need to figure this out',
                      )), // Figure out how to do that... depends on google api

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

  Future<void> galleryImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

  Future<void> cameraImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = selectedImage;
    });
  }

  buildBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              const Text(
                "Choose Profile Photo",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton.icon(
                    onPressed: () async {
                      await cameraImagePicker();
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera")),
                TextButton.icon(
                    onPressed: () async {
                      await galleryImagePicker();

                      /// Attempt to send File to DB
                      /// //////////////////////////
                      if (_image != null) {
                        final SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        final token = preferences.get('token');
                        await context
                            .read<UserProvider>()
                            .saveImage(token, _image);
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Gallery")),
              ])
            ]),
          );
        });
  }
}
