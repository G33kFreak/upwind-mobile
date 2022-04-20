import 'package:upwind/src/config/routes/routes.dart';
import 'package:upwind/src/modules/login_view/view/login_view.dart';
export 'package:upwind/src/modules/login_view/view/login_view.dart';

class LoginRouteHelper extends ParameterlessRouteHelper {
  static const path = '/login';
  static const widget = LoginView;
  const LoginRouteHelper() : super(path: path);
}
