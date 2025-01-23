class EmailValidator {
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static List<EmailValidatorError> validateEmail(String email) {
    List<EmailValidatorError> errors = [];

    if (!_emailRegex.hasMatch(email)) {
      errors.add(EmailValidatorError.invalidFormat);
    }

    return errors;
  }
}

enum EmailValidatorError {
  invalidFormat,
}
