import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/models/questions_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveysProvider extends ChangeNotifier {
  getSurvey(int survey_id) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.get('token');
      final response =
          await dio.get("$baseUrl/get_survey", data: {"survey_id": survey_id});

      // print(
      //     "In getSurvey survey: ${response.data["survey"][0]["question"]["question"]}");
      // print("In getSurvey survey");
      for (int i = 0; i < response.data["survey"].length; i++) {
        print(
            "Question $i: ${response.data["survey"][i]["question"]["question"]}");
        for (int j = 0; j < response.data["survey"][i]["options"].length; j++) {
          print(
              "Option $j: ${response.data["survey"][i]["options"][j]["option"]}");
        }
      }
      // Question(id: id, options: options, question: question)
    } on DioException catch (error) {
      print("In getSurvey error: $error");
    }
  }
}
