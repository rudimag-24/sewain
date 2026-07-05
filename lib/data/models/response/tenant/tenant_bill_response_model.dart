import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sewain/core/core.dart';

num? _toNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String)
    return int.tryParse(value) ?? num.tryParse(value)?.toInt();
  return null;
}

class TenantBillListResponseModel {
  final String? message;
  final List<TenantBillModel> data;

  TenantBillListResponseModel({this.message, required this.data});

  factory TenantBillListResponseModel.fromJson(String str) =>
      TenantBillListResponseModel.fromMap(jsonDecode(str));

  factory TenantBillListResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantBillListResponseModel(
      message: json['message']?.toString(),
      data: (json['data'] as List? ?? [])
          .map((e) => TenantBillModel.fromMap(e))
          .toList(),
    );
  }
}

class TenantBillDetailResponseModel {
  final TenantBillModel? data;

  TenantBillDetailResponseModel({this.data});

  factory TenantBillDetailResponseModel.fromJson(String str) =>
      TenantBillDetailResponseModel.fromMap(jsonDecode(str));

  factory TenantBillDetailResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantBillDetailResponseModel(
      data: json['data'] == null ? null : TenantBillModel.fromMap(json['data']),
    );
  }
}

class TenantBillModel {
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
  final bool isOverdue;
  final String? notes;

  TenantBillModel({
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
    required this.isOverdue,
    this.notes,
  });

  factory TenantBillModel.fromMap(Map<String, dynamic> json) {
    return TenantBillModel(
      id: _toInt(json['id']),
      period: json['period']?.toString(),
      rentAmount: _toNum(json['rent_amount']),
      electricityAmount: _toNum(json['electricity_amount']),
      waterAmount: _toNum(json['water_amount']),
      otherAmount: _toNum(json['other_amount']),
      otherDescription: json['other_description']?.toString(),
      totalAmount: _toNum(json['total_amount']),
      dueDate: json['due_date']?.toString(),
      status: json['status']?.toString(),
      paidAt: json['paid_at']?.toString(),
      isOverdue: json['is_overdue'] == true,
      notes: json['notes']?.toString(),
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

  String get totalAmountRp => (totalAmount ?? 0).currencyFormatRp;
  String get rentAmountRp => (rentAmount ?? 0).currencyFormatRp;
  String get electricityAmountRp => (electricityAmount ?? 0).currencyFormatRp;
  String get waterAmountRp => (waterAmount ?? 0).currencyFormatRp;
  String get otherAmountRp => (otherAmount ?? 0).currencyFormatRp;
}
