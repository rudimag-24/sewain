import 'dart:convert';

class TenantNotificationListResponseModel {
  final List<TenantNotificationModel> data;
  final TenantNotificationMetaModel? meta;

  TenantNotificationListResponseModel({required this.data, this.meta});

  factory TenantNotificationListResponseModel.fromJson(String str) =>
      TenantNotificationListResponseModel.fromMap(jsonDecode(str));

  factory TenantNotificationListResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return TenantNotificationListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => TenantNotificationModel.fromMap(e))
          .toList(),
      meta: json['meta'] == null
          ? null
          : TenantNotificationMetaModel.fromMap(json['meta']),
    );
  }
}

class TenantNotificationUnreadCountResponseModel {
  final int count;

  TenantNotificationUnreadCountResponseModel({required this.count});

  factory TenantNotificationUnreadCountResponseModel.fromJson(String str) =>
      TenantNotificationUnreadCountResponseModel.fromMap(jsonDecode(str));

  factory TenantNotificationUnreadCountResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return TenantNotificationUnreadCountResponseModel(
      count: json['count'] ?? 0,
    );
  }
}

class TenantNotificationActionResponseModel {
  final String message;

  TenantNotificationActionResponseModel({required this.message});

  factory TenantNotificationActionResponseModel.fromJson(String str) =>
      TenantNotificationActionResponseModel.fromMap(jsonDecode(str));

  factory TenantNotificationActionResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return TenantNotificationActionResponseModel(
      message: json['message']?.toString() ?? '',
    );
  }
}

class TenantNotificationMetaModel {
  final int total;
  final int unreadCount;
  final int currentPage;
  final int lastPage;

  TenantNotificationMetaModel({
    required this.total,
    required this.unreadCount,
    required this.currentPage,
    required this.lastPage,
  });

  factory TenantNotificationMetaModel.fromMap(Map<String, dynamic> json) {
    return TenantNotificationMetaModel(
      total: json['total'] ?? 0,
      unreadCount: json['unread_count'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }
}

class TenantNotificationModel {
  final String? id;
  final String? type;
  final Map<String, dynamic> data;
  final String? readAt;
  final String? createdAt;

  TenantNotificationModel({
    this.id,
    this.type,
    required this.data,
    this.readAt,
    this.createdAt,
  });

  factory TenantNotificationModel.fromMap(Map<String, dynamic> json) {
    return TenantNotificationModel(
      id: json['id']?.toString(),
      type: json['type']?.toString(),
      data: json['data'] is Map<String, dynamic>
          ? json['data'] as Map<String, dynamic>
          : {},
      readAt: json['read_at']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }

  bool get isRead => readAt != null;

  String get title {
    return data['title']?.toString() ??
        data['subject']?.toString() ??
        type ??
        'Notifikasi';
  }

  String get message {
    return data['message']?.toString() ??
        data['body']?.toString() ??
        data['description']?.toString() ??
        'Ada notifikasi baru.';
  }
}
