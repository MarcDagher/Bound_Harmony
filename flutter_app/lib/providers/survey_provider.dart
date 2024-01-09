import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveysProvider extends ChangeNotifier {
  getSurvey() async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.get('token');
      final response = await dio.get("$baseUrl/get_survey",
          options: Options(headers: {'authorization': token}));
      print("In getSurvey survey: ${response.data}");
    } on DioException catch (error) {
      print("In getSurvey error: $error");
    }
  }
}
