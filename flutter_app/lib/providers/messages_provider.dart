import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/models/message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesProvider extends ChangeNotifier {
  final _dio = Dio();
  String somethingWentWrong = "";

  List<Message> conversation = [
    Message(
        text:
            "Talk to me about anything. I'm here to listen and i'm here to guide you!",
        date: DateTime.now(),
        isSentByMe: false)
  ];

  // fetch get_conversation -- NOT TESTED -
  Future getConversation() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      final response = await _dio.get(
        '${Requests.baseUrl}/get_conversation',
        options: Options(headers: {"authorization": "Bearer $token"}),
      );
      if (response.data['status'] == "success") {
        for (Map message in response.data["conversation"]) {
          // add users message
          conversation.add(Message(
              text: message["user_prompt"],
              date: DateTime.parse(message['user_prompt_date']),
              isSentByMe: true));
          // add ai response
          conversation.add(Message(
              text: message['ai_response'],
              date: DateTime.parse(message['ai_response_date']),
              isSentByMe: false));
        }
        notifyListeners();
      }
    } on DioException catch (error) {
      // print("In getConversation: $error");
    }
  }

  // save message in DB and return AI response
  Future sendMessage(Message userMessage) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      conversation.add(userMessage);
      notifyListeners();
      final response = await _dio.post(
        '${Requests.baseUrl}/save_user_prompt',
        data: {"prompt": userMessage.text},
        options: Options(headers: {"authorization": "Bearer $token"}),
      );

      if (response.data["status"] == "success") {
        somethingWentWrong = "";
        conversation.add(Message(
            text: response.data["ai_response"],
            date: DateTime.now(),
            isSentByMe: false));
        notifyListeners();
      } else if (response.data["status"] == "failed") {
        somethingWentWrong = "Something went wrong, please try sending again";
        conversation.remove(userMessage);
        notifyListeners();
      }
    } on DioException catch (error) {
      conversation.remove(userMessage);
      somethingWentWrong = "Something went wrong, please try sending again";
      notifyListeners();
    }
  }

  // Clear all variables on logout
  void clearMessagesProviderVariables() {
    somethingWentWrong = "";
    conversation = [
      Message(
          text:
              "Talk to me about anything. I'm here to listen and i'm here to guide you!",
          date: DateTime.now(),
          isSentByMe: false)
    ];
  }
}
