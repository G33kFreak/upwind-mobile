import 'package:connectivity_plus/connectivity_plus.dart';

abstract class IConnectionRepository {
  Stream<ConnectivityResult> getConnectionStream();
}
