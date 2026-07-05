import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_bill_response_model.dart';

class TenantBillRemoteDatasource {
  Future<Map<String, String>?> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    if (authData?.token == null) return null;

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData!.token}',
    };
  }

  Future<Either<String, TenantBillListResponseModel>> list({
    String? status,
  }) async {
    try {
      final headers = await _headers();
      if (headers == null) {
        return const Left('Sesi login tidak ditemukan, silakan login ulang.');
      }

      final url = Uri.parse('${Variables.baseUrl}/api/tenant/bills').replace(
        queryParameters: {
          if (status != null && status.isNotEmpty) 'status': status,
        },
      );

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return Right(TenantBillListResponseModel.fromJson(response.body));
      } else {
        return Left(
          'bill list failed (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }

  Future<Either<String, TenantBillDetailResponseModel>> detail(int id) async {
    try {
      final headers = await _headers();
      if (headers == null) {
        return const Left('Sesi login tidak ditemukan, silakan login ulang.');
      }

      final url = Uri.parse('${Variables.baseUrl}/api/tenant/bills/$id');

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return Right(TenantBillDetailResponseModel.fromJson(response.body));
      } else {
        return Left(
          'bill detail failed (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }
}
