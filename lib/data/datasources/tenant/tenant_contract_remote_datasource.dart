import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_contract_response_model.dart';

class TenantContractRemoteDatasource {
  Future<Either<String, TenantContractResponseModel>> getContract() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData?.token == null) {
        return const Left('Sesi login tidak ditemukan, silakan login ulang.');
      }

      final url = Uri.parse('${Variables.baseUrl}/api/tenant/contract');

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData!.token}',
      };

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      // 404 di sini artinya "tidak ada kontrak aktif", bukan error —
      // body-nya tetap JSON valid ({ message, data: null }), jadi tetap diparse sebagai Right.
      if (response.statusCode == 200 || response.statusCode == 404) {
        return Right(TenantContractResponseModel.fromJson(response.body));
      } else {
        return Left(
          'contract failed (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }
}
