import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/tenant/tenant_profile_request_model.dart';
import 'package:sewain/data/models/response/tenant/tenant_profile_response_model.dart';

class TenantProfileRemoteDatasource {
  Future<Map<String, String>?> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    if (authData?.token == null) return null;

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData!.token}',
    };
  }

  Future<Either<String, TenantProfileResponseModel>> getProfile() async {
    try {
      final headers = await _headers();
      if (headers == null) {
        return const Left('Sesi login tidak ditemukan, silakan login ulang.');
      }

      final url = Uri.parse('${Variables.baseUrl}/api/tenant/profile');

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return Right(TenantProfileResponseModel.fromJson(response.body));
      } else {
        return Left(
          'profile failed (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }

  Future<Either<String, TenantProfileUpdateResponseModel>> updateProfile(
    TenantProfileUpdateRequestModel request,
  ) async {
    try {
      final headers = await _headers();
      if (headers == null) {
        return const Left('Sesi login tidak ditemukan, silakan login ulang.');
      }

      final url = Uri.parse('${Variables.baseUrl}/api/tenant/profile');

      final response = await http
          .put(url, headers: headers, body: request.toJson())
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return Right(TenantProfileUpdateResponseModel.fromJson(response.body));
      } else {
        return Left(
          'update profile failed (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }
}
