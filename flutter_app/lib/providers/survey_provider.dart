import 'dart:convert';

import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/models/survey_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveysProvider extends ChangeNotifier {
  // in getSurvey, to store all questions with their options
  List<Question?> questions = [];

  // in saveSurveyResponse, to toggle UI for a successfuly save request
  bool successSavingResponse = false;

  bool successSavingCouplesSurveyResponse = false;

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
      for (int i = 0; i < response.data["survey"].length; i++) {
        List listOfOptions = [];

        for (int j = 0; j < response.data["survey"][i]["options"].length; j++) {
          listOfOptions.add(response.data["survey"][i]["options"][j]["option"]);
        }
        localQuestionsList.add(Question(
          id: response.data["survey"][i]["question"]["question_id"],
          options: listOfOptions,
          question: response.data["survey"][i]["question"]["question"],
          type: response.data["survey"][i]["question"]["question_type"],
        ));
      }
      questions = localQuestionsList;
      notifyListeners();
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

    // print("From provider question ID: ${listOfResponses[0].questionId}");
    // print("From provider response: ${listOfResponses[0].response}");

    try {
      final response = await dio.post("$baseUrl/save_responses",
          data: jsonEncode(arrayOfResponsesObjects),
          options: Options(headers: {
            "authorization": "Bearer $token",
            "content-type": "application/json"
          }));

      if (response.data["status"] == "success") {
        successSavingResponse = true;
      }
    } on DioException catch (error) {
      successSavingResponse = false;
      print(error);
    }
  }

  saveCouplesSurveyResponses(token, listOfResponses) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    List arrayOfResponsesObjects = []; // [{"questionId" : "response"}]

    /// prepare payload and store it in arrayOfResponsesObjects to send it to DB
    for (CoupleSurveyResponse surveyResponse in listOfResponses) {
      if (surveyResponse.questionType == "radio") {
        arrayOfResponsesObjects.add({
          "question_id": surveyResponse.questionId,
          "response": surveyResponse.response
        });
      } else if (surveyResponse.questionType == "checkbox") {
        for (String option in surveyResponse.checkboxes!) {
          arrayOfResponsesObjects.add(
              {"question_id": surveyResponse.questionId, "response": option});
        }
      } else if (surveyResponse.questionType == "text") {
        arrayOfResponsesObjects.add({
          "question_id": surveyResponse.questionId,
          "response": surveyResponse.response
        });
      }
    }

    try {
      final response = await dio.post("$baseUrl/save_responses",
          data: jsonEncode(arrayOfResponsesObjects),
          options: Options(headers: {"authorization": "Bearer $token"}));

      successSavingCouplesSurveyResponse = true;
      notifyListeners();
    } on DioException catch (error) {
      print("In provider, error: $error");
    }
  }
}
