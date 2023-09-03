part of 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String INVALID_INPUT_FAILURE_MESSAGE = "Invalid Input";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc({required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter})
      : super(Empty()) {
    on<GetTriviaForConcreteNumber>(getConcreteNumberEvent);
    on<GetTriviaForRandomNumber>(getRandomNumberEvent);
  }

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  void getConcreteNumberEvent(
      GetTriviaForConcreteNumber event, emit) async {
    final inputEither =
    inputConverter.stringToUnsignedInteger(event.numberString);
    inputEither
        .fold((failure) => Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE),
            (integer) async {
          emit(Loading());

          final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: integer),
          );
          _eitherLoadedOrErrorState(failureOrTrivia);
        });
  }

  void getRandomNumberEvent(
      GetTriviaForRandomNumber event, emit) async {
    final failureOrTrivia = await getRandomNumberTrivia(
      NoParams(),
    );
    _eitherLoadedOrErrorState(failureOrTrivia);
  }

  _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia ){
    failureOrTrivia.fold(
          (failure) =>
          Error(
              errorMessage: _mapFailureToMessage(failure)),
          (trivia) =>
          emit(
            Loaded(trivia: trivia),
          ),
    );
  }
  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CacheFailure();
      default:
        return "Unexpected Result";
    }
  }
}


