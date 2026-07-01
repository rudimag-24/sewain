import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sewain/core/core.dart';

class OwnerBillListResponseModel {
  final List<OwnerBillModel> data;
  final OwnerBillMetaModel? meta;

  OwnerBillListResponseModel({required this.data, this.meta});

  factory OwnerBillListResponseModel.fromJson(String str) =>
      OwnerBillListResponseModel.fromMap(jsonDecode(str));

  factory OwnerBillListResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerBillListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => OwnerBillModel.fromMap(e))
          .toList(),
      meta: json['meta'] == null
          ? null
          : OwnerBillMetaModel.fromMap(json['meta']),
    );
  }
}

class OwnerBillDetailResponseModel {
  final OwnerBillModel? data;

  OwnerBillDetailResponseModel({this.data});

  factory OwnerBillDetailResponseModel.fromJson(String str) =>
      OwnerBillDetailResponseModel.fromMap(jsonDecode(str));

  factory OwnerBillDetailResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerBillDetailResponseModel(
      data: json['data'] == null ? null : OwnerBillModel.fromMap(json['data']),
    );
  }
}

class OwnerBillActionResponseModel {
  final String message;
  final OwnerBillModel? data;

  OwnerBillActionResponseModel({required this.message, this.data});

  factory OwnerBillActionResponseModel.fromJson(String str) =>
      OwnerBillActionResponseModel.fromMap(jsonDecode(str));

  factory OwnerBillActionResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerBillActionResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null ? null : OwnerBillModel.fromMap(json['data']),
    );
  }
}

class OwnerBillMetaModel {
  final int total;
  final int currentPage;
  final int lastPage;

  OwnerBillMetaModel({
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  factory OwnerBillMetaModel.fromMap(Map<String, dynamic> json) {
    return OwnerBillMetaModel(
      total: json['total'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }
}

class OwnerBillModel {
  final int? id;
  final String? period;
  final num? rentAmount;
  final num? electricityAmount;
  final num? waterAmount;
  final num? otherAmount;
  final String? otherDescription;
  final num? totalAmount;
  final String? dueDate;
  final String? status;
  final String? paidAt;
  final String? notes;
  final bool isOverdue;
  final String? tenantName;
  final String? roomCode;
  final String? propertyName;

  OwnerBillModel({
    this.id,
    this.period,
    this.rentAmount,
    this.electricityAmount,
    this.waterAmount,
    this.otherAmount,
    this.otherDescription,
    this.totalAmount,
    this.dueDate,
    this.status,
    this.paidAt,
    this.notes,
    required this.isOverdue,
    this.tenantName,
    this.roomCode,
    this.propertyName,
  });

  factory OwnerBillModel.fromMap(Map<String, dynamic> json) {
    return OwnerBillModel(
      id: json['id'],
      period: json['period']?.toString(),
      rentAmount: json['rent_amount'],
      electricityAmount: json['electricity_amount'],
      waterAmount: json['water_amount'],
      otherAmount: json['other_amount'],
      otherDescription: json['other_description']?.toString(),
      totalAmount: json['total_amount'],
      dueDate: json['due_date']?.toString(),
      status: json['status']?.toString(),
      paidAt: json['paid_at']?.toString(),
      notes: json['notes']?.toString(),
      isOverdue: json['is_overdue'] == true,
      tenantName: json['tenant_name']?.toString(),
      roomCode: json['room_code']?.toString(),
      propertyName: json['property_name']?.toString(),
    );
  }

  bool get isPaid => status == 'paid';

  String get statusLabel {
    if (status == 'paid') return 'Lunas';
    if (status == 'pending') return 'Pending';
    if (status == 'unpaid') return isOverdue ? 'Terlambat' : 'Belum Bayar';
    return status ?? '-';
  }

  Color get statusColor {
    if (status == 'paid') return const Color(0xff16A34A);
    if (status == 'pending') return const Color(0xffF59E0B);
    if (isOverdue) return AppColors.red;
    return AppColors.primary;
  }

  String get rentAmountRp => (rentAmount ?? 0).currencyFormatRp;
  String get electricityAmountRp => (electricityAmount ?? 0).currencyFormatRp;
  String get waterAmountRp => (waterAmount ?? 0).currencyFormatRp;
  String get otherAmountRp => (otherAmount ?? 0).currencyFormatRp;
  String get totalAmountRp => (totalAmount ?? 0).currencyFormatRp;
}
