import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/request/owner/owner_room_request_model.dart';
import 'package:sewain/data/models/response/owner/owner_room_response_model.dart';

class OwnerRoomRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, OwnerRoomListResponseModel>> list({
    required int propertyId,
    String? status,
  }) async {
    final url =
        Uri.parse(
          '${Variables.baseUrl}/api/owner/properties/$propertyId/rooms',
        ).replace(
          queryParameters: {
            if (status != null && status.isNotEmpty) 'status': status,
          },
        );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerRoomListResponseModel.fromJson(response.body));
    } else {
      return Left(
        'room list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerRoomDetailResponseModel>> detail({
    required int propertyId,
    required int roomId,
  }) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/properties/$propertyId/rooms/$roomId',
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(OwnerRoomDetailResponseModel.fromJson(response.body));
    } else {
      return Left(
        'room detail failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerRoomActionResponseModel>> create({
    required int propertyId,
    required OwnerRoomRequestModel request,
  }) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/properties/$propertyId/rooms',
    );

    final response = await http.post(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(OwnerRoomActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'room create failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, OwnerRoomActionResponseModel>> update({
    required int propertyId,
    required int roomId,
    required OwnerRoomRequestModel request,
  }) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/properties/$propertyId/rooms/$roomId',
    );

    final response = await http.put(
      url,
      headers: await _headers(),
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(OwnerRoomActionResponseModel.fromJson(response.body));
    } else {
      return Left(
        'room update failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, String>> delete({
    required int propertyId,
    required int roomId,
  }) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/owner/properties/$propertyId/rooms/$roomId',
    );

    final response = await http.delete(url, headers: await _headers());

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(json['message']?.toString() ?? 'Kamar berhasil dihapus.');
    } else {
      return Left(
        'room delete failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
