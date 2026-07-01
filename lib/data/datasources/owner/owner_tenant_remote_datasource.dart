import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_tenant_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_tenant_response_model.dart';

class OwnerTenantRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, OwnerTenantListResponseModel>> list({
    String? search,
  }) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/tenants').replace(
      queryParameters: {
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      },
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerTenantListResponseModel.fromJson(response.body));
    } else {
      return Left(
        'tenant list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerTenantDetailResponseModel>> detail(int id) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/tenants/$id');

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerTenantDetailResponseModel.fromJson(response.body));
    } else {
      return Left(
        'tenant detail failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerTenantActionResponseModel>> create(
    OwnerTenantCreateRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/tenants');

    final response = await http.post(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(OwnerTenantActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'tenant create failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerTenantActionResponseModel>> update(
    int id,
    OwnerTenantUpdateRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/tenants/$id');

    final response = await http.put(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(OwnerTenantActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'tenant update failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerTenantMessageResponseModel>> resetPassword(
    int id,
    OwnerTenantResetPasswordRequestModel request,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/tenants/$id/reset-password',
    );

    final response = await http.patch(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(OwnerTenantMessageResponseModel.fromJson(response.body));
    } else {
      return Left(
        'tenant reset password failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
