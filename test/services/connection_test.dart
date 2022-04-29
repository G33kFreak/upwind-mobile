import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:upwind/src/repositories/connection_repository/connection_repository.dart';
import 'package:upwind/src/services/connection/bloc/connection_bloc.dart';

import 'connection_test.mocks.dart';

@GenerateMocks([ConnectionRepository])
void main() {
  final connectionRepository = MockConnectionRepository();

  blocTest<ConnectionBloc, ConnectionState>(
    'ConnectionService changing connection state ok',
    setUp: () {
      when(connectionRepository.getConnectionStream())
          .thenAnswer((_) => Stream.fromIterable([
                ConnectivityResult.wifi,
                ConnectivityResult.mobile,
                ConnectivityResult.none,
                ConnectivityResult.wifi,
              ]));
    },
    build: () => ConnectionBloc(connectionRepository: connectionRepository),
    expect: () => const <ConnectionState>[
      ConnectionState.connected(),
      ConnectionState.disconnected(),
      ConnectionState.connected(),
    ],
  );
}
