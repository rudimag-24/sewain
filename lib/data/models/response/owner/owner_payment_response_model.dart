import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sewain/core/core.dart';

class OwnerPaymentListResponseModel {
  final List<OwnerPaymentModel> data;
  final OwnerPaymentMetaModel? meta;

  OwnerPaymentListResponseModel({required this.data, this.meta});

  factory OwnerPaymentListResponseModel.fromJson(String str) =>
      OwnerPaymentListResponseModel.fromMap(jsonDecode(str));

  factory OwnerPaymentListResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerPaymentListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => OwnerPaymentModel.fromMap(e))
          .toList(),
      meta: json['meta'] == null
          ? null
          : OwnerPaymentMetaModel.fromMap(json['meta']),
    );
  }
}

class OwnerPaymentDetailResponseModel {
  final OwnerPaymentModel? data;

  OwnerPaymentDetailResponseModel({this.data});

  factory OwnerPaymentDetailResponseModel.fromJson(String str) =>
      OwnerPaymentDetailResponseModel.fromMap(jsonDecode(str));

  factory OwnerPaymentDetailResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerPaymentDetailResponseModel(
      data: json['data'] == null
          ? null
          : OwnerPaymentModel.fromMap(json['data']),
    );
  }
}

class OwnerPaymentMetaModel {
  final int total;
  final int currentPage;
  final int lastPage;

  OwnerPaymentMetaModel({
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  factory OwnerPaymentMetaModel.fromMap(Map<String, dynamic> json) {
    return OwnerPaymentMetaModel(
      total: json['total'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }
}

class OwnerPaymentModel {
  final int? id;
  final String? paymentCode;
  final num? amount;
  final String? method;
  final String? status;
  final String? paidAt;
  final String? createdAt;
  final OwnerPaymentBillModel? bill;
  final String? tenantName;
  final String? roomCode;
  final String? propertyName;

  OwnerPaymentModel({
    this.id,
    this.paymentCode,
    this.amount,
    this.method,
    this.status,
    this.paidAt,
    this.createdAt,
    this.bill,
    this.tenantName,
    this.roomCode,
    this.propertyName,
  });

  factory OwnerPaymentModel.fromMap(Map<String, dynamic> json) {
    return OwnerPaymentModel(
      id: json['id'],
      paymentCode: json['payment_code']?.toString(),
      amount: json['amount'],
      method: json['method']?.toString(),
      status: json['status']?.toString(),
      paidAt: json['paid_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      bill: json['bill'] == null
          ? null
          : OwnerPaymentBillModel.fromMap(json['bill']),
      tenantName: json['tenant_name']?.toString(),
      roomCode: json['room_code']?.toString(),
      propertyName: json['property_name']?.toString(),
    );
  }

  String get amountRp => (amount ?? 0).currencyFormatRp;

  bool get isPaid => status == 'paid';

  String get statusLabel {
    if (status == 'paid') return 'Berhasil';
    if (status == 'pending') return 'Pending';
    if (status == 'failed') return 'Gagal';
    return status ?? '-';
  }

  Color get statusColor {
    if (status == 'paid') return const Color(0xff16A34A);
    if (status == 'pending') return const Color(0xffF59E0B);
    if (status == 'failed') return AppColors.red;
    return AppColors.primary;
  }

  String get methodLabel {
    if (method == 'simulation') return 'Simulasi';
    if (method == 'cash') return 'Cash';
    if (method == 'transfer') return 'Transfer';
    return method ?? '-';
  }
}

class OwnerPaymentBillModel {
  final int? id;
  final String? period;

  OwnerPaymentBillModel({this.id, this.period});

  factory OwnerPaymentBillModel.fromMap(Map<String, dynamic> json) {
    return OwnerPaymentBillModel(
      id: json['id'],
      period: json['period']?.toString(),
    );
  }
}
