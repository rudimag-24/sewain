import 'dart:convert';

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
      unpaidCount: json['unpaid_count'] ?? 0,
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
      id: json['id'],
      roomCode: json['room_code']?.toString(),
      propertyName: json['property_name']?.toString(),
      propertyAddress: json['property_address']?.toString(),
      endDate: json['end_date']?.toString(),
      remainingMonths: json['remaining_months'],
      monthlyPrice: json['monthly_price'],
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
      id: json['id'],
      period: json['period']?.toString(),
      totalAmount: json['total_amount'],
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
      id: json['id'],
      period: json['period']?.toString(),
      totalAmount: json['total_amount'],
      status: json['status']?.toString(),
      dueDate: json['due_date']?.toString(),
      paidAt: json['paid_at']?.toString(),
    );
  }
}
