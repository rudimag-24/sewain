import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_contract_request_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_contract_request_response_model.dart';

class OwnerContractRequestRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, OwnerContractRequestListResponseModel>> list({
    String? status,
    String? type,
  }) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/contract-requests')
        .replace(
          queryParameters: {
            if (status != null && status.isNotEmpty) 'status': status,
            if (type != null && type.isNotEmpty) 'type': type,
          },
        );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(
        OwnerContractRequestListResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'owner contract request list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerContractRequestDetailResponseModel>> detail(
    int id,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/contract-requests/$id',
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(
        OwnerContractRequestDetailResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'owner contract request detail failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerContractRequestActionResponseModel>> approve(
    int id,
    OwnerContractRequestActionRequestModel request,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/contract-requests/$id/approve',
    );

    final response = await http.patch(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(
        OwnerContractRequestActionResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'owner contract request approve failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerContractRequestActionResponseModel>> reject(
    int id,
    OwnerContractRequestActionRequestModel request,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/contract-requests/$id/reject',
    );

    final response = await http.patch(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(
        OwnerContractRequestActionResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'owner contract request reject failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
