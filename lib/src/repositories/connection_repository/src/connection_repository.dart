import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:upwind/src/repositories/connection_repository/connection_repository.dart';

class ConnectionRepository implements IConnectionRepository {
  @override
  Stream<ConnectivityResult> getConnectionStream() {
    return Connectivity().onConnectivityChanged;
  }
}
