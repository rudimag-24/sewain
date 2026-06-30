import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_payment_response_model.dart';

class TenantPaymentRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, TenantPaymentListResponseModel>> list() async {
    final url = Uri.parse('${Variables.baseUrl}/api/tenant/payments');

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(TenantPaymentListResponseModel.fromJson(response.body));
    } else {
      return Left(
        'payment list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, TenantPaymentActionResponseModel>> simulate(
    int billId,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/payments/$billId/simulate',
    );

    final response = await http.post(url, headers: await _headers());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(TenantPaymentActionResponseModel.fromJson(response.body));
    } else {
      return Left('payment failed (${response.statusCode}): ${response.body}');
    }
  }

  Future<Either<String, TenantPaymentReceiptResponseModel>> receipt(
    int paymentId,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/payments/$paymentId/receipt',
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(TenantPaymentReceiptResponseModel.fromJson(response.body));
    } else {
      return Left('receipt failed (${response.statusCode}): ${response.body}');
    }
  }
}
