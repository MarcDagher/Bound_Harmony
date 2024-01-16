import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/models/message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesProvider extends ChangeNotifier {
  final _dio = Dio();

  List<Message> conversation = [];

  getHistoryOfMessages() {}

  sendMessage(Message message) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      final response = await _dio.post(
        '${Requests.baseUrl}/save_user_prompt',
        data: message.text,
        options: Options(headers: {"authorization": "Bearer $token"}),
      );
    } on DioException catch (error) {
      print("In sendMessage() error: $error");
    }
  }
}
