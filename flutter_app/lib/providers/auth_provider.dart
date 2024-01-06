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
  int? pref_id;
  String? pref_username;
  String? pref_email;
  String? pref_connection_status;
  String? pref_couple_survey_status;

  // AuthProvider({this.emailTaken, this.success, this.wrongCredentials});

  Future initializePreferences() async {
    // inithializeing preferences.
    // gets an instance of the SharedPreference file (a Map wwith key value pairs) for this app.
    // ignore: prefer_conditional_assignment
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
  }

  Future getAllPreferences() async {
    // there is still: location - birthdate - image
    await initializePreferences();
    pref_id = preferences?.getInt('id');
    pref_username = preferences?.getString('username');
    pref_email = preferences?.getString('email');
    pref_connection_status = preferences?.getString('connection_status');
    pref_couple_survey_status = preferences?.getString('couple_survey_status');
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

      // print(
      //     "from provider => response data: ${response.data['authorisation']['token']}");
      print(JwtDecoder.decode(response.data['authorisation']['token']));

      if (response.data['status'] == "success") {
        successLogin = true;
        wrongCredentials = false;

        // checking if the preferences instance already exists
        // // gets an instance of the SharedPreference file (a Map wwith key value pairs) for this app.
        initializePreferences();

        // adding token payload to the Preferences
        preferences?.setInt('id', response.data['user']['id']);
        preferences?.setString('username', response.data['user']['username']);
        preferences?.setString('email', response.data['user']['email']);
        preferences?.setString(
            'connection_status', response.data['user']['connection_status']);
        preferences?.setString('couple_survey_status',
            response.data['user']['couple_survey_status']);
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
    notifyListeners();
  }
}
