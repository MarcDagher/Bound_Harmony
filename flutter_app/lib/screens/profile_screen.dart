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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ////// Circle Avatar + Add Image Icon + Edit Info Icon
                Consumer<UserProvider>(
                  builder: (context, value, child) => Stack(children: [
                    value.image != ""
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(
                                  '${Requests.imageBaseUrl}/${value.image}'),
                            ),
                          )
                        : _image != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                child: CircleAvatar(
                                  radius: 90,
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
                                    String formData = "";
                                    Color buttonColor =
                                        Theme.of(context).primaryColor;
                                    return AlertDialog(
                                      //// Styling Alert Diolog
                                      ///
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),

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
                                                formData = text;
                                              });
                                            },
                                          ),
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
                                              if (formData.isNotEmpty) {
                                                final SharedPreferences
                                                    preferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                final token =
                                                    preferences.get('token');
                                                if (formData.isNotEmpty) {
                                                  await value.changeUsername(
                                                      token, formData);
                                                }
                                                if (value.newUsernameSuccess ==
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
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
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
                      builder: (context, value, child) => DisplayBox(
                        title: "Username: ",
                        text: value.newDefaultUsername == ""
                            ? "${context.read<AuthProvider>().preferences!.getString('username')}"
                            : value.newDefaultUsername,
                      ),
                    ),

                    /// Email display
                    Row(
                      children: [
                        Expanded(
                          ////// email
                          child: DisplayBox(
                            title: "Email : ",
                            text:
                                "${context.read<AuthProvider>().preferences!.getString('email')}",
                          ),
                        ),
                      ],
                    ),

                    /// Birthdate display
                    DisplayBox(
                        title: "Birthdate: ",
                        text:
                            "${context.read<AuthProvider>().preferences!.getString('birthdate')}"),

                    // Incoming Requests Navigation Button
                    MaterialButton(
                        shape: const Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 235, 235, 235))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 23, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  shadows: const [Shadow(blurRadius: 0.2)],
                                  Icons.record_voice_over_rounded,
                                  color: Theme.of(context).hintColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Incoming Requests',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
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

                    // const SizedBox(height: 10),

                    MaterialButton(
                        shape: const Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 235, 235, 235))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 23, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'My Partners',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                        onPressed: () {
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
                      builder: (context, value, child) => MaterialButton(
                        shape: const Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 235, 235, 235))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 22, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  shadows: const [Shadow(blurRadius: 0.2)],
                                  Icons.logout,
                                  color: Theme.of(context).hintColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Theme.of(context).hintColor,
                            )
                          ],
                        ),
                        onPressed: () async {
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
                      ),
                    ),
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
                //// Remove
                ///
                TextButton.icon(
                    onPressed: () async {
                      await context.read<UserProvider>().removeImage();
                      _image = null;
                    },
                    icon: const Icon(Icons.highlight_remove_sharp,
                        color: Colors.white),
                    label: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.white),
                    )),

                /// Gallery
                TextButton.icon(
                    onPressed: () async {
                      await galleryImagePicker();

                      final SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      final token = preferences.get('token');
                      // ignore: use_build_context_synchronously
                      await context
                          .read<UserProvider>()
                          .saveImage(token, _image);
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
