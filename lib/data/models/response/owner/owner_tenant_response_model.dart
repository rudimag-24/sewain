import 'dart:convert';
import 'package:sewain/core/core.dart';

class OwnerTenantListResponseModel {
  final List<OwnerTenantModel> data;

  OwnerTenantListResponseModel({required this.data});

  factory OwnerTenantListResponseModel.fromJson(String str) =>
      OwnerTenantListResponseModel.fromMap(jsonDecode(str));

  factory OwnerTenantListResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => OwnerTenantModel.fromMap(e))
          .toList(),
    );
  }
}

class OwnerTenantDetailResponseModel {
  final OwnerTenantModel? data;

  OwnerTenantDetailResponseModel({this.data});

  factory OwnerTenantDetailResponseModel.fromJson(String str) =>
      OwnerTenantDetailResponseModel.fromMap(jsonDecode(str));

  factory OwnerTenantDetailResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantDetailResponseModel(
      data: json['data'] == null
          ? null
          : OwnerTenantModel.fromMap(json['data']),
    );
  }
}

class OwnerTenantActionResponseModel {
  final String message;
  final OwnerTenantModel? data;

  OwnerTenantActionResponseModel({required this.message, this.data});

  factory OwnerTenantActionResponseModel.fromJson(String str) =>
      OwnerTenantActionResponseModel.fromMap(jsonDecode(str));

  factory OwnerTenantActionResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantActionResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null
          ? null
          : OwnerTenantModel.fromMap(json['data']),
    );
  }
}

class OwnerTenantMessageResponseModel {
  final String message;

  OwnerTenantMessageResponseModel({required this.message});

  factory OwnerTenantMessageResponseModel.fromJson(String str) =>
      OwnerTenantMessageResponseModel.fromMap(jsonDecode(str));

  factory OwnerTenantMessageResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantMessageResponseModel(
      message: json['message']?.toString() ?? '',
    );
  }
}

class OwnerTenantModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? status;
  final OwnerTenantActiveContractModel? activeContract;
  final List<OwnerTenantRentalContractModel> rentalContracts;
  final String? createdAt;
  final String? updatedAt;

  OwnerTenantModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.status,
    this.activeContract,
    required this.rentalContracts,
    this.createdAt,
    this.updatedAt,
  });

  factory OwnerTenantModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantModel(
      id: json['id'],
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      role: json['role']?.toString(),
      status: json['status']?.toString(),
      activeContract: json['active_contract'] == null
          ? null
          : OwnerTenantActiveContractModel.fromMap(json['active_contract']),
      rentalContracts: (json['rental_contracts'] as List? ?? [])
          .map((e) => OwnerTenantRentalContractModel.fromMap(e))
          .toList(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  String get safeName => name?.isNotEmpty == true ? name! : '-';
  String get safeEmail => email?.isNotEmpty == true ? email! : '-';
  String get safePhone => phone?.isNotEmpty == true ? phone! : '-';
  bool get isActive => status == 'active';
}

class OwnerTenantActiveContractModel {
  final int? id;
  final String? roomCode;
  final String? propertyName;
  final String? endDate;
  final num? monthlyPrice;

  OwnerTenantActiveContractModel({
    this.id,
    this.roomCode,
    this.propertyName,
    this.endDate,
    this.monthlyPrice,
  });

  factory OwnerTenantActiveContractModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantActiveContractModel(
      id: json['id'],
      roomCode: json['room_code']?.toString(),
      propertyName: json['property_name']?.toString(),
      endDate: json['end_date']?.toString(),
      monthlyPrice: json['monthly_price'],
    );
  }

  String get monthlyPriceRp => (monthlyPrice ?? 0).currencyFormatRp;
}

class OwnerTenantRentalContractModel {
  final int? id;
  final int? tenantId;
  final int? roomId;
  final String? startDate;
  final String? endDate;
  final num? monthlyPrice;
  final num? deposit;
  final String? status;
  final OwnerTenantRoomModel? room;

  OwnerTenantRentalContractModel({
    this.id,
    this.tenantId,
    this.roomId,
    this.startDate,
    this.endDate,
    this.monthlyPrice,
    this.deposit,
    this.status,
    this.room,
  });

  factory OwnerTenantRentalContractModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantRentalContractModel(
      id: json['id'],
      tenantId: json['tenant_id'],
      roomId: json['room_id'],
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      monthlyPrice: json['monthly_price'],
      deposit: json['deposit'],
      status: json['status']?.toString(),
      room: json['room'] == null
          ? null
          : OwnerTenantRoomModel.fromMap(json['room']),
    );
  }

  String get monthlyPriceRp => (monthlyPrice ?? 0).currencyFormatRp;
  String get depositRp => (deposit ?? 0).currencyFormatRp;
}

class OwnerTenantRoomModel {
  final int? id;
  final int? propertyId;
  final String? code;
  final num? pricePerMonth;
  final String? description;
  final String? status;
  final OwnerTenantPropertyModel? property;

  OwnerTenantRoomModel({
    this.id,
    this.propertyId,
    this.code,
    this.pricePerMonth,
    this.description,
    this.status,
    this.property,
  });

  factory OwnerTenantRoomModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantRoomModel(
      id: json['id'],
      propertyId: json['property_id'],
      code: json['code']?.toString(),
      pricePerMonth: json['price_per_month'],
      description: json['description']?.toString(),
      status: json['status']?.toString(),
      property: json['property'] == null
          ? null
          : OwnerTenantPropertyModel.fromMap(json['property']),
    );
  }
}

class OwnerTenantPropertyModel {
  final int? id;
  final String? name;
  final String? type;
  final String? address;
  final String? city;
  final String? province;

  OwnerTenantPropertyModel({
    this.id,
    this.name,
    this.type,
    this.address,
    this.city,
    this.province,
  });

  factory OwnerTenantPropertyModel.fromMap(Map<String, dynamic> json) {
    return OwnerTenantPropertyModel(
      id: json['id'],
      name: json['name']?.toString(),
      type: json['type']?.toString(),
      address: json['address']?.toString(),
      city: json['city']?.toString(),
      province: json['province']?.toString(),
    );
  }
}
