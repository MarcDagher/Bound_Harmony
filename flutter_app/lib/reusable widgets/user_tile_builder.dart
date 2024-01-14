import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String email;
  final BuildContext context;
  final IconData icon;
  final Color iconColor;

  const UserListTile(
      {super.key,
      required this.name,
      required this.email,
      required this.context,
      required this.icon,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
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
  }
}
