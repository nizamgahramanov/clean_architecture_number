import 'package:clean_architecture_number/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });
  group("String to UnsignedInt", () {
    test(
        "should return an integer when the string represents an unsigned integer",
        () async {
      final str = "123";
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Right(123));
    });
    test("should return Failure when the string is not an integer", () async {
      final str = "abc";
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
    test("should return Failure when the string is negative integer", () async {
      final str = "-123";
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
