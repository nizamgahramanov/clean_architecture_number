import 'package:clean_architecture_number/feature/survey/data/datasources/survey_remote_data_source.dart';
import 'package:clean_architecture_number/feature/survey/data/repositories/survey_repository_impl.dart';
import 'package:clean_architecture_number/feature/survey/domain/repositories/survey_repository.dart';
import 'package:clean_architecture_number/feature/survey/domain/usercases/get_survey.dart';
import 'package:clean_architecture_number/feature/survey/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
final sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory(() => SurveyBloc(getSurveyUseCase: sl()));
  sl.registerLazySingleton(() => GetSurvey(sl()));
  sl.registerLazySingleton<SurveyRepository>(
    () => SurveyRepositoryImpl(
      surveyRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<SurveyRemoteDataSource>(
    () => SurveyRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton(() => http.Client());
}
