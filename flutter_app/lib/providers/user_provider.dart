import 'dart:convert';
import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  // changeUsername method
  String newDefaultUsername = "";
  bool newUsernameSuccess = false;

  // changeLocation method
  String newDefaultLocation = "";
  bool newLocationSuccess = false;

  // used in get_image
  String image = "";

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
    } catch (e) {
      // print(e);
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
    } catch (e) {
      // print(e);
    }
  }

  saveImage(token, imageFile) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    // An XFile is a cross-platform file
    // Change XFile to a list of bytes
    List<int> imageBytes = await imageFile.readAsBytes();

    /// Create a MultipartFile from a chunked stream of bytes
    final newImage =
        MultipartFile.fromBytes(imageBytes, filename: 'profile_pic');

    try {
      final response = await dio.post('$baseUrl/edit_image',
          data: FormData.fromMap({"profile_pic_url": newImage}),
          options: Options(
            headers: {
              "authorization": "Bearer $token",
            },
          ));
    } catch (e) {
      // print("In saveImage error: $e");
    }
  }

  getImage() async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');

    try {
      final response = await dio.get("$baseUrl/get_profile_photo",
          options: Options(
              headers: {"authorization": "Bearer $token"},
              contentType: "application/json"));

      image = response.data['img_path'];
      notifyListeners();
    } on DioException catch (error) {
      // print("in getImage: ${error}");
    }
  }

  Future remove_image() async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      final response = await dio.post("$baseUrl/remove_profile_photo",
          options: Options(headers: {"authorization": "Bearer $token"}));

      if (response.data['status'] == "success") {
        image = "";
        notifyListeners();
      }
      print("In remove_image: ${response}");
    } catch (error) {
      print("In remove_image: ${error}");
    }
  }

  void clearUserProviderVariables() {
    newDefaultUsername = "";
    newUsernameSuccess = false;

    newDefaultLocation = "";
    newLocationSuccess = false;
  }
}
