import 'dart:convert';

class OwnerBillCreateRequestModel {
  final int rentalContractId;
  final String period;
  final num rentAmount;
  final num? electricityAmount;
  final num? waterAmount;
  final num? otherAmount;
  final String? otherDescription;
  final String dueDate;
  final String? notes;

  OwnerBillCreateRequestModel({
    required this.rentalContractId,
    required this.period,
    required this.rentAmount,
    this.electricityAmount,
    this.waterAmount,
    this.otherAmount,
    this.otherDescription,
    required this.dueDate,
    this.notes,
  });

  String toJson() => jsonEncode({
    'rental_contract_id': rentalContractId,
    'period': period,
    'rent_amount': rentAmount,
    if (electricityAmount != null) 'electricity_amount': electricityAmount,
    if (waterAmount != null) 'water_amount': waterAmount,
    if (otherAmount != null) 'other_amount': otherAmount,
    if (otherDescription != null && otherDescription!.isNotEmpty)
      'other_description': otherDescription,
    'due_date': dueDate,
    if (notes != null && notes!.isNotEmpty) 'notes': notes,
  });
}

class OwnerBillUpdateRequestModel {
  final num? electricityAmount;
  final num? waterAmount;
  final num? otherAmount;
  final String? otherDescription;
  final String? dueDate;
  final String? notes;

  OwnerBillUpdateRequestModel({
    this.electricityAmount,
    this.waterAmount,
    this.otherAmount,
    this.otherDescription,
    this.dueDate,
    this.notes,
  });

  String toJson() => jsonEncode({
    if (electricityAmount != null) 'electricity_amount': electricityAmount,
    if (waterAmount != null) 'water_amount': waterAmount,
    if (otherAmount != null) 'other_amount': otherAmount,
    if (otherDescription != null) 'other_description': otherDescription,
    if (dueDate != null) 'due_date': dueDate,
    if (notes != null) 'notes': notes,
  });
}
