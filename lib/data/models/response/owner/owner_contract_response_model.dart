import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sewain/core/core.dart';

class OwnerContractListResponseModel {
  final List<OwnerContractModel> data;

  OwnerContractListResponseModel({required this.data});

  factory OwnerContractListResponseModel.fromJson(String str) =>
      OwnerContractListResponseModel.fromMap(jsonDecode(str));

  factory OwnerContractListResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => OwnerContractModel.fromMap(e))
          .toList(),
    );
  }
}

class OwnerContractDetailResponseModel {
  final OwnerContractModel? data;

  OwnerContractDetailResponseModel({this.data});

  factory OwnerContractDetailResponseModel.fromJson(String str) =>
      OwnerContractDetailResponseModel.fromMap(jsonDecode(str));

  factory OwnerContractDetailResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractDetailResponseModel(
      data: json['data'] == null
          ? null
          : OwnerContractModel.fromMap(json['data']),
    );
  }
}

class OwnerContractActionResponseModel {
  final String message;
  final OwnerContractModel? data;

  OwnerContractActionResponseModel({required this.message, this.data});

  factory OwnerContractActionResponseModel.fromJson(String str) =>
      OwnerContractActionResponseModel.fromMap(jsonDecode(str));

  factory OwnerContractActionResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractActionResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null
          ? null
          : OwnerContractModel.fromMap(json['data']),
    );
  }
}

class OwnerContractMessageResponseModel {
  final String message;

  OwnerContractMessageResponseModel({required this.message});

  factory OwnerContractMessageResponseModel.fromJson(String str) =>
      OwnerContractMessageResponseModel.fromMap(jsonDecode(str));

  factory OwnerContractMessageResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractMessageResponseModel(
      message: json['message']?.toString() ?? '',
    );
  }
}

class OwnerContractModel {
  final int? id;
  final OwnerContractTenantModel? tenant;
  final OwnerContractRoomModel? room;
  final String? roomCode;
  final String? propertyName;
  final String? startDate;
  final String? endDate;
  final num? monthlyPrice;
  final num? deposit;
  final String? status;
  final int? remainingMonths;
  final String? notes;
  final List<OwnerContractBillModel> bills;
  final String? createdAt;
  final String? updatedAt;

  OwnerContractModel({
    this.id,
    this.tenant,
    this.room,
    this.roomCode,
    this.propertyName,
    this.startDate,
    this.endDate,
    this.monthlyPrice,
    this.deposit,
    this.status,
    this.remainingMonths,
    this.notes,
    required this.bills,
    this.createdAt,
    this.updatedAt,
  });

  factory OwnerContractModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractModel(
      id: json['id'],
      tenant: json['tenant'] == null
          ? null
          : OwnerContractTenantModel.fromMap(json['tenant']),
      room: json['room'] == null
          ? null
          : OwnerContractRoomModel.fromMap(json['room']),
      roomCode:
          json['room_code']?.toString() ?? json['room']?['code']?.toString(),
      propertyName:
          json['property_name']?.toString() ??
          json['room']?['property']?['name']?.toString(),
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      monthlyPrice: json['monthly_price'],
      deposit: json['deposit'],
      status: json['status']?.toString(),
      remainingMonths: json['remaining_months'],
      notes: json['notes']?.toString(),
      bills: (json['bills'] as List? ?? [])
          .map((e) => OwnerContractBillModel.fromMap(e))
          .toList(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  bool get isActive => status == 'active';

  String get monthlyPriceRp => (monthlyPrice ?? 0).currencyFormatRp;
  String get depositRp => (deposit ?? 0).currencyFormatRp;

  String get statusLabel {
    if (status == 'active') return 'Aktif';
    if (status == 'terminated') return 'Diakhiri';
    if (status == 'expired') return 'Berakhir';
    return status ?? '-';
  }

  Color get statusColor {
    if (status == 'active') return AppColors.primary;
    if (status == 'terminated') return AppColors.red;
    if (status == 'expired') return AppColors.gray;
    return AppColors.gray;
  }
}

class OwnerContractTenantModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;

  OwnerContractTenantModel({this.id, this.name, this.email, this.phone});

  factory OwnerContractTenantModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractTenantModel(
      id: json['id'],
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
    );
  }
}

class OwnerContractRoomModel {
  final int? id;
  final int? propertyId;
  final String? code;
  final num? pricePerMonth;
  final String? description;
  final String? status;
  final OwnerContractPropertyModel? property;

  OwnerContractRoomModel({
    this.id,
    this.propertyId,
    this.code,
    this.pricePerMonth,
    this.description,
    this.status,
    this.property,
  });

  factory OwnerContractRoomModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractRoomModel(
      id: json['id'],
      propertyId: json['property_id'],
      code: json['code']?.toString(),
      pricePerMonth: json['price_per_month'],
      description: json['description']?.toString(),
      status: json['status']?.toString(),
      property: json['property'] == null
          ? null
          : OwnerContractPropertyModel.fromMap(json['property']),
    );
  }
}

class OwnerContractPropertyModel {
  final int? id;
  final String? name;
  final String? type;
  final String? address;
  final String? city;
  final String? province;

  OwnerContractPropertyModel({
    this.id,
    this.name,
    this.type,
    this.address,
    this.city,
    this.province,
  });

  factory OwnerContractPropertyModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractPropertyModel(
      id: json['id'],
      name: json['name']?.toString(),
      type: json['type']?.toString(),
      address: json['address']?.toString(),
      city: json['city']?.toString(),
      province: json['province']?.toString(),
    );
  }
}

class OwnerContractBillModel {
  final int? id;
  final String? period;
  final num? totalAmount;
  final String? status;
  final String? dueDate;
  final String? paidAt;

  OwnerContractBillModel({
    this.id,
    this.period,
    this.totalAmount,
    this.status,
    this.dueDate,
    this.paidAt,
  });

  factory OwnerContractBillModel.fromMap(Map<String, dynamic> json) {
    return OwnerContractBillModel(
      id: json['id'],
      period: json['period']?.toString(),
      totalAmount: json['total_amount'],
      status: json['status']?.toString(),
      dueDate: json['due_date']?.toString(),
      paidAt: json['paid_at']?.toString(),
    );
  }

  String get totalAmountRp => (totalAmount ?? 0).currencyFormatRp;
}
