import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/auth_request_model.dart';
import 'package:sewain/data/models/response/auth_response_model.dart';
import 'package:sewain/data/models/response/user_response_model.dart';

class AuthRemoteDatasource {
  // =========================
  // LOGIN
  // POST /api/auth/login
  // =========================
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/auth/login');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left('login failed (${response.statusCode}): ${response.body}');
    }
  }

  // =========================
  // LOGOUT
  // POST /api/auth/logout
  // =========================
  Future<Either<String, String>> logout() async {
    final url = Uri.parse('${Variables.baseUrl}/api/auth/logout');
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Right((json['message'] ?? 'Logout berhasil.').toString());
    } else {
      return Left('logout failed (${response.statusCode}): ${response.body}');
    }
  }

  // =========================
  // ME
  // GET /api/auth/me
  // =========================
  Future<Either<String, UserResponseModel>> me() async {
    final url = Uri.parse('${Variables.baseUrl}/api/auth/me');
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Right(UserResponseModel.fromJson(response.body));
    } else {
      return Left('me failed (${response.statusCode}): ${response.body}');
    }
  }

  // =========================
  // CHANGE PASSWORD
  // PUT /api/auth/password
  // =========================
  Future<Either<String, String>> changePassword(
    ChangePasswordRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/auth/password');
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Right((json['message'] ?? 'Password berhasil diubah.').toString());
    } else {
      return Left(
        'change password failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
