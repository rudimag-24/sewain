import 'dart:convert';

class TenantProfileUpdateRequestModel {
  final String? name;
  final String? phone;

  TenantProfileUpdateRequestModel({this.name, this.phone});

  String toJson() => jsonEncode({
    if (name != null) 'name': name,
    if (phone != null) 'phone': phone,
  });
}
