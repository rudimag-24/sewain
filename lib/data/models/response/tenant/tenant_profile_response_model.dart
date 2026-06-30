import 'dart:convert';

class TenantProfileResponseModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? status;
  final TenantActiveContractModel? activeContract;

  TenantProfileResponseModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.status,
    this.activeContract,
  });

  factory TenantProfileResponseModel.fromJson(String str) =>
      TenantProfileResponseModel.fromMap(jsonDecode(str));

  factory TenantProfileResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantProfileResponseModel(
      id: json['id'],
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      role: json['role']?.toString(),
      status: json['status']?.toString(),
      activeContract: json['active_contract'] == null
          ? null
          : TenantActiveContractModel.fromMap(json['active_contract']),
    );
  }
}

class TenantActiveContractModel {
  final String? unit;
  final String? property;
  final String? address;
  final String? endDate;
  final num? monthlyPrice;

  TenantActiveContractModel({
    this.unit,
    this.property,
    this.address,
    this.endDate,
    this.monthlyPrice,
  });

  factory TenantActiveContractModel.fromMap(Map<String, dynamic> json) {
    return TenantActiveContractModel(
      unit: json['unit']?.toString(),
      property: json['property']?.toString(),
      address: json['address']?.toString(),
      endDate: json['end_date']?.toString(),
      monthlyPrice: json['monthly_price'],
    );
  }
}

class TenantProfileUpdateResponseModel {
  final String message;
  final TenantProfileUpdateDataModel? data;

  TenantProfileUpdateResponseModel({required this.message, this.data});

  factory TenantProfileUpdateResponseModel.fromJson(String str) =>
      TenantProfileUpdateResponseModel.fromMap(jsonDecode(str));

  factory TenantProfileUpdateResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantProfileUpdateResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null
          ? null
          : TenantProfileUpdateDataModel.fromMap(json['data']),
    );
  }
}

class TenantProfileUpdateDataModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;

  TenantProfileUpdateDataModel({this.id, this.name, this.email, this.phone});

  factory TenantProfileUpdateDataModel.fromMap(Map<String, dynamic> json) {
    return TenantProfileUpdateDataModel(
      id: json['id'],
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
    );
  }
}
