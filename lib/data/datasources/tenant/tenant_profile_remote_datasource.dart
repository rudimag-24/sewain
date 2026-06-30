import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/tenant/tenant_profile_request_model.dart';
import 'package:sewain/data/models/response/tenant/tenant_profile_response_model.dart';

class TenantProfileRemoteDatasource {
  Future<Either<String, TenantProfileResponseModel>> getProfile() async {
    final url = Uri.parse('${Variables.baseUrl}/api/tenant/profile');

    final authData = await AuthLocalDatasource().getAuthData();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Right(TenantProfileResponseModel.fromJson(response.body));
    } else {
      return Left('profile failed (${response.statusCode}): ${response.body}');
    }
  }

  Future<Either<String, TenantProfileUpdateResponseModel>> updateProfile(
    TenantProfileUpdateRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/tenant/profile');

    final authData = await AuthLocalDatasource().getAuthData();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(TenantProfileUpdateResponseModel.fromJson(response.body));
    } else {
      return Left(
        'update profile failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
