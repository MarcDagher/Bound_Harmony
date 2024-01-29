import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final dio = Dio();
  // SignUp variables
  bool successSignUp = false;
  bool emailTaken = false;

  // LogIn Variables
  bool successLogin = false;
  bool wrongCredentials = false;
  bool? firstLogin;
  SharedPreferences? preferences;

  // Get an instance of preferences
  initializePreferences() async {
    // ignore: prefer_conditional_assignment
    preferences = await SharedPreferences.getInstance();
    notifyListeners();
    return preferences;
  }

  Future getToken() async {
    await initializePreferences();
    final String? token = preferences?.getString('token');
    return token;
  }

  Future signUpRequest(
      {required String formUsername,
      required String formEmail,
      required String formPassword,
      required String formBirthdate}) async {
    final baseUrl = Requests.baseUrl;
    successLogin = false;
    wrongCredentials = false;
    try {
      final response = await dio.post("$baseUrl/register", data: {
        "username": formUsername,
        "email": formEmail,
        "password": formPassword,
        "birthdate": formBirthdate,
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

  Future logInRequest(email, password) async {
    if (email == "admin123@hotmail.com") {
      successSignUp = false;
      emailTaken = false;
      wrongCredentials = true;
      notifyListeners();
    } else {
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
          preferences?.setString('birthdate', token['birthdate']);
          preferences?.setString(
              'connection_status', token['connection status']);
          preferences?.setString(
              'couple_survey_status', token['couple survey status']);
          preferences?.setInt('role_id', response.data['user']['role_id']);
          if (token["location"] == null) {
            preferences?.setString('location', 'n/a');
          } else {
            preferences?.setString('location', token['location']);
          }

          if (token['first_login'] == 0) {
            firstLogin = false;
          } else if (token['first_login'] == 1) {
            firstLogin = true;
          }
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 401) {
          successLogin = false;
          wrongCredentials = true;
        }
      }
      notifyListeners();
    }
  }

  Future logout(token) async {
    final dio = Dio();
    final baseUrl = Requests.baseUrl;

    try {
      await dio.post("$baseUrl/logout",
          options: Options(headers: {"authorization": "Bearer $token"}));
      clearAuthProviderVariables();
    } on DioException catch (error) {
      // print(error);
    }
  }

  Future clearAuthProviderVariables() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    successSignUp = false;
    emailTaken = false;
    successLogin = false;
    wrongCredentials = false;
    notifyListeners();
  }
}
