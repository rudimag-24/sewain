import 'dart:convert';

class TenantContractResponseModel {
  final String? message;
  final TenantContractModel? data;

  TenantContractResponseModel({this.message, this.data});

  factory TenantContractResponseModel.fromJson(String str) =>
      TenantContractResponseModel.fromMap(jsonDecode(str));

  factory TenantContractResponseModel.fromMap(Map<String, dynamic> json) {
    return TenantContractResponseModel(
      message: json['message']?.toString(),
      data: json['data'] == null
          ? null
          : TenantContractModel.fromMap(json['data']),
    );
  }
}

class TenantContractModel {
  final int? id;
  final String? startDate;
  final String? endDate;
  final num? monthlyPrice;
  final num? deposit;
  final String? status;
  final int? remainingMonths;
  final String? notes;
  final TenantContractRoomModel? room;
  final TenantContractPropertyModel? property;
  final TenantContractOwnerModel? owner;

  TenantContractModel({
    this.id,
    this.startDate,
    this.endDate,
    this.monthlyPrice,
    this.deposit,
    this.status,
    this.remainingMonths,
    this.notes,
    this.room,
    this.property,
    this.owner,
  });

  factory TenantContractModel.fromMap(Map<String, dynamic> json) {
    return TenantContractModel(
      id: json['id'],
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      monthlyPrice: json['monthly_price'],
      deposit: json['deposit'],
      status: json['status']?.toString(),
      remainingMonths: json['remaining_months'],
      notes: json['notes']?.toString(),
      room: json['room'] == null
          ? null
          : TenantContractRoomModel.fromMap(json['room']),
      property: json['property'] == null
          ? null
          : TenantContractPropertyModel.fromMap(json['property']),
      owner: json['owner'] == null
          ? null
          : TenantContractOwnerModel.fromMap(json['owner']),
    );
  }
}

class TenantContractRoomModel {
  final String? code;
  final String? description;

  TenantContractRoomModel({this.code, this.description});

  factory TenantContractRoomModel.fromMap(Map<String, dynamic> json) {
    return TenantContractRoomModel(
      code: json['code']?.toString(),
      description: json['description']?.toString(),
    );
  }
}

class TenantContractPropertyModel {
  final String? name;
  final String? type;
  final String? address;
  final String? city;
  final String? province;

  TenantContractPropertyModel({
    this.name,
    this.type,
    this.address,
    this.city,
    this.province,
  });

  factory TenantContractPropertyModel.fromMap(Map<String, dynamic> json) {
    return TenantContractPropertyModel(
      name: json['name']?.toString(),
      type: json['type']?.toString(),
      address: json['address']?.toString(),
      city: json['city']?.toString(),
      province: json['province']?.toString(),
    );
  }
}

class TenantContractOwnerModel {
  final String? name;
  final String? phone;
  final String? email;

  TenantContractOwnerModel({this.name, this.phone, this.email});

  factory TenantContractOwnerModel.fromMap(Map<String, dynamic> json) {
    return TenantContractOwnerModel(
      name: json['name']?.toString(),
      phone: json['phone']?.toString(),
      email: json['email']?.toString(),
    );
  }
}
