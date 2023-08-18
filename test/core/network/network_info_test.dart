import 'package:clean_architecture_number/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {
  void main() {
    late MockInternetConnectionChecker mockInternetConnectionChecker;

    late NetworkInfoImpl networkInfoImpl;

    setUp(() {
      mockInternetConnectionChecker = MockInternetConnectionChecker();
      networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
    });
    group("isConnected", () {
      test(
          "should forward the call to InternetConnectionChecker.hasConnectiion",
          () async {
            final tHasConnectionChecker = Future.value(true);

        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_)  => tHasConnectionChecker);
        final result = networkInfoImpl.isConnected;
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, tHasConnectionChecker);
      });
    });
  }
}
