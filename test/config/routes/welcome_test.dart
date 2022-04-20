import 'package:flutter_test/flutter_test.dart';
import 'package:upwind/src/config/routes/welcome.dart';

void main() {
  test('Absolute path to welcome is /', () {
    expect(WelcomeRouteHelper.path, equals('/'));
    expect(const WelcomeRouteHelper().absolutePath, equals('/'));
  });
}
