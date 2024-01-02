import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final dio = Dio();

  void signUp(
      String formUsername, String formEmail, String formPassword) async {
    final baseUrl = Requests.baseUrl;
    final response = await dio.post("$baseUrl/register", data: {
      "username": formUsername,
      "email": formEmail,
      "password": formPassword,
      "birthdate": "15-01-2003",
    });
    print(response.data.toString());
    notifyListeners();
  }
}
