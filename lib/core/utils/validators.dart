import '../constants/app_constants.dart';

class Validators {
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null 
          ? '$fieldName is required' 
          : 'This field is required';
    }
    return null;
  }

  static String? requiredSwahili(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null 
          ? '$fieldName inahitajika' 
          : 'Tafadhali jaza uga huu';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    
    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must not exceed ${AppConstants.maxPasswordLength} characters';
    }
    
    return null;
  }

  static String? passwordSwahili(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nenosiri linahitajika';
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return 'Nenosiri lazima liwe na angalau herufi ${AppConstants.minPasswordLength}';
    }
    
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove spaces and check for valid phone number
    final cleanPhone = value.replaceAll(RegExp(r'\s+'), '');
    
    // Support Tanzanian phone numbers and international format
    final phoneRegex = RegExp(
      r'^(\+255|0)[1-9][0-9]{8}$',
    );
    
    if (!phoneRegex.hasMatch(cleanPhone)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  static String? phoneSwahili(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Namba ya simu inahitajika';
    }
    
    final cleanPhone = value.replaceAll(RegExp(r'\s+'), '');
    final phoneRegex = RegExp(r'^(\+255|0)[1-9][0-9]{8}$');
    
    if (!phoneRegex.hasMatch(cleanPhone)) {
      return 'Tafadhali ingiza namba ya simu sahihi';
    }
    
    return null;
  }

  static String? name(String? value, {String? fieldName, int minLength = AppConstants.minNameLength, int maxLength = AppConstants.maxNameLength}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null 
          ? '$fieldName is required' 
          : 'Name is required';
    }
    
    if (value.length < minLength) {
      return 'Must be at least $minLength characters';
    }
    
    if (value.length > maxLength) {
      return 'Must not exceed $maxLength characters';
    }
    
    // Check for valid characters (letters, spaces, and common name characters)
    final validNameRegex = RegExp(r"^[a-zA-Z\s'-]+$");
    if (!validNameRegex.hasMatch(value)) {
      return 'Please enter a valid name';
    }
    
    return null;
  }

  static String? productName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name is required';
    }
    
    if (value.length < AppConstants.minProductNameLength) {
      return 'Product name must be at least ${AppConstants.minProductNameLength} characters';
    }
    
    if (value.length > AppConstants.maxProductNameLength) {
      return 'Product name must not exceed ${AppConstants.maxProductNameLength} characters';
    }
    
    return null;
  }

  static String? amount(String? value, {double? min, double? max}) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    
    final parsedValue = double.tryParse(value.replaceAll(',', ''));
    
    if (parsedValue == null) {
      return 'Please enter a valid amount';
    }
    
    if (parsedValue < 0) {
      return 'Amount cannot be negative';
    }
    
    if (min != null && parsedValue < min) {
      return 'Amount must be at least $min';
    }
    
    if (max != null && parsedValue > max) {
      return 'Amount must not exceed $max';
    }
    
    return null;
  }

  static String? quantity(String? value, {int? min, int? max}) {
    if (value == null || value.trim().isEmpty) {
      return 'Quantity is required';
    }
    
    final parsedValue = int.tryParse(value);
    
    if (parsedValue == null) {
      return 'Please enter a valid number';
    }
    
    if (parsedValue < 0) {
      return 'Quantity cannot be negative';
    }
    
    if (min != null && parsedValue < min) {
      return 'Quantity must be at least $min';
    }
    
    if (max != null && parsedValue > max) {
      return 'Quantity must not exceed $max';
    }
    
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // URL is optional
    }
    
    final urlRegex = RegExp(
      r'^(https?:\/\/)?' 
      r'((([a-zA-Z\d]([a-zA-Z\d-]*[a-zA-Z\d])*)\.)+[a-zA-Z]{2,}|' 
      r'((\d{1,3}\.){3}\d{1,3}))' 
      r'(\:\d+)?(\/[-a-zA-Z\d%_.~+]*)*' 
      r'(\?[;&a-zA-Z\d%_.~+=-]*)?' 
      r'(\#[-a-zA-Z\d_]*)?$',
    );
    
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  static String? businessName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business name is required';
    }
    
    if (value.length < 2) {
      return 'Business name must be at least 2 characters';
    }
    
    if (value.length > 200) {
      return 'Business name must not exceed 200 characters';
    }
    
    return null;
  }

  static String? businessNameSwahili(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Jina la biashara linahitajika';
    }
    
    if (value.length < 2) {
      return 'Jina la biashara lazima liwe na angalau herufi 2';
    }
    
    return null;
  }

  static String? taxNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Tax number is optional
    }
    
    final taxRegex = RegExp(r'^[A-Z0-9-]+$');
    
    if (!taxRegex.hasMatch(value.toUpperCase())) {
      return 'Please enter a valid tax number';
    }
    
    return null;
  }
}
