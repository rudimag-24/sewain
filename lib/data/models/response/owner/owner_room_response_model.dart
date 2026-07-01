import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sewain/core/core.dart';

class OwnerRoomListResponseModel {
  final List<OwnerRoomModel> data;

  OwnerRoomListResponseModel({required this.data});

  factory OwnerRoomListResponseModel.fromJson(String str) =>
      OwnerRoomListResponseModel.fromMap(jsonDecode(str));

  factory OwnerRoomListResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerRoomListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => OwnerRoomModel.fromMap(e))
          .toList(),
    );
  }
}

class OwnerRoomDetailResponseModel {
  final OwnerRoomModel? data;

  OwnerRoomDetailResponseModel({this.data});

  factory OwnerRoomDetailResponseModel.fromJson(String str) =>
      OwnerRoomDetailResponseModel.fromMap(jsonDecode(str));

  factory OwnerRoomDetailResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerRoomDetailResponseModel(
      data: json['data'] == null ? null : OwnerRoomModel.fromMap(json['data']),
    );
  }
}

class OwnerRoomActionResponseModel {
  final String message;
  final OwnerRoomModel? data;

  OwnerRoomActionResponseModel({required this.message, this.data});

  factory OwnerRoomActionResponseModel.fromJson(String str) =>
      OwnerRoomActionResponseModel.fromMap(jsonDecode(str));

  factory OwnerRoomActionResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerRoomActionResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null ? null : OwnerRoomModel.fromMap(json['data']),
    );
  }
}

class OwnerRoomMessageResponseModel {
  final String message;

  OwnerRoomMessageResponseModel({required this.message});

  factory OwnerRoomMessageResponseModel.fromJson(String str) =>
      OwnerRoomMessageResponseModel.fromMap(jsonDecode(str));

  factory OwnerRoomMessageResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerRoomMessageResponseModel(
      message: json['message']?.toString() ?? '',
    );
  }
}

class OwnerRoomModel {
  final int? id;
  final int? propertyId;
  final String? code;
  final num? pricePerMonth;
  final String? description;
  final String? status;
  final OwnerRoomTenantModel? tenant;
  final OwnerRoomActiveContractModel? activeContract;
  final List<OwnerRoomRentalContractModel> rentalContracts;
  final String? createdAt;
  final String? updatedAt;

  OwnerRoomModel({
    this.id,
    this.propertyId,
    this.code,
    this.pricePerMonth,
    this.description,
    this.status,
    this.tenant,
    this.activeContract,
    required this.rentalContracts,
    this.createdAt,
    this.updatedAt,
  });

  factory OwnerRoomModel.fromMap(Map<String, dynamic> json) {
    return OwnerRoomModel(
      id: json['id'],
      propertyId: json['property_id'],
      code: json['code']?.toString(),
      pricePerMonth: json['price_per_month'],
      description: json['description']?.toString(),
      status: json['status']?.toString(),
      tenant: json['tenant'] == null
          ? null
          : OwnerRoomTenantModel.fromMap(json['tenant']),
      activeContract: json['active_contract'] == null
          ? null
          : OwnerRoomActiveContractModel.fromMap(json['active_contract']),
      rentalContracts: (json['rental_contracts'] as List? ?? [])
          .map((e) => OwnerRoomRentalContractModel.fromMap(e))
          .toList(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  bool get isOccupied => status == 'occupied';
  bool get isAvailable => status == 'available';

  String get priceRp => (pricePerMonth ?? 0).currencyFormatRp;

  String get statusLabel {
    if (status == 'occupied') return 'Terisi';
    if (status == 'available') return 'Kosong';
    if (status == 'maintenance') return 'Maintenance';
    return status ?? '-';
  }

  Color get statusColor {
    if (status == 'occupied') return const Color(0xff16A34A);
    if (status == 'available') return AppColors.primary;
    if (status == 'maintenance') return const Color(0xffF59E0B);
    return AppColors.gray;
  }
}

class OwnerRoomTenantModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;

  OwnerRoomTenantModel({this.id, this.name, this.email, this.phone});

  factory OwnerRoomTenantModel.fromMap(Map<String, dynamic> json) {
    return OwnerRoomTenantModel(
      id: json['id'],
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
    );
  }
}

class OwnerRoomActiveContractModel {
  final int? id;
  final int? tenantId;
  final int? roomId;
  final String? startDate;
  final String? endDate;
  final num? monthlyPrice;
  final num? deposit;
  final String? status;
  final OwnerRoomTenantModel? tenant;

  OwnerRoomActiveContractModel({
    this.id,
    this.tenantId,
    this.roomId,
    this.startDate,
    this.endDate,
    this.monthlyPrice,
    this.deposit,
    this.status,
    this.tenant,
  });

  factory OwnerRoomActiveContractModel.fromMap(Map<String, dynamic> json) {
    return OwnerRoomActiveContractModel(
      id: json['id'],
      tenantId: json['tenant_id'],
      roomId: json['room_id'],
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      monthlyPrice: json['monthly_price'],
      deposit: json['deposit'],
      status: json['status']?.toString(),
      tenant: json['tenant'] == null
          ? null
          : OwnerRoomTenantModel.fromMap(json['tenant']),
    );
  }
}

class OwnerRoomRentalContractModel {
  final int? id;
  final int? tenantId;
  final int? roomId;
  final String? startDate;
  final String? endDate;
  final num? monthlyPrice;
  final num? deposit;
  final String? status;

  OwnerRoomRentalContractModel({
    this.id,
    this.tenantId,
    this.roomId,
    this.startDate,
    this.endDate,
    this.monthlyPrice,
    this.deposit,
    this.status,
  });

  factory OwnerRoomRentalContractModel.fromMap(Map<String, dynamic> json) {
    return OwnerRoomRentalContractModel(
      id: json['id'],
      tenantId: json['tenant_id'],
      roomId: json['room_id'],
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      monthlyPrice: json['monthly_price'],
      deposit: json['deposit'],
      status: json['status']?.toString(),
    );
  }

  String get monthlyPriceRp => (monthlyPrice ?? 0).currencyFormatRp;
  String get depositRp => (deposit ?? 0).currencyFormatRp;
}
