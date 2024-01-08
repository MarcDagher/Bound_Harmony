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

  // AuthProvider({this.emailTaken, this.success, this.wrongCredentials});

  Future initializePreferences() async {
    // inithializeing preferences.
    // gets an instance of the SharedPreference file (a Map wwith key value pairs) for this app.
    // ignore: prefer_conditional_assignment
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
  }

  Future getToken() async {
    await initializePreferences();
    final String? token = preferences?.getString('token');
    // print('Inside getToken: $token');
    return token;
  }

  Future saveAllPreferences() async {
    // there is still: location - birthdate - image
    preferences = await SharedPreferences.getInstance();
    prefId = preferences?.getString('id');
    prefUsername = preferences?.getString('username');
    prefEmail = preferences?.getString('email');
    prefConnectionStatus = preferences?.getString('connection_status');
    prefCoupleSurveyStatus = preferences?.getString('couple_survey_status');

    print("Inside saveMethod: ${preferences?.getString('connection_status')}");
    notifyListeners();
  }

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
      // print("from provider => response data: ${response.data}");

      if (response.data['status'] == "success") {
        successSignUp = true;
        emailTaken = false;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 302) {
        emailTaken = true;
        successSignUp = false;
      }
      // print("from provider => status code: ${e.response!.statusCode}");
    }

    // print("from provider => success: $success");
    // print("from provider => emailTaken: $emailTaken");
    notifyListeners();
  }

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
        // checking if the preferences instance already exists
        // // gets an instance of the SharedPreference file (a Map wwith key value pairs) for this app.
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

        // final mytoken = preferences?.getString('token');
        // print("Inside login: $mytoken");
      }
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {
        successLogin = false;
        wrongCredentials = true;
      }
      // print("from provider => status code: ${error.response!.statusCode}");
    }

    // print("from provider => success: $successLogin");
    // print("from provider => wrongCreds: $wrongCredentials");
    saveAllPreferences();
    notifyListeners();
  }
}
