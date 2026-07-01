import 'dart:convert';

class OwnerTenantCreateRequestModel {
  final String name;
  final String email;
  final String? phone;
  final String password;

  OwnerTenantCreateRequestModel({
    required this.name,
    required this.email,
    this.phone,
    required this.password,
  });

  String toJson() => jsonEncode({
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
  });
}

class OwnerTenantUpdateRequestModel {
  final String? name;
  final String? phone;

  OwnerTenantUpdateRequestModel({this.name, this.phone});

  String toJson() => jsonEncode({
    if (name != null) 'name': name,
    if (phone != null) 'phone': phone,
  });
}

class OwnerTenantResetPasswordRequestModel {
  final String password;
  final String passwordConfirmation;

  OwnerTenantResetPasswordRequestModel({
    required this.password,
    required this.passwordConfirmation,
  });

  String toJson() => jsonEncode({
    'password': password,
    'password_confirmation': passwordConfirmation,
  });
}
