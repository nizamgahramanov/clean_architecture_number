part of 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String INVALID_INPUT_FAILURE_MESSAGE = "Invalid Inputt";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(Empty()) {
    on<GetTriviaForConcreteNumber>(getConcreteNumberEvent);
    on<GetTriviaForRandomNumber>(getRandomNumberEvent);
  }
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  Either<Failure, int> getConcreteNumberEvent(GetTriviaForConcreteNumber event, emit) {
    inputConverter.
    return inputConverter.stringToUnsignedInteger(event.numberString);
  }
  Future<void> getRandomNumberEvent(NumberTriviaEvent event, emit) {
    return Future.value();
  }
}
