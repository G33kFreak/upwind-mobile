import 'package:upwind/src/config/routes/routes.dart';
import 'package:upwind/src/modules/main_view/view/main_view.dart';
export 'package:upwind/src/modules/main_view/view/main_view.dart';

class MainRouteHelper extends ParameterlessRouteHelper {
  static const path = '/main';
  static const widget = MainView;
  const MainRouteHelper() : super(path: path);
}
