part of 'bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber({required this.numberString}):super();
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
