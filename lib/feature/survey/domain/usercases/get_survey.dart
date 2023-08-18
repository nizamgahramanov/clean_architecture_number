import 'package:clean_architecture_number/feature/survey/domain/repositories/survey_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/survey.dart';

class GetSurvey extends UseCase<Survey,NoParams> {
  final SurveyRepository repository;
  GetSurvey(this.repository);
  Future<Either<Failure, Survey>> call(
      NoParams noParams,
      ) async {
    return await repository.getSurvey();
  }
}