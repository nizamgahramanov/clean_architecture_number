part of 'bloc.dart';

abstract class SurveyEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetSurveyData extends SurveyEvent{}