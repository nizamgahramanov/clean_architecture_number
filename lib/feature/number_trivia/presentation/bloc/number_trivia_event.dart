part of 'bloc.dart';

abstract class NumberTriviaEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class InitialNumberTriviaEvent extends NumberTriviaEvent{}