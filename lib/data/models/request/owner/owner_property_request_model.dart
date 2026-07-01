import 'dart:convert';

class OwnerPropertyRequestModel {
  final String? name;
  final String? type;
  final String? address;
  final String? city;
  final String? province;
  final String? description;

  OwnerPropertyRequestModel({
    this.name,
    this.type,
    this.address,
    this.city,
    this.province,
    this.description,
  });

  String toJson() => jsonEncode({
    if (name != null) 'name': name,
    if (type != null) 'type': type,
    if (address != null) 'address': address,
    if (city != null) 'city': city,
    if (province != null) 'province': province,
    if (description != null) 'description': description,
  });
}
