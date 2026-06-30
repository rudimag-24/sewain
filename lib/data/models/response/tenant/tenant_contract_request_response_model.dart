import 'dart:convert';

class TenantContractRequestListResponseModel {
  final List<TenantContractRequestModel> data;

  TenantContractRequestListResponseModel({required this.data});

  factory TenantContractRequestListResponseModel.fromJson(String str) =>
      TenantContractRequestListResponseModel.fromMap(jsonDecode(str));

  factory TenantContractRequestListResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return TenantContractRequestListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => TenantContractRequestModel.fromMap(e))
          .toList(),
    );
  }
}

class TenantContractRequestDetailResponseModel {
  final TenantContractRequestModel? data;

  TenantContractRequestDetailResponseModel({this.data});

  factory TenantContractRequestDetailResponseModel.fromJson(String str) =>
      TenantContractRequestDetailResponseModel.fromMap(jsonDecode(str));

  factory TenantContractRequestDetailResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return TenantContractRequestDetailResponseModel(
      data: json['data'] == null
          ? null
          : TenantContractRequestModel.fromMap(json['data']),
    );
  }
}

class TenantContractRequestActionResponseModel {
  final String message;
  final TenantContractRequestModel? data;

  TenantContractRequestActionResponseModel({required this.message, this.data});

  factory TenantContractRequestActionResponseModel.fromJson(String str) =>
      TenantContractRequestActionResponseModel.fromMap(jsonDecode(str));

  factory TenantContractRequestActionResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return TenantContractRequestActionResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null
          ? null
          : TenantContractRequestModel.fromMap(json['data']),
    );
  }
}

class TenantContractRequestModel {
  final int? id;
  final String? type;
  final String? status;
  final int? extendMonths;
  final String? requestedEndDate;
  final String? requestedStopDate;
  final String? reason;
  final String? tenantNotes;
  final String? ownerNotes;
  final String? respondedAt;
  final String? propertyName;
  final String? roomCode;
  final String? createdAt;

  TenantContractRequestModel({
    this.id,
    this.type,
    this.status,
    this.extendMonths,
    this.requestedEndDate,
    this.requestedStopDate,
    this.reason,
    this.tenantNotes,
    this.ownerNotes,
    this.respondedAt,
    this.propertyName,
    this.roomCode,
    this.createdAt,
  });

  factory TenantContractRequestModel.fromMap(Map<String, dynamic> json) {
    return TenantContractRequestModel(
      id: json['id'],
      type: json['type']?.toString(),
      status: json['status']?.toString(),
      extendMonths: json['extend_months'],
      requestedEndDate: json['requested_end_date']?.toString(),
      requestedStopDate: json['requested_stop_date']?.toString(),
      reason: json['reason']?.toString(),
      tenantNotes: json['tenant_notes']?.toString(),
      ownerNotes: json['owner_notes']?.toString(),
      respondedAt: json['responded_at']?.toString(),
      propertyName: json['property_name']?.toString(),
      roomCode: json['room_code']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }

  String get typeLabel {
    if (type == 'extend') return 'Perpanjangan';
    if (type == 'stop') return 'Stop Kos';
    return type ?? '-';
  }

  String get statusLabel {
    if (status == 'pending') return 'Menunggu';
    if (status == 'approved') return 'Disetujui';
    if (status == 'rejected') return 'Ditolak';
    return status ?? '-';
  }
}
