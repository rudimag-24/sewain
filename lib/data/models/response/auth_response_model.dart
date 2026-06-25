import 'dart:convert';

class AuthResponseModel {
  final String message;
  final String token;
  final AuthUserModel user;

  AuthResponseModel({
    this.message = '',
    required this.token,
    required this.user,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(jsonDecode(str));

  String toRawJson() => jsonEncode(toMap());

  factory AuthResponseModel.fromRawJson(String str) =>
      AuthResponseModel.fromMap(jsonDecode(str));

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) {
    return AuthResponseModel(
      message: (json['message'] ?? '').toString(),
      token: (json['token'] ?? '').toString(),
      user: AuthUserModel.fromMap(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toMap() => {
        "message": message,
        "token": token,
        "user": user.toMap(),
      };
}

class AuthUserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? status;

  AuthUserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.status,
  });

  factory AuthUserModel.fromMap(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as int?,
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      role: json['role']?.toString(),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "status": status,
      };

  String get safeName => (name ?? '').isNotEmpty ? name! : 'Tanpa Nama';
  String get safeEmail => (email ?? '').isNotEmpty ? email! : '-';
  String get safeRole => (role ?? '').isNotEmpty ? role! : '-';
}
