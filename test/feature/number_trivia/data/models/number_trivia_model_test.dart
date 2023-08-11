import 'dart:convert';

import 'package:clean_architecture_number/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader/fixture_reader.dart';

void main() {
  final tNumberTrivialModel = NumberTriviaModel(number: 1, text: "TEST TEXT");
  test('should be a subclass of NumberTrivia entity', () async {
    expect(tNumberTrivialModel, isA<NumberTrivia>());
  });
  group('fromJson', () {
    test(
      'should return valid model then the JSON number is an integer',
      () async {
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia.json'));
        final result = NumberTriviaModel.fromJson(jsonMap);
        expect(result, tNumberTrivialModel);
      },
    );
    test(
      'should return valid model then the JSON number is an double',
      () async {
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('trivia_double.json'));
        final result = NumberTriviaModel.fromJson(jsonMap);
        expect(result, tNumberTrivialModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return valid JSON map containing proper data',
      () async {
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia.json'));
        final result = NumberTriviaModel.fromJson(jsonMap);
        expect(result, tNumberTrivialModel);
      },
    );
    test(
      'should return valid model then the JSON number is an double',
      () async {
        final result = tNumberTrivialModel.toJson();
        final expectedMap = {
          "text": "TEST TEXT",
          "number": 1,
        };
        expect(result, expectedMap);
      },
    );
  });
}
