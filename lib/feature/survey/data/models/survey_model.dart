import 'package:clean_architecture_number/feature/survey/domain/entities/survey.dart';

class SurveyModel extends Survey{
  SurveyModel({required super.title, required super.url});

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      title: json['title'],
      url: json['url'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title':title,
      'url':url,
    };
  }

}