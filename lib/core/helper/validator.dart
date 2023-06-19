class Validator {
  static String? validateEmail(String value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);

    if (value.isEmpty) {
      return 'Enter email';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.length < 8) {
      return 'Password must be 8 character';
    } else {
      return null;
    }
  }
}
