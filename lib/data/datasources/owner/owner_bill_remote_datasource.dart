import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_bill_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_bill_response_model.dart';

class OwnerBillRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, OwnerBillListResponseModel>> list({
    String? status,
    String? period,
    int page = 1,
  }) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/bills').replace(
      queryParameters: {
        'page': page.toString(),
        if (status != null && status.isNotEmpty) 'status': status,
        if (period != null && period.isNotEmpty) 'period': period,
      },
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerBillListResponseModel.fromJson(response.body));
    } else {
      return Left(
        'owner bill list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerBillDetailResponseModel>> detail(int id) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/bills/$id');

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerBillDetailResponseModel.fromJson(response.body));
    } else {
      return Left(
        'owner bill detail failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerBillActionResponseModel>> create(
    OwnerBillCreateRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/bills');

    final response = await http.post(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(OwnerBillActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'owner bill create failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerBillActionResponseModel>> update(
    int id,
    OwnerBillUpdateRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/bills/$id');

    final response = await http.put(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(OwnerBillActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'owner bill update failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerBillActionResponseModel>> markPaid(int id) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/bills/$id/mark-paid');

    final response = await http.patch(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerBillActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'owner bill mark paid failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
