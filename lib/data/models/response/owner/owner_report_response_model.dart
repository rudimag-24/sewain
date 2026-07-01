import 'dart:convert';
import 'package:sewain/core/core.dart';

class OwnerReportResponseModel {
  final OwnerReportOccupancyModel? occupancy;
  final OwnerReportCurrentMonthModel? currentMonth;
  final List<OwnerMonthlyReportModel> monthlyReport;

  OwnerReportResponseModel({
    this.occupancy,
    this.currentMonth,
    required this.monthlyReport,
  });

  factory OwnerReportResponseModel.fromJson(String str) =>
      OwnerReportResponseModel.fromMap(jsonDecode(str));

  factory OwnerReportResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerReportResponseModel(
      occupancy: json['occupancy'] == null
          ? null
          : OwnerReportOccupancyModel.fromMap(json['occupancy']),
      currentMonth: json['current_month'] == null
          ? null
          : OwnerReportCurrentMonthModel.fromMap(json['current_month']),
      monthlyReport: (json['monthly_report'] as List? ?? [])
          .map((e) => OwnerMonthlyReportModel.fromMap(e))
          .toList(),
    );
  }
}

class OwnerReportOccupancyModel {
  final int totalRooms;
  final int occupiedRooms;
  final int availableRooms;
  final num occupancyRate;

  OwnerReportOccupancyModel({
    required this.totalRooms,
    required this.occupiedRooms,
    required this.availableRooms,
    required this.occupancyRate,
  });

  factory OwnerReportOccupancyModel.fromMap(Map<String, dynamic> json) {
    return OwnerReportOccupancyModel(
      totalRooms: json['total_rooms'] ?? 0,
      occupiedRooms: json['occupied_rooms'] ?? 0,
      availableRooms: json['available_rooms'] ?? 0,
      occupancyRate: json['occupancy_rate'] ?? 0,
    );
  }
}

class OwnerReportCurrentMonthModel {
  final String? period;
  final int totalBills;
  final num paid;
  final num unpaid;

  OwnerReportCurrentMonthModel({
    this.period,
    required this.totalBills,
    required this.paid,
    required this.unpaid,
  });

  factory OwnerReportCurrentMonthModel.fromMap(Map<String, dynamic> json) {
    return OwnerReportCurrentMonthModel(
      period: json['period']?.toString(),
      totalBills: json['total_bills'] ?? 0,
      paid: json['paid'] ?? 0,
      unpaid: json['unpaid'] ?? 0,
    );
  }

  String get paidRp => paid.currencyFormatRp;
  String get unpaidRp => unpaid.currencyFormatRp;
}

class OwnerMonthlyReportModel {
  final String? period;
  final int totalBills;
  final int paidBills;
  final int unpaidBills;
  final num income;
  final num pendingAmount;

  OwnerMonthlyReportModel({
    this.period,
    required this.totalBills,
    required this.paidBills,
    required this.unpaidBills,
    required this.income,
    required this.pendingAmount,
  });

  factory OwnerMonthlyReportModel.fromMap(Map<String, dynamic> json) {
    return OwnerMonthlyReportModel(
      period: json['period']?.toString(),
      totalBills: json['total_bills'] ?? 0,
      paidBills: json['paid_bills'] ?? 0,
      unpaidBills: json['unpaid_bills'] ?? 0,
      income: json['income'] ?? 0,
      pendingAmount: json['pending_amount'] ?? 0,
    );
  }

  String get incomeRp => income.currencyFormatRp;
  String get pendingAmountRp => pendingAmount.currencyFormatRp;
}
