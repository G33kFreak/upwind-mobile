import 'package:flutter_test/flutter_test.dart';
import 'package:upwind/src/config/routes/main.dart';

void main() {
  test('Absolute path to main is /main', () {
    expect(MainRouteHelper.path, equals('/main'));
    expect(const MainRouteHelper().absolutePath, equals('/main'));
  });
}
