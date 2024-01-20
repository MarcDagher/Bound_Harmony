import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/models/place.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionsProvider extends ChangeNotifier {
  final _dio = Dio();
  final String _baseUrl = Requests.baseUrl;

  String? status;
  String? failedMessage;
  List bondingActivities = [];
  List dates = [];

  Future getSuggestions(String type) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      final response = await _dio.get("$_baseUrl/get_suggestions",
          data: {"place_type": type},
          options: Options(headers: {"authorization": "Bearer $token"}));

      if (response.data["status"] == "failed") {
        status = "failed";
        failedMessage = response.data["message"];
      } else if (response.data["status"] == "success") {
        status = "success";
        if (type == "bonding") {
          for (Map<String, dynamic> response in response.data['places']) {
            bondingActivities.add(Place(
                name: response['name'],
                businessStatus: response['business_status'],
                openingHours: response['opening_hours'],
                placeId: response['place_id'],
                plusCode: response['plus_code'],
                photos: response['photos'],
                types: response['types'],
                rating: response['rating'],
                userRatingsTotal: response['user_ratings_total'],
                vicinity: response['vicinity'],
                queryType: response['query_type']));
          }
          notifyListeners();
        } else if (type == "date") {
          for (Map<String, dynamic> response in response.data['places']) {
            dates.add(Place(
                name: response['name'],
                businessStatus: response['business_status'],
                openingHours: response['opening_hours'],
                placeId: response['place_id'],
                plusCode: response['plus_code'],
                photos: response['photos'],
                types: response['types'],
                rating: response['rating'],
                userRatingsTotal: response['user_ratings_total'],
                vicinity: response['vicinity'],
                queryType: response['query_type']));
          }
          notifyListeners();
        }

        // print(places[places.length - 1].name);
      }
    } on DioException catch (error) {
      print("In suggestions provider error: ${error}");
    }
  }
}
