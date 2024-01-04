import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // the with keyword allows us to create a class AuthProvider while mixing in the methods and properties of ChangeNotifier without creating a strict inheritance hierarchy. We are not creating a subclass of ChangeNotifier, we are creating a mixin AuthProvider which takes the methods and properties of ChangeNotifier and can also mix in other features from other classes
  final dio = Dio();
  bool? success;
  bool? emailTaken;

  AuthProvider({this.emailTaken, this.success});

  signUpRequest(
      String formUsername, String formEmail, String formPassword) async {
    final baseUrl = Requests.baseUrl;
    try {
      final response = await dio.post("$baseUrl/register", data: {
        "username": formUsername,
        "email": formEmail,
        "password": formPassword,
        "birthdate": "15-01-2003",
      });
      print("from provider => response data: ${response.data}");

      if (response.data['status'] == "success") {
        success = true;
        emailTaken = false;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 302) {
        emailTaken = true;
        success = false;
      }
      print("from provider => status code: ${e.response!.statusCode}");
    }

    print("from provider => success: $success");
    print("from provider => emailTaken: $emailTaken");
    // notifyListeners();
    return [emailTaken, success];
  }
}
