
class FormValidation {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

 static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    return null;
  }

static  String? validatePin(String? value) {
  if (value == null || value.isEmpty) {
    return 'PIN cannot be empty';
  }
  if (value.length != 6) {
    return 'PIN must be exactly 6 digits';
  }
  if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    return 'PIN must contain only numbers';
  }
  return null; 
}
}