import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/response/owner/owner_payment_response_model.dart';

class OwnerPaymentRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, OwnerPaymentListResponseModel>> list({
    String? status,
    String? method,
    int page = 1,
  }) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/payments').replace(
      queryParameters: {
        'page': page.toString(),
        if (status != null && status.isNotEmpty) 'status': status,
        if (method != null && method.isNotEmpty) 'method': method,
      },
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerPaymentListResponseModel.fromJson(response.body));
    } else {
      return Left(
        'owner payment list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerPaymentDetailResponseModel>> detail(int id) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/payments/$id');

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerPaymentDetailResponseModel.fromJson(response.body));
    } else {
      return Left(
        'owner payment detail failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
