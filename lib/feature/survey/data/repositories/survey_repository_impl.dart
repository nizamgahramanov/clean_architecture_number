import 'package:clean_architecture_number/core/error/failures.dart';
import 'package:clean_architecture_number/feature/survey/domain/entities/survey.dart';
import 'package:clean_architecture_number/feature/survey/domain/repositories/survey_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/survey_remote_data_source.dart';

class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyRemoteDataSource surveyRemoteDataSource;
  SurveyRepositoryImpl({
    required this.surveyRemoteDataSource,
  });
  @override
  Future<Either<Failure, Survey>> getSurvey() async {
    try {
      final survey = await surveyRemoteDataSource.getSurvey();
      return Right(survey);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
