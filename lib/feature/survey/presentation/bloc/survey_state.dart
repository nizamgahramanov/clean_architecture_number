part of 'bloc.dart';

abstract class SurveyState extends Equatable{
  @override
  List<Object?> get props => [];
}

class Empty extends SurveyState {}

class Loading extends SurveyState {}


class Loaded extends SurveyState {
  final Survey survey;

  Loaded({required this.survey}) : super();
}

class Error extends SurveyState {
  final String message;

  Error({required this.message}) : super();
}
