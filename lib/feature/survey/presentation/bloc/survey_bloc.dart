part of 'bloc.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final GetSurvey getSurveyUseCase;

  SurveyBloc({required this.getSurveyUseCase}) : super(Empty()) {
    on<GetSurveyData>((event, emit) async {
      try {
        emit(Loading());
        final survey = await getSurveyUseCase.call(NoParams());

        print("KLKLKKK");
        print(survey.toString());
        survey.fold(
              (failure) => throw UnimplementedError(),
              (survey) => emit(Loaded(survey: survey)),
        );
      } on Error {
        emit(
            Error(message: 'LLLAD')
        );
      }
    });
  }

  @override
  SurveyState get initialState => Empty();
}
/*
Future<void> _getSurvey(SurveyEvent event, emit) async{
  try {
    emit(Loading());

  } on Error{

  }

}*/
