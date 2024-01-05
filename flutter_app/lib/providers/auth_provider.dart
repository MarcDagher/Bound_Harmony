import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final dio = Dio();
  bool? success;
  bool? emailTaken;
  bool? wrongCredentials;

  AuthProvider({this.emailTaken, this.success, this.wrongCredentials});

  Future signUpRequest(
      String formUsername, String formEmail, String formPassword) async {
    final baseUrl = Requests.baseUrl;
    try {
      final response = await dio.post("$baseUrl/register", data: {
        "username": formUsername,
        "email": formEmail,
        "password": formPassword,
        "birthdate": "15-01-2003",
      });
      // print("from provider => response data: ${response.data}");

      if (response.data['status'] == "success") {
        success = true;
        emailTaken = false;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 302) {
        emailTaken = true;
        success = false;
      }
      // print("from provider => status code: ${e.response!.statusCode}");
    }

    // print("from provider => success: $success");
    // print("from provider => emailTaken: $emailTaken");
    notifyListeners();
  }

  signInRequest(email, password) async {
    final baseUrl = Requests.baseUrl;
    success = false;
    wrongCredentials = false;

    try {
      final response = await dio.post(
        "$baseUrl/login",
        data: {"email": email, "password": password},
      );

      print("from provider => response data: ${response.data}");

      if (response.data['status'] == "success") {
        success = true;
        wrongCredentials = false;
      }
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {
        success = false;
        wrongCredentials = true;
      }
      print("from provider => status code: ${error.response!.statusCode}");
    }

    print("from provider => success: $success");
    print("from provider => wrongCreds: $wrongCredentials");

    notifyListeners();
  }
}
