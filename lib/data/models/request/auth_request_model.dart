import 'dart:convert';

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  String toJson() => jsonEncode({
        "email": email,
        "password": password,
      });
}

class ChangePasswordRequestModel {
  final String currentPassword;
  final String password;
  final String passwordConfirmation;

  ChangePasswordRequestModel({
    required this.currentPassword,
    required this.password,
    required this.passwordConfirmation,
  });

  String toJson() => jsonEncode({
        "current_password": currentPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
      });
}
