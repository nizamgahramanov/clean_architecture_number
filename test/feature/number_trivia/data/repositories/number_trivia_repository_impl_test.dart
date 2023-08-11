import 'package:clean_architecture_number/core/error/exceptions.dart';
import 'package:clean_architecture_number/core/error/failures.dart';
import 'package:clean_architecture_number/core/network/network_info.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_number/feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';


/*class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}*/

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

// class MockNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([NetworkInfo])
// @GenerateMocks([NumberTriviaRemoteDataSource])
@GenerateMocks([
  MockRemoteDataSource
], customMocks: [
  MockSpec<MockRemoteDataSource>(
      as: #MockRemoteDataSourceForTest,
      returnNullOnMissingStub: true),
])
void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    print("object");
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group("getConcreteNumberTrivia", () {
    const int tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(
      text: "test trivia",
      number: tNumber,
    );
    final NumberTrivia numberTrivia = tNumberTriviaModel;
    test("should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repository.getConcreteNumberTrivia(tNumber);
      when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);

      verify(mockNetworkInfo.isConnected);
    });
   group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          "should return remote data when call to remote data source is successful",
          () async {

        when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getConcreteNumberTrivia(tNumber);

        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(numberTrivia)));
      });
      test("should cache data when call to remote data source is success",
          () async {
        when(mockRemoteDataSource.getConcreteNumberTrivia(3))
            .thenAnswer((_) async => tNumberTriviaModel);

        await repository.getConcreteNumberTrivia(tNumber);

        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
    });
    test("should return server failure data when call to remote data source is unsuccessful",
            () async {
          when(mockRemoteDataSource.getConcreteNumberTrivia(3))
              .thenThrow(ServerException());

          final result = await repository.getConcreteNumberTrivia(tNumber);

          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result,equals(Left(ServerFailure())));

        });
  });

}
