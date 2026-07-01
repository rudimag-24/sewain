import 'dart:convert';

class OwnerRoomRequestModel {
  final String? code;
  final num? pricePerMonth;
  final String? description;

  OwnerRoomRequestModel({this.code, this.pricePerMonth, this.description});

  String toJson() => jsonEncode({
    if (code != null) 'code': code,
    if (pricePerMonth != null) 'price_per_month': pricePerMonth,
    if (description != null) 'description': description,
  });
}
