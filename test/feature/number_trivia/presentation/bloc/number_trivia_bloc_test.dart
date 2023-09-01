import 'package:clean_architecture_number/core/util/input_converter.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_number/feature/number_trivia/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;
  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );

    test("initial state should be empty", () {
      expect(bloc, equals(Empty()));
    });
    group("GetTriviaForConcreteNumber", () {
      final tNumberString = '1';
      final tNumberParsed = 1;
      final tNumberTrivia = NumberTrivia(text: "TestTrivia", number: 1);
      test("should call input converter to validate and convert string to unsigned integer", () {
        when(mockInputConverter.stringToUnsignedInteger(any)).thenReturn(Right(tNumberParsed));

        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      });
    });
  });
}
