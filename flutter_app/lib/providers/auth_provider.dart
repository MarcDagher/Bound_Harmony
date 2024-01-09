import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final dio = Dio();
  bool? successSignUp;
  bool? emailTaken;

  bool? successLogin;
  bool? wrongCredentials;

  SharedPreferences? preferences;
  String? prefId;
  String? prefUsername;
  String? prefEmail;
  String? prefConnectionStatus;
  String? prefCoupleSurveyStatus;

  // Get an instance of preferences
  initializePreferences() async {
    // ignore: prefer_conditional_assignment
    preferences = await SharedPreferences.getInstance();
    notifyListeners();
    return preferences;
  }

  // Retreive Token
  Future getToken() async {
    await initializePreferences();
    final String? token = preferences?.getString('token');
    return token;
  }

  // Send Sign Up request
  Future signUpRequest(
      String formUsername, String formEmail, String formPassword) async {
    final baseUrl = Requests.baseUrl;
    successLogin = false;
    wrongCredentials = false;
    try {
      final response = await dio.post("$baseUrl/register", data: {
        "username": formUsername,
        "email": formEmail,
        "password": formPassword,
        "birthdate": "15-01-2003",
      });

      if (response.data['status'] == "success") {
        successSignUp = true;
        emailTaken = false;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 302) {
        emailTaken = true;
        successSignUp = false;
      }
    }

    notifyListeners();
  }

  // Send Log In request
  Future logInRequest(email, password) async {
    final baseUrl = Requests.baseUrl;

    successSignUp = false;
    emailTaken = false;

    try {
      final response = await dio.post(
        "$baseUrl/login",
        data: {"email": email, "password": password},
      );

      if (response.data['status'] == "success") {
        successLogin = true;
        wrongCredentials = false;
        final token =
            JwtDecoder.decode(response.data['authorisation']['token']);

        await initializePreferences();

        // adding token payload to the Preferences
        preferences?.setString(
            'token', response.data['authorisation']['token']);
        preferences?.setString('id', token['sub']);
        preferences?.setString('username', token['username']);
        preferences?.setString('email', token['email']);
        preferences?.setString('connection_status', token['connection status']);
        preferences?.setString(
            'couple_survey_status', token['couple survey status']);
      }
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {
        successLogin = false;
        wrongCredentials = true;
      }
    }

    notifyListeners();
  }
}
