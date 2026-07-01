import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_contract_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_contract_response_model.dart';

class OwnerContractRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, OwnerContractListResponseModel>> list({
    String? status,
  }) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/contracts').replace(
      queryParameters: {
        if (status != null && status.isNotEmpty) 'status': status,
      },
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerContractListResponseModel.fromJson(response.body));
    } else {
      return Left(
        'contract list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerContractDetailResponseModel>> detail(
    int id,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/contracts/$id');

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerContractDetailResponseModel.fromJson(response.body));
    } else {
      return Left(
        'contract detail failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerContractActionResponseModel>> create(
    OwnerContractCreateRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/contracts');

    final response = await http.post(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(OwnerContractActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'contract create failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerContractActionResponseModel>> update(
    int id,
    OwnerContractUpdateRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/contracts/$id');

    final response = await http.put(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(OwnerContractActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'contract update failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerContractMessageResponseModel>> endContract(
    int id,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/contracts/$id/end');

    final response = await http.patch(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerContractMessageResponseModel.fromJson(response.body));
    } else {
      return Left(
        'contract end failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
