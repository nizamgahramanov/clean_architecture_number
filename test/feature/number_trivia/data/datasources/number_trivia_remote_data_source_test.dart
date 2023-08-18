import 'dart:convert';

import 'package:clean_architecture_number/core/error/exceptions.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });
  void setUpMockHttpClientSuccess(){
    when(mockHttpClient.get(any, headers: anyNamed('header')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }
  void setUpMockHttpClientFailure(){
    when(mockHttpClient.get(any, headers: anyNamed('header')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 400));
  }
  group("getConcreteNumberTrivia", () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode('trivia.json'));

    test('''should perform a GET request on a URL number 
    being the endpoint and with application/json header''', () async {

      setUpMockHttpClientSuccess();
      dataSourceImpl.getConcreteNumberTrivia(tNumber);
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/$tNumber'),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });
    test("should return NumberTrivia when response code is 200 (success)",
        () async {
          setUpMockHttpClientSuccess();
      final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTriviaModel));
    });
    test(
        "should throw a ServerException when the response code is 404 or other",
        () async {
          setUpMockHttpClientFailure();
      final call = dataSourceImpl.getConcreteNumberTrivia;
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group("getRandomNumberTrivia", () {
    final tNumberTriviaModel =
    NumberTriviaModel.fromJson(json.decode('trivia.json'));

    test('''should perform a GET request on a URL number 
    being the endpoint and with application/json header''', () async {

      setUpMockHttpClientSuccess();
      dataSourceImpl.getRandomNumberTrivia();
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/random'),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });
    test("should return NumberTrivia when response code is 200 (success)",
            () async {
          setUpMockHttpClientSuccess();
          final result = await dataSourceImpl.getRandomNumberTrivia();

          expect(result, equals(tNumberTriviaModel));
        });
    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          setUpMockHttpClientFailure();
          final call = dataSourceImpl.getRandomNumberTrivia;
          expect(() => call(), throwsA(TypeMatcher<ServerException>()));
        });
  });
}
