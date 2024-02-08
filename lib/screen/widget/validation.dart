class Validation {
  static amountValidation(String value) {
    if (value.isEmpty ||
        !RegExp(r"(^(?:[+0]9)?[0-9]{0,12}$)").hasMatch(value)) {
      return 'Please add your amount';
    } else {
      return null;
    }
  }

  static isEmpty(String value) {
    if (value.isEmpty) {
      return 'Please add your comment';
    } else {
      return null;
    }
  }
}
