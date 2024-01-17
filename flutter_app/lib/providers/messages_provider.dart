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
        text: "Hello, how can I help you?",
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
      print("In getConversation: $error");
    }
  }

  Future sendMessage(Message userMessage) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      final response = await _dio.post(
        '${Requests.baseUrl}/save_user_prompt',
        data: {"prompt": userMessage.text},
        options: Options(headers: {"authorization": "Bearer $token"}),
      );
      conversation.add(userMessage);
      notifyListeners();
      if (response.data["status"] == "success") {
        conversation.add(Message(
            text: response.data["ai_response"],
            date: DateTime.now(),
            isSentByMe: false));
      }
    } on DioException catch (error) {
      print("In sendMessage() error: $error");
      somethingWentWrong = "Something went worng, please try sending again";
      notifyListeners();
    }
  }
}
