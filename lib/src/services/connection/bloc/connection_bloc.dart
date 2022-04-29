import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:upwind/src/repositories/connection_repository/connection_repository.dart';

part 'connection_event.dart';
part 'connection_state.dart';
part 'connection_bloc.g.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final ConnectionRepository connectionRepository;

  late StreamSubscription<ConnectivityResult> _connectionStatusSubscription;

  ConnectionBloc({required this.connectionRepository})
      : super(const ConnectionState.unknown()) {
    on<ConnectionStatusChanged>(_onStatusChanged);
    _setConnectionSubscription();
  }

  void _setConnectionSubscription() {
    _connectionStatusSubscription =
        connectionRepository.getConnectionStream().listen(
              (status) => add(
                ConnectionStatusChanged(status),
              ),
            );
  }

  void _onStatusChanged(
    ConnectionStatusChanged event,
    Emitter<ConnectionState> emit,
  ) {
    switch (event.status) {
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        emit(const ConnectionState.connected());
        break;
      case ConnectivityResult.none:
        emit(const ConnectionState.disconnected());
        break;
    }
  }

  @override
  Future<void> close() {
    _connectionStatusSubscription.cancel();
    return super.close();
  }
}
