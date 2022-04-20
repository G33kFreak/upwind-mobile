import 'package:upwind/src/config/routes/routes.dart';
import 'package:upwind/src/modules/welcome_view/view/welcome_view.dart';
export 'package:upwind/src/modules/welcome_view/view/welcome_view.dart';

class WelcomeRouteHelper extends ParameterlessRouteHelper {
  static const path = '/';
  static const widget = WelcomeView;
  const WelcomeRouteHelper() : super(path: path);
}
