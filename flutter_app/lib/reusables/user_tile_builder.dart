import 'package:flutter/material.dart';

Widget buildUserListTile(String name, String email, BuildContext context,
        IconData icon, Color iconColor) =>
    Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 206, 179, 179))),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    icon,
                    size: 35,
                    color: iconColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      email,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
