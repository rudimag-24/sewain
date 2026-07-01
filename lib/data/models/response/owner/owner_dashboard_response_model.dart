import 'dart:convert';
import 'package:sewain/core/core.dart';

class OwnerDashboardResponseModel {
  final OwnerDashboardStatsModel? stats;
  final List<OwnerRecentBillModel> recentBills;
  final List<OwnerPendingRequestModel> pendingRequests;

  OwnerDashboardResponseModel({
    this.stats,
    required this.recentBills,
    required this.pendingRequests,
  });

  factory OwnerDashboardResponseModel.fromJson(String str) =>
      OwnerDashboardResponseModel.fromMap(jsonDecode(str));

  factory OwnerDashboardResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerDashboardResponseModel(
      stats: json['stats'] == null
          ? null
          : OwnerDashboardStatsModel.fromMap(json['stats']),
      recentBills: (json['recent_bills'] as List? ?? [])
          .map((e) => OwnerRecentBillModel.fromMap(e))
          .toList(),
      pendingRequests: (json['pending_requests'] as List? ?? [])
          .map((e) => OwnerPendingRequestModel.fromMap(e))
          .toList(),
    );
  }
}

class OwnerDashboardStatsModel {
  final int totalProperties;
  final int totalRooms;
  final int occupiedRooms;
  final int availableRooms;
  final int activeTenants;
  final int billsThisMonth;
  final int paidBills;
  final int unpaidBills;
  final num totalIncome;
  final num totalPending;

  OwnerDashboardStatsModel({
    required this.totalProperties,
    required this.totalRooms,
    required this.occupiedRooms,
    required this.availableRooms,
    required this.activeTenants,
    required this.billsThisMonth,
    required this.paidBills,
    required this.unpaidBills,
    required this.totalIncome,
    required this.totalPending,
  });

  factory OwnerDashboardStatsModel.fromMap(Map<String, dynamic> json) {
    return OwnerDashboardStatsModel(
      totalProperties: json['total_properties'] ?? 0,
      totalRooms: json['total_rooms'] ?? 0,
      occupiedRooms: json['occupied_rooms'] ?? 0,
      availableRooms: json['available_rooms'] ?? 0,
      activeTenants: json['active_tenants'] ?? 0,
      billsThisMonth: json['bills_this_month'] ?? 0,
      paidBills: json['paid_bills'] ?? 0,
      unpaidBills: json['unpaid_bills'] ?? 0,
      totalIncome: json['total_income'] ?? 0,
      totalPending: json['total_pending'] ?? 0,
    );
  }

  String get totalIncomeRp => totalIncome.currencyFormatRp;
  String get totalPendingRp => totalPending.currencyFormatRp;
}

class OwnerRecentBillModel {
  final int? id;
  final String? period;
  final num? totalAmount;
  final String? status;
  final String? dueDate;
  final String? tenantName;
  final String? roomCode;
  final String? propertyName;

  OwnerRecentBillModel({
    this.id,
    this.period,
    this.totalAmount,
    this.status,
    this.dueDate,
    this.tenantName,
    this.roomCode,
    this.propertyName,
  });

  factory OwnerRecentBillModel.fromMap(Map<String, dynamic> json) {
    return OwnerRecentBillModel(
      id: json['id'],
      period: json['period']?.toString(),
      totalAmount: json['total_amount'],
      status: json['status']?.toString(),
      dueDate: json['due_date']?.toString(),
      tenantName: json['tenant_name']?.toString(),
      roomCode: json['room_code']?.toString(),
      propertyName: json['property_name']?.toString(),
    );
  }

  String get totalAmountRp => (totalAmount ?? 0).currencyFormatRp;

  String get statusLabel {
    if (status == 'paid') return 'Lunas';
    if (status == 'pending') return 'Pending';
    if (status == 'unpaid') return 'Belum Bayar';
    return status ?? '-';
  }
}

class OwnerPendingRequestModel {
  final int? id;
  final String? type;
  final String? tenantName;
  final String? createdAt;

  OwnerPendingRequestModel({
    this.id,
    this.type,
    this.tenantName,
    this.createdAt,
  });

  factory OwnerPendingRequestModel.fromMap(Map<String, dynamic> json) {
    return OwnerPendingRequestModel(
      id: json['id'],
      type: json['type']?.toString(),
      tenantName: json['tenant_name']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }

  String get typeLabel {
    if (type == 'extend') return 'Perpanjangan';
    if (type == 'stop') return 'Stop Kos';
    return type ?? '-';
  }
}
