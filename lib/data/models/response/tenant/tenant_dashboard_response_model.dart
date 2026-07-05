import 'dart:convert';

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

class TenantDashboardResponseModel {
  final bool hasContract;
  final String? message;
  final TenantContractSummaryModel? contract;
  final TenantCurrentBillModel? currentBill;
  final int unpaidCount;
  final List<TenantRecentBillModel> recentBills;

  TenantDashboardResponseModel({
    required this.hasContract,
    this.message,
    this.contract,
    this.currentBill,
    required this.unpaidCount,
    required this.recentBills,
  });

  factory TenantDashboardResponseModel.fromJson(String str) =>
      TenantDashboardResponseModel.fromMap(jsonDecode(str));

  factory TenantDashboardResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantDashboardResponseModel(
      hasContract: json['has_contract'] == true,
      message: json['message']?.toString(),
      contract: json['contract'] == null
          ? null
          : TenantContractSummaryModel.fromMap(json['contract']),
      currentBill: json['current_bill'] == null
          ? null
          : TenantCurrentBillModel.fromMap(json['current_bill']),
      unpaidCount: _toInt(json['unpaid_count']) ?? 0,
      recentBills: (json['recent_bills'] as List? ?? [])
          .map((e) => TenantRecentBillModel.fromMap(e))
          .toList(),
    );
  }
}

class TenantContractSummaryModel {
  final int? id;
  final String? roomCode;
  final String? propertyName;
  final String? propertyAddress;
  final String? endDate;
  final int? remainingMonths;
  final num? monthlyPrice;

  TenantContractSummaryModel({
    this.id,
    this.roomCode,
    this.propertyName,
    this.propertyAddress,
    this.endDate,
    this.remainingMonths,
    this.monthlyPrice,
  });

  factory TenantContractSummaryModel.fromMap(Map<String, dynamic> json) {
    return TenantContractSummaryModel(
      id: _toInt(json['id']),
      roomCode: json['room_code']?.toString(),
      propertyName: json['property_name']?.toString(),
      propertyAddress: json['property_address']?.toString(),
      endDate: json['end_date']?.toString(),
      remainingMonths: _toInt(json['remaining_months']),
      monthlyPrice: _toNum(json['monthly_price']),
    );
  }
}

class TenantCurrentBillModel {
  final int? id;
  final String? period;
  final num? totalAmount;
  final String? status;
  final String? dueDate;

  TenantCurrentBillModel({
    this.id,
    this.period,
    this.totalAmount,
    this.status,
    this.dueDate,
  });

  factory TenantCurrentBillModel.fromMap(Map<String, dynamic> json) {
    return TenantCurrentBillModel(
      id: _toInt(json['id']),
      period: json['period']?.toString(),
      totalAmount: _toNum(json['total_amount']),
      status: json['status']?.toString(),
      dueDate: json['due_date']?.toString(),
    );
  }
}

class TenantRecentBillModel {
  final int? id;
  final String? period;
  final num? totalAmount;
  final String? status;
  final String? dueDate;
  final String? paidAt;

  TenantRecentBillModel({
    this.id,
    this.period,
    this.totalAmount,
    this.status,
    this.dueDate,
    this.paidAt,
  });

  factory TenantRecentBillModel.fromMap(Map<String, dynamic> json) {
    return TenantRecentBillModel(
      id: _toInt(json['id']),
      period: json['period']?.toString(),
      totalAmount: _toNum(json['total_amount']),
      status: json['status']?.toString(),
      dueDate: json['due_date']?.toString(),
      paidAt: json['paid_at']?.toString(),
    );
  }
}
