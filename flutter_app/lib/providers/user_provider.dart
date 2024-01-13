import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // changeUsername method
  String newDefaultUsername = "";
  bool newUsernameSuccess = false;

  // changeLocation method
  String newDefaultLocation = "";
  bool newLocationSuccess = false;

  changeUsername(token, String newUsername) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = await dio.post('$baseUrl/change_username',
          data: {"username": newUsername},
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.data["status"] == "success") {
        newDefaultUsername = newUsername;
        newUsernameSuccess = true;
        notifyListeners();
      }

      print("in changeUsername: ${response.data}");
    } catch (e) {
      print(e);
    }
  }

  changeLocation(token, newLocation) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = await dio.post('$baseUrl/change_location',
          data: {"location": newLocation},
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.data["status"] == "success") {
        newDefaultLocation = newLocation;
        newLocationSuccess = true;
        notifyListeners();
      }

      print("in changeLocation: ${response.data}");
    } catch (e) {
      print(e);
    }
  }

  saveImage(token, image) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    final newImage = await MultipartFile.fromFile(image);
    try {
      final response = await dio.post('$baseUrl/edit_image',
          data: {"profile_pic_url": newImage},
          options: Options(headers: {
            "authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      // print("In provider response: ${response.data}");
    } catch (e) {
      print("In saveImage error: $e");
    }
  }
}
