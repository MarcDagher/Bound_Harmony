import 'dart:io';

import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/providers/auth_provider.dart';
import 'package:bound_harmony/providers/connection_provider.dart';
import 'package:bound_harmony/providers/messages_provider.dart';
import 'package:bound_harmony/providers/suggestions_provider.dart';
import 'package:bound_harmony/providers/survey_provider.dart';
import 'package:bound_harmony/providers/user_provider.dart';
import 'package:bound_harmony/reusable%20widgets/button.dart';
import 'package:bound_harmony/reusable%20widgets/display_box.dart';
import 'package:bound_harmony/reusable%20widgets/navigation_button.dart';
import 'package:bound_harmony/reusable%20widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(statusBarColor: Colors.white),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                ////// Circle Avatar + Add Image Icon + Edit Info Icon
                Consumer<UserProvider>(
                  builder: (context, value, child) => Stack(children: [
                    value.image != ""
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: CircleAvatar(
                              radius: 95,
                              backgroundImage: NetworkImage(
                                  '${Requests.imageBaseUrl}/${value.image}'),
                            ),
                          )
                        : _image != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                child: CircleAvatar(
                                  radius: 95,
                                  backgroundImage:
                                      FileImage(File(_image!.path)),
                                ),
                              )
                            : Icon(
                                color: Theme.of(context).hintColor,
                                Icons.account_circle,
                                size: 200,
                              ),

                    /// Add image icon: on click open bottom sheet
                    ///
                    Consumer<UserProvider>(
                      builder: (context, value, child) => Positioned(
                          right: 0,
                          child: InkWell(
                            child: Icon(
                              Icons.edit_note_sharp,
                              color: Theme.of(context).hintColor,
                              size: 30,
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    List formData = ["", ""];
                                    Color buttonColor =
                                        Theme.of(context).primaryColor;
                                    return AlertDialog(
                                      //// Styling Alert Diolog
                                      ///
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      shadowColor: Colors.black,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                      actionsPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                      titlePadding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 20),

                                      /// Alert Dialog Title
                                      ///
                                      title: Text(
                                        "Edit Profile Info",
                                        style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontWeight: FontWeight.w600),
                                      ),

                                      /// Alert Dialog Content
                                      ///
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
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.only(top: 5),
                                          //   child: TextInputField(
                                          //     placeholder: "New Location",
                                          //     handleChange: (text) {
                                          //       setState(() {
                                          //         formData[1] = text;
                                          //       });
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      ),

                                      /// Alert Dialog actions
                                      ///
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
                                                  // ignore: use_build_context_synchronously
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
                  ]),
                ),

                /// edit image Text Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 5),
                  child: InkWell(
                    child: Text(
                      'Edit Image',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          decorationColor: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2),
                    ),
                    onTap: () {
                      buildBottomSheet(context);
                    },
                  ),
                ),

                ////// Column contains: Username - email - birthdate - Location - NavButton x2
                Column(
                  children: [
                    /// Username display: to change click on icon
                    Consumer<UserProvider>(
                      builder: (context, value, child) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: DisplayBox(
                            text: value.newDefaultUsername == ""
                                ? "Username: ${context.read<AuthProvider>().preferences!.getString('username')}"
                                : "Username: ${value.newDefaultUsername}",
                          )),
                    ),

                    /// Email display
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
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
                      padding: const EdgeInsets.only(bottom: 8),
                      child: DisplayBox(
                          text:
                              "Birthdate: ${context.read<AuthProvider>().preferences!.getString('birthdate')}"),
                    ),

                    // /// Location display: to change click on icon
                    // Consumer<UserProvider>(
                    //   builder: (context, value, child) => Padding(
                    //       padding: const EdgeInsets.only(bottom: 8),
                    //       child: DisplayBox(
                    //         text: value.newDefaultLocation == ""
                    //             ? "Country: ${context.read<AuthProvider>().preferences!.getString('location')}"
                    //             : "Country: ${value.newDefaultLocation}",
                    //       )),
                    // ),

                    // Incoming Requests Navigation Button
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Theme.of(context).hintColor, width: 2)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Incoming Requests',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w800),
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

                    const SizedBox(height: 8),

                    // My Partners Navigation Button
                    NavigationButton(
                        text: "My Partners",
                        textAndRightIconColor: Colors.white,
                        buttonColor: Theme.of(context).primaryColor,
                        handlePressed: () {
                          context
                              .read<ConnectionProvider>()
                              .successSendRequest = false;
                          context
                              .read<ConnectionProvider>()
                              .messageSendRequest = "";

                          context.goNamed('My Partners');
                        }),

                    // Logout button
                    Consumer<AuthProvider>(
                        builder: (context, value, child) => Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Button(
                                text: "Logout",
                                handlePressed: () async {
                                  final preferences =
                                      await SharedPreferences.getInstance();
                                  final token = preferences.get('token');
                                  await value.logout(token);
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<ConnectionProvider>()
                                      .clearConnectionsProviderVariables();
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<MessagesProvider>()
                                      .clearMessagesProviderVariables();
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<SuggestionsProvider>()
                                      .clearSuggestionsProviderVariables();
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<SurveysProvider>()
                                      .clearSurveyProviderVariables();
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<UserProvider>()
                                      .clearUserProviderVariables();
                                  // ignore: use_build_context_synchronously
                                  context.goNamed("Log In");
                                },
                                color: const Color.fromARGB(255, 95, 95, 95),
                              ),
                            )),
                  ],
                ),
              ],
            ),
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
        backgroundColor: const Color.fromARGB(255, 99, 97, 97),
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              const Text(
                "Change Profile Photo",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton.icon(
                    onPressed: () async {
                      await cameraImagePicker();
                    },
                    icon: const Icon(Icons.camera, color: Colors.white),
                    label: const Text(
                      "Camera",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton.icon(
                    onPressed: () async {
                      await galleryImagePicker();

                      /// Attempt to send File to DB
                      /// //////////////////////////
                      if (_image != null) {
                        final SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        final token = preferences.get('token');
                        // ignore: use_build_context_synchronously
                        await context
                            .read<UserProvider>()
                            .saveImage(token, _image);
                      }
                    },
                    icon: const Icon(Icons.image, color: Colors.white),
                    label: const Text("Gallery",
                        style: TextStyle(color: Colors.white))),
              ])
            ]),
          );
        });
  }
}
