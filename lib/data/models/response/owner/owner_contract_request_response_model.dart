import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sewain/core/core.dart';

class OwnerContractRequestListResponseModel {
  final List<OwnerContractRequestModel> data;

  OwnerContractRequestListResponseModel({required this.data});

  factory OwnerContractRequestListResponseModel.fromJson(String str) =>
      OwnerContractRequestListResponseModel.fromMap(jsonDecode(str));

  factory OwnerContractRequestListResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OwnerContractRequestListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => OwnerContractRequestModel.fromMap(e))
          .toList(),
    );
  }
}

class OwnerContractRequestDetailResponseModel {
  final OwnerContractRequestModel? data;

  OwnerContractRequestDetailResponseModel({this.data});

  factory OwnerContractRequestDetailResponseModel.fromJson(String str) =>
      OwnerContractRequestDetailResponseModel.fromMap(jsonDecode(str));

  factory OwnerContractRequestDetailResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OwnerContractRequestDetailResponseModel(
      data: json['data'] == null
          ? null
          : OwnerContractRequestModel.fromMap(json['data']),
    );
  }
}

class OwnerContractRequestActionResponseModel {
  final String message;
  final OwnerContractRequestModel? data;

  OwnerContractRequestActionResponseModel({required this.message, this.data});

  factory OwnerContractRequestActionResponseModel.fromJson(String str) =>
      OwnerContractRequestActionResponseModel.fromMap(jsonDecode(str));

  factory OwnerContractRequestActionResponseModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OwnerContractRequestActionResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null
          ? null
          : OwnerContractRequestModel.fromMap(json['data']),
    );
  }
}

class OwnerContractRequestModel {
  final int? id;
  final String? type;
  final String? status;
  final String? tenantName;
  final String? tenantEmail;
  final String? propertyName;
  final String? roomCode;
  final int? extendMonths;
  final String? requestedEndDate;
  final String? requestedStopDate;
  final String? reason;
  final String? tenantNotes;
  final String? ownerNotes;
  final String? respondedAt;
  final String? createdAt;

  OwnerContractRequestModel({
    this.id,
    this.type,
    this.status,
    this.tenantName,
    this.tenantEmail,
    this.propertyName,
    this.roomCode,
    this.extendMonths,
    this.requestedEndDate,
    this.requestedStopDate,
    this.reason,
    this.tenantNotes,
    this.ownerNotes,
    this.respondedAt,
    this.createdAt,
  });

  factory OwnerContractRequestModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractRequestModel(
      id: json['id'],
      type: json['type']?.toString(),
      status: json['status']?.toString(),
      tenantName: json['tenant_name']?.toString(),
      tenantEmail: json['tenant_email']?.toString(),
      propertyName: json['property_name']?.toString(),
      roomCode: json['room_code']?.toString(),
      extendMonths: json['extend_months'],
      requestedEndDate: json['requested_end_date']?.toString(),
      requestedStopDate: json['requested_stop_date']?.toString(),
      reason: json['reason']?.toString(),
      tenantNotes: json['tenant_notes']?.toString(),
      ownerNotes: json['owner_notes']?.toString(),
      respondedAt: json['responded_at']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }

  bool get isPending => status == 'pending';

  String get typeLabel {
    if (type == 'extend') return 'Perpanjangan';
    if (type == 'stop') return 'Stop Kos';
    return type ?? '-';
  }

  String get statusLabel {
    if (status == 'pending') return 'Pending';
    if (status == 'approved') return 'Disetujui';
    if (status == 'rejected') return 'Ditolak';
    return status ?? '-';
  }

  Color get statusColor {
    if (status == 'pending') return const Color(0xffF59E0B);
    if (status == 'approved') return AppColors.primary;
    if (status == 'rejected') return AppColors.red;
    return AppColors.gray;
  }

  IconData get typeIcon {
    if (type == 'extend') return Icons.calendar_month_outlined;
    if (type == 'stop') return Icons.logout_rounded;
    return Icons.pending_actions_outlined;
  }
}
