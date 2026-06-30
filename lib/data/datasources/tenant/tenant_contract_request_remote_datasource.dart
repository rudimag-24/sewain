import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/tenant/tenant_contract_request_request_model.dart';
import 'package:sewain/data/models/response/tenant/tenant_contract_request_response_model.dart';

class TenantContractRequestRemoteDatasource {
  Future<Either<String, TenantContractRequestListResponseModel>> list({
    String? type,
    String? status,
  }) async {
    final queryParameters = <String, String>{
      if (type != null && type.isNotEmpty) 'type': type,
      if (status != null && status.isNotEmpty) 'status': status,
    };

    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/contract-requests',
    ).replace(queryParameters: queryParameters);

    final authData = await AuthLocalDatasource().getAuthData();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Right(
        TenantContractRequestListResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'contract request list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, TenantContractRequestDetailResponseModel>> detail(
    int id,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/contract-requests/$id',
    );

    final authData = await AuthLocalDatasource().getAuthData();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Right(
        TenantContractRequestDetailResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'contract request detail failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, TenantContractRequestActionResponseModel>> extend(
    TenantContractExtendRequestModel request,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/contract-requests/extend',
    );

    final authData = await AuthLocalDatasource().getAuthData();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(
        TenantContractRequestActionResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'extend contract failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, TenantContractRequestActionResponseModel>> stop(
    TenantContractStopRequestModel request,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/contract-requests/stop',
    );

    final authData = await AuthLocalDatasource().getAuthData();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(
        TenantContractRequestActionResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'stop contract failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
