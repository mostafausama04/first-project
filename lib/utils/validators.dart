class AppValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone Number is required';
    }
    if (value.trim().length != 11) {
      return 'Number must be 11 digits';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'not valid Email format';
    }
    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'this field is Required';
    }
    return null;
  }
}