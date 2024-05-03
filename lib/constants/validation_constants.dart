const String emailValidationRegEx =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

String? passwordValidation(String? p0) {
  if (p0 == null || p0.isEmpty) return 'Password is mandatory';
  if (p0.length < 6) {
    return "Password must be at least 6 characters long";
  }
  return null;
}

String? confirmPasswordValidation(String? p0, String? p1) {
  if (p0 == null || p0.isEmpty) return 'Confirm password is mandatory';
  if (p0 != p1) {
    return "You need to enter the same password";
  }
  return null;
}

String? emailValidation(String? p0) {
  if (p0 == null || p0.isEmpty) return 'Email is mandatory';
  if (!RegExp(emailValidationRegEx).hasMatch(p0)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? userNameValidation(String? p0) {
  if (p0 == null || p0.isEmpty) return 'Username is mandatory';
  if (p0.length<6) {
    return 'User name need to contain 6 or more';
  }
  return null;
}
