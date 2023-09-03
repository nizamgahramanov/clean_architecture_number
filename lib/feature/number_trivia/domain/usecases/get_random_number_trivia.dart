import 'package:clean_architecture_number/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia(this.repository);
  Future<Either<Failure, NumberTrivia>> call(
      NoParams noParams,
  ) async {
    return await repository.getRandomNumberTrivia();
  }
}

