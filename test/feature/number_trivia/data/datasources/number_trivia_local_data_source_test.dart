import 'dart:convert';

import 'package:clean_architecture_number/core/error/exceptions.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSourceImpl;
  MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });
  group("getLastNuumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture("trivia_cached.json")));
    test(
        "should return Number Trivia from SharedPreferences when there is one in cache",
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("trivia_cached.json"));
      final result = await dataSourceImpl.getLastNumberTrivia();
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });
    test("should throw CacheException when there is not a cache value",
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final call = dataSourceImpl.getLastNumberTrivia;
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
  group("cacheNumberTrivia", () {
    var tNumberTriviaModel = NumberTriviaModel(text: "TEST Trivia", number: 1);
    test("should call sharedPreferences to cache the data", () async {
      dataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString));
    });
  });
}
