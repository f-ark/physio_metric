import 'package:flutter/services.dart';

class AuthValidators {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+');
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) => password.length >= 8;

  static String? emailErrorText(String? email) {
    if (email == null || email.isEmpty) return 'E-posta boş olamaz';
    if (!isValidEmail(email)) return 'Geçersiz e-posta';
    return null;
  }

  static String? passwordErrorText(String? password) {
    if (password == null || password.isEmpty) return 'Şifre boş olamaz';
    if (!isValidPassword(password)) return 'Şifre en az 8 karakter olmalı';
    return null;
  }
}

/// Sadece geçerli e-posta karakterlerine izin veren input formatter
class EmailEditingRegexValidator extends TextInputFormatter {
  final _emailRegex = RegExp(r'[a-zA-Z0-9@._\-]');
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filtered = newValue.text.split('').where(_emailRegex.hasMatch).join();
    return newValue.copyWith(text: filtered);
  }
}
