import 'dart:convert';

import 'auth_response_model.dart';

class UserResponseModel {
  final AuthUserModel user;

  UserResponseModel({
    required this.user,
  });

  factory UserResponseModel.fromJson(String str) =>
      UserResponseModel.fromMap(jsonDecode(str));

  factory UserResponseModel.fromMap(Map<String, dynamic> json) {
    return UserResponseModel(
      user: AuthUserModel.fromMap(json),
    );
  }
}

class MessageResponseModel {
  final String message;

  MessageResponseModel({
    required this.message,
  });

  factory MessageResponseModel.fromJson(String str) =>
      MessageResponseModel.fromMap(jsonDecode(str));

  factory MessageResponseModel.fromMap(Map<String, dynamic> json) {
    return MessageResponseModel(
      message: (json['message'] ?? '').toString(),
    );
  }
}
