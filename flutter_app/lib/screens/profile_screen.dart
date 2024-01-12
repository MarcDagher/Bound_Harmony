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
  // Future handlePopUp({
  //   required String alertTitle,
  //   required String placeholder,
  //   required handleSubmit,
  //   required TextEditingController controller,
  //   required validator,
  // }) =>

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                  Consumer<AuthProvider>(
                    builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),

                        ////// username
                        child: DisplayBox(
                          text:
                              "Username: ${value.preferences?.getString('username')}",
                          handleTap: () {
                            /// they have the same input field, so make the card for both the username and location
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Change Username"),
                                      content: Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextInputField(
                                              placeholder: "New Username",
                                              handleChangeController:
                                                  usernameController,
                                              handleValidation: (text) =>
                                                  text!.isEmpty
                                                      ? "Field is required"
                                                      : null,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: TextInputField(
                                                placeholder: "New Location",
                                                handleChangeController:
                                                    locationController,
                                                // handleValidation: (text) =>
                                                //     text!.isEmpty
                                                //         ? "Field is required"
                                                //         : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Button(
                                            text: "Submit",
                                            handlePressed: () async {
                                              // if (formKey.currentState!
                                              //     .validate()) {}
                                              final SharedPreferences
                                                  preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              final token =
                                                  preferences.get('token');
                                              await context
                                                  .read<UserProvider>()
                                                  .updateProfileInfo(token,
                                                      usernameController.text);
                                            })
                                      ],
                                    ));
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
                              text: "Email: ${value.preferences?.get('email')}",
                            ),
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
                            ////// Birthdate
                            child: DisplayBox(
                                text:
                                    "Birthdate: ${value.preferences?.get('birthdate')}"),
                          ),
                        ],
                      ),
                    );
                  }),

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
