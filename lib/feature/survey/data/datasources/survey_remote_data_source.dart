import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/survey_model.dart';
import 'package:http/http.dart' as http;

abstract class SurveyRemoteDataSource {
  Future<SurveyModel> getSurvey();
}

class SurveyRemoteDataSourceImpl implements SurveyRemoteDataSource {
  final http.Client client;

  SurveyRemoteDataSourceImpl({required this.client});

  @override
  Future<SurveyModel> getSurvey() async {
/*    final response = await client.get(
      'http://numbersapi.com/random',
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return SurveyModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }*/
    return SurveyModel.fromJson({
      "title": "TEST SURRVEY",
      "url":
          "https://docs.google.com/forms/d/e/1FAIpQLSfaERsD8hDN9Iirk8WUXbI9d1P0m8Bb48FyYWFIBxo5uEj8Jg/viewform?usp=sf_link"
    });
  }
}
