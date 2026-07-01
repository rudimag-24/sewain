import 'dart:convert';

class OwnerContractCreateRequestModel {
  final int roomId;
  final int tenantId;
  final String startDate;
  final String endDate;
  final num monthlyPrice;
  final num? deposit;
  final String? notes;

  OwnerContractCreateRequestModel({
    required this.roomId,
    required this.tenantId,
    required this.startDate,
    required this.endDate,
    required this.monthlyPrice,
    this.deposit,
    this.notes,
  });

  String toJson() => jsonEncode({
    'room_id': roomId,
    'tenant_id': tenantId,
    'start_date': startDate,
    'end_date': endDate,
    'monthly_price': monthlyPrice,
    if (deposit != null) 'deposit': deposit,
    if (notes != null && notes!.isNotEmpty) 'notes': notes,
  });
}

class OwnerContractUpdateRequestModel {
  final String? endDate;
  final num? monthlyPrice;
  final num? deposit;
  final String? notes;

  OwnerContractUpdateRequestModel({
    this.endDate,
    this.monthlyPrice,
    this.deposit,
    this.notes,
  });

  String toJson() => jsonEncode({
    if (endDate != null) 'end_date': endDate,
    if (monthlyPrice != null) 'monthly_price': monthlyPrice,
    if (deposit != null) 'deposit': deposit,
    if (notes != null) 'notes': notes,
  });
}
