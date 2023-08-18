import 'package:clean_architecture_number/feature/survey/domain/entities/survey.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class SurveyRepository{
  Future<Either<Failure, Survey>> getSurvey();
}