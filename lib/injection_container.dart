import 'package:clean_architecture_number/core/network/network_info.dart';
import 'package:clean_architecture_number/core/util/input_converter.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_number/feature/number_trivia/presentation/bloc/bloc.dart';
import 'package:clean_architecture_number/feature/survey/data/datasources/survey_remote_data_source.dart';
import 'package:clean_architecture_number/feature/survey/data/repositories/survey_repository_impl.dart';
import 'package:clean_architecture_number/feature/survey/domain/repositories/survey_repository.dart';
import 'package:clean_architecture_number/feature/survey/domain/usercases/get_survey.dart';
import 'package:clean_architecture_number/feature/survey/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // registering survey bloc
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

  //registering number trivia bloc

  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(() => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton(() => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
