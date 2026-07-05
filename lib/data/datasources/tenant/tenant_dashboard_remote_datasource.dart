import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_dashboard_response_model.dart';

class TenantDashboardRemoteDatasource {
  Future<Either<String, TenantDashboardResponseModel>> getDashboard() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData?.token == null) {
        return const Left('Sesi login tidak ditemukan, silakan login ulang.');
      }

      final url = Uri.parse('${Variables.baseUrl}/api/tenant/dashboard');

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData!.token}',
      };

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return Right(TenantDashboardResponseModel.fromJson(response.body));
      } else {
        return Left(
          'dashboard failed (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }
}
