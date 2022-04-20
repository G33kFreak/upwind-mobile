import 'package:flutter_test/flutter_test.dart';
import 'package:upwind/src/config/routes/login.dart';

void main() {
  test('Absolute path to login is /login', () {
    expect(LoginRouteHelper.path, equals('/login'));
    expect(const LoginRouteHelper().absolutePath, equals('/login'));
  });
}
