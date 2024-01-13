import 'dart:io';

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
              //////
              ///////////////////// Stack :Circle Avatar + Add Image Icon ///////////////////////
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

                    /// add image icon: on click open bottom sheet
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
                  /// Username display + on click open dialog
                  Consumer<UserProvider>(
                    builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: DisplayBox(
                          text: value.newDefaultUsername == ""
                              ? "Username: ${context.read<AuthProvider>().preferences!.getString('username')}"
                              : "Username: ${value.newDefaultUsername}",
                          handleTap: () {
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
                                              if (formData[0].isNotEmpty) {
                                                await value.changeUsername(
                                                    token, formData[0]);
                                              }
                                              if (formData[1].isNotEmpty) {
                                                await value.changeLocation(
                                                    token, formData[1]);
                                              }
                                              if (value.newLocationSuccess ==
                                                      true ||
                                                  value.newUsernameSuccess ==
                                                      true) {
                                                Navigator.of(context).pop();
                                              }
                                            }
                                          })
                                    ],
                                  );
                                });
                            ////// End of Dialog
                            ///
                          },
                        )),
                  ),

                  /// Email display
                  Padding(
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
                  ),

                  /// Birthdate display
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: DisplayBox(
                        text:
                            "Birthdate: ${context.read<AuthProvider>().preferences!.getString('birthdate')}"),
                  ),

                  /// Location display: to change click on username
                  Consumer<UserProvider>(
                    builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: DisplayBox(
                          text: value.newDefaultLocation == ""
                              ? "Location: ${context.read<AuthProvider>().preferences!.getString('location')}"
                              : "Location: ${value.newDefaultLocation}",
                        )),
                  ),

                  // Incoming Requests Navigation Button
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

                  // My Partners Navigation Button
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
