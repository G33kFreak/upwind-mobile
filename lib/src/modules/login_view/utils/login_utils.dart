class LoginUtils {
  static const emailRegexString =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static bool validateEmail(String? email) {
    return RegExp(emailRegexString).hasMatch(email ?? '');
  }

  static bool validateInputs(String? email, String? password) {
    return validateEmail(email) && (password?.isNotEmpty ?? false);
  }
}
