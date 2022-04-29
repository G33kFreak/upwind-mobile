import 'package:upwind/src/config/routes/routes.dart';
import 'package:upwind/src/modules/no_connection/view/no_connection_view.dart';
export 'package:upwind/src/modules/no_connection/view/no_connection_view.dart';

class NoConnectionRouteHelper extends ParameterlessRouteHelper {
  static const path = '/no-connection';
  static const widget = NoConnectionView;
  const NoConnectionRouteHelper() : super(path: path);
}
