part of 'connection_bloc.dart';

enum ConnectionStatus { connected, disconnected, unknown }

@autoequalMixin
class ConnectionState extends Equatable with _$ConnectionStateAutoequalMixin {
  final ConnectionStatus status;

  const ConnectionState._({this.status = ConnectionStatus.unknown});

  const ConnectionState.unknown() : this._();

  const ConnectionState.disconnected()
      : this._(status: ConnectionStatus.disconnected);

  const ConnectionState.connected()
      : this._(status: ConnectionStatus.connected);
}
