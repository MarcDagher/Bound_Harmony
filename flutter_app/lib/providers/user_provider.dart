import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  updateProfileInfo(token, newUsername) {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = dio.post('$baseUrl/update_profile',
          data: {"username": newUsername},
          options: Options(headers: {"authorization": "Bearer $token"}));

      // print("in updateProfileInfo: ${response.data}");
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
