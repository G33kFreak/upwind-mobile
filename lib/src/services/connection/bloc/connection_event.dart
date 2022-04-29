part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class ConnectionStatusChanged extends ConnectionEvent
    with _$ConnectionStatusChangedAutoequalMixin {
  final ConnectivityResult status;

  const ConnectionStatusChanged(this.status);
}
