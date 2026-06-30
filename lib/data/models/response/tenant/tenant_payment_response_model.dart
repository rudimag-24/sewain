import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sewain/core/core.dart';

class TenantPaymentListResponseModel {
  final List<TenantPaymentModel> data;

  TenantPaymentListResponseModel({required this.data});

  factory TenantPaymentListResponseModel.fromJson(String str) =>
      TenantPaymentListResponseModel.fromMap(jsonDecode(str));

  factory TenantPaymentListResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantPaymentListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => TenantPaymentModel.fromMap(e))
          .toList(),
    );
  }
}

class TenantPaymentActionResponseModel {
  final String message;
  final TenantPaymentModel? data;

  TenantPaymentActionResponseModel({required this.message, this.data});

  factory TenantPaymentActionResponseModel.fromJson(String str) =>
      TenantPaymentActionResponseModel.fromMap(jsonDecode(str));

  factory TenantPaymentActionResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantPaymentActionResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null
          ? null
          : TenantPaymentModel.fromMap(json['data']),
    );
  }
}

class TenantPaymentReceiptResponseModel {
  final TenantPaymentReceiptModel? data;

  TenantPaymentReceiptResponseModel({this.data});

  factory TenantPaymentReceiptResponseModel.fromJson(String str) =>
      TenantPaymentReceiptResponseModel.fromMap(jsonDecode(str));

  factory TenantPaymentReceiptResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantPaymentReceiptResponseModel(
      data: json['data'] == null
          ? null
          : TenantPaymentReceiptModel.fromMap(json['data']),
    );
  }
}

class TenantPaymentModel {
  final int? id;
  final String? paymentCode;
  final num? amount;
  final String? method;
  final String? status;
  final String? paidAt;
  final String? createdAt;
  final String? billPeriod;
  final int? billId;

  TenantPaymentModel({
    this.id,
    this.paymentCode,
    this.amount,
    this.method,
    this.status,
    this.paidAt,
    this.createdAt,
    this.billPeriod,
    this.billId,
  });

  factory TenantPaymentModel.fromMap(Map<String, dynamic> json) {
    return TenantPaymentModel(
      id: json['id'],
      paymentCode: json['payment_code']?.toString(),
      amount: json['amount'],
      method: json['method']?.toString(),
      status: json['status']?.toString(),
      paidAt: json['paid_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      billPeriod: json['bill_period']?.toString(),
      billId: json['bill_id'],
    );
  }

  bool get isPaid => status == 'paid';

  String get amountRp => (amount ?? 0).currencyFormatRp;

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
}

class TenantPaymentReceiptModel {
  final String? paymentCode;
  final num? amount;
  final String? method;
  final String? status;
  final String? paidAt;
  final TenantReceiptBillModel? bill;
  final String? unit;
  final String? property;
  final String? tenant;

  TenantPaymentReceiptModel({
    this.paymentCode,
    this.amount,
    this.method,
    this.status,
    this.paidAt,
    this.bill,
    this.unit,
    this.property,
    this.tenant,
  });

  factory TenantPaymentReceiptModel.fromMap(Map<String, dynamic> json) {
    return TenantPaymentReceiptModel(
      paymentCode: json['payment_code']?.toString(),
      amount: json['amount'],
      method: json['method']?.toString(),
      status: json['status']?.toString(),
      paidAt: json['paid_at']?.toString(),
      bill: json['bill'] == null
          ? null
          : TenantReceiptBillModel.fromMap(json['bill']),
      unit: json['unit']?.toString(),
      property: json['property']?.toString(),
      tenant: json['tenant']?.toString(),
    );
  }

  String get amountRp => (amount ?? 0).currencyFormatRp;
}

class TenantReceiptBillModel {
  final String? period;
  final String? dueDate;
  final TenantReceiptBreakdownModel? breakdown;

  TenantReceiptBillModel({this.period, this.dueDate, this.breakdown});

  factory TenantReceiptBillModel.fromMap(Map<String, dynamic> json) {
    return TenantReceiptBillModel(
      period: json['period']?.toString(),
      dueDate: json['due_date']?.toString(),
      breakdown: json['breakdown'] == null
          ? null
          : TenantReceiptBreakdownModel.fromMap(json['breakdown']),
    );
  }
}

class TenantReceiptBreakdownModel {
  final num? rent;
  final num? electricity;
  final num? water;
  final num? other;
  final num? total;

  TenantReceiptBreakdownModel({
    this.rent,
    this.electricity,
    this.water,
    this.other,
    this.total,
  });

  factory TenantReceiptBreakdownModel.fromMap(Map<String, dynamic> json) {
    return TenantReceiptBreakdownModel(
      rent: json['rent'],
      electricity: json['electricity'],
      water: json['water'],
      other: json['other'],
      total: json['total'],
    );
  }

  String get rentRp => (rent ?? 0).currencyFormatRp;
  String get electricityRp => (electricity ?? 0).currencyFormatRp;
  String get waterRp => (water ?? 0).currencyFormatRp;
  String get otherRp => (other ?? 0).currencyFormatRp;
  String get totalRp => (total ?? 0).currencyFormatRp;
}
