import 'package:flutter_test/flutter_test.dart';
import 'package:upwind/src/modules/login_view/utils/login_utils.dart';

void main() {
  test('Login email validator works properly', () {
    expect(LoginUtils.validateEmail('test'), equals(false));
    expect(LoginUtils.validateEmail('test.te'), equals(false));
    expect(LoginUtils.validateEmail('test.te@t'), equals(false));
    expect(LoginUtils.validateEmail('test.te@t.com'), equals(true));
    expect(LoginUtils.validateEmail('test@f.com'), equals(true));
  });

  test('Login input validator works properly', () {
    expect(LoginUtils.validateInputs('test', ''), equals(false));
    expect(LoginUtils.validateInputs('test@test.com', ''), equals(false));
    expect(LoginUtils.validateInputs('test', null), equals(false));
    expect(LoginUtils.validateInputs('test@test.com', null), equals(false));
    expect(LoginUtils.validateInputs('test@test.com', 'test'), equals(true));
  });
}
