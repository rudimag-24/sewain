import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_property_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_property_response_model.dart';

class OwnerPropertyRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, OwnerPropertyListResponseModel>> list({
    String? status,
    String? type,
  }) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/properties').replace(
      queryParameters: {
        if (status != null && status.isNotEmpty) 'status': status,
        if (type != null && type.isNotEmpty) 'type': type,
      },
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerPropertyListResponseModel.fromJson(response.body));
    } else {
      return Left(
        'property list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerPropertyDetailResponseModel>> detail(
    int id,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/properties/$id');

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerPropertyDetailResponseModel.fromJson(response.body));
    } else {
      return Left(
        'property detail failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerPropertyActionResponseModel>> create(
    OwnerPropertyRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/properties');

    final response = await http.post(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(OwnerPropertyActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'property create failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerPropertyActionResponseModel>> update(
    int id,
    OwnerPropertyRequestModel request,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/properties/$id');

    final response = await http.put(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(OwnerPropertyActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'property update failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, String>> delete(int id) async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/properties/$id');

    final response = await http.delete(url, headers: await _headers());

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(json['message']?.toString() ?? 'Properti berhasil dihapus.');
    } else {
      return Left(
        'property delete failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerPropertyToggleResponseModel>> toggleStatus(
    int id,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/properties/$id/toggle-status',
    );

    final response = await http.patch(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerPropertyToggleResponseModel.fromJson(response.body));
    } else {
      return Left(
        'property toggle failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
