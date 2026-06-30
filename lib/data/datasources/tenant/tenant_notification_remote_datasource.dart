import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/response/tenant/tenant_notification_response_model.dart';

class TenantNotificationRemoteDatasource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
  }

  Future<Either<String, TenantNotificationListResponseModel>> list({
    int page = 1,
  }) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/notifications',
    ).replace(queryParameters: {'page': page.toString()});

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(TenantNotificationListResponseModel.fromJson(response.body));
    } else {
      return Left(
        'notification list failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, TenantNotificationUnreadCountResponseModel>>
  unreadCount() async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/notifications/unread-count',
    );

    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(
        TenantNotificationUnreadCountResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'unread count failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, TenantNotificationActionResponseModel>> markRead(
    String id,
  ) async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/notifications/$id/read',
    );

    final response = await http.patch(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(
        TenantNotificationActionResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'mark read failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Either<String, TenantNotificationActionResponseModel>>
  markAllRead() async {
    final url = Uri.parse(
      '${Variables.baseUrl}/api/tenant/notifications/read-all',
    );

    final response = await http.patch(url, headers: await _headers());

    if (response.statusCode == 200) {
      return Right(
        TenantNotificationActionResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'mark all read failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
