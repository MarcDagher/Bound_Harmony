import 'dart:convert';

import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/models/survey_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveysProvider extends ChangeNotifier {
  List<Question?> questions = [];

  getSurvey(int surveyId) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    List<Question> localQuestionsList = [];
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.get('token');
      final response = await dio.get("$baseUrl/get_survey",
          data: {"survey_id": surveyId},
          options: Options(headers: {"authorization": "Bearer $token"}));
      // print("In getSurvey: ${response.data}");
      // print("In getSurvey survey: ${response.data["survey"][0]["question"]}");
      // print("In getSurvey survey");
      for (int i = 0; i < response.data["survey"].length; i++) {
        List listOfOptions = [];
        // print(
        //     "Question $i: ${response.data["survey"][i]["question"]["question"]}");

        for (int j = 0; j < response.data["survey"][i]["options"].length; j++) {
          listOfOptions.add(response.data["survey"][i]["options"][j]["option"]);
          // print(
          //     "Option $j: ${response.data["survey"][i]["options"][j]["option"]}");
        }
        localQuestionsList.add(Question(
            id: response.data["survey"][i]["question"]["question_id"],
            options: listOfOptions,
            question: response.data["survey"][i]["question"]["question"]));
      }
      questions = localQuestionsList;
      notifyListeners();
      // print("In provider. Questions: $questions");
    } on DioException catch (error) {
      print("In getSurvey error: $error");
    }
  }

  saveSurveyResponse(token, listOfResponses) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    List arrayOfResponsesObjects = [];

    for (int i = 0; i < listOfResponses.length; i++) {
      arrayOfResponsesObjects.add({
        "question_id": listOfResponses[i].questionId,
        "response": listOfResponses[i].response
      });
    }

    // print("In provider: $arrayOfResponsesObjects");
    // print("From provider question ID: ${listOfResponses[0].questionId}");
    // print("From provider response: ${listOfResponses[0].response}");

    try {
      final response = await dio.post("$baseUrl/save_responses",
          data: jsonEncode(arrayOfResponsesObjects),
          options: Options(headers: {
            "authorization": "Bearer $token",
            "content-type": "application/json"
          }));
      print("In dio.post response: ${response.data}");
    } on DioException catch (error) {
      print(error);
    }
  }
}
