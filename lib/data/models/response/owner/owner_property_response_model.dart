import 'dart:convert';

class OwnerPropertyListResponseModel {
  final List<OwnerPropertyModel> data;

  OwnerPropertyListResponseModel({required this.data});

  factory OwnerPropertyListResponseModel.fromJson(String str) =>
      OwnerPropertyListResponseModel.fromMap(jsonDecode(str));

  factory OwnerPropertyListResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerPropertyListResponseModel(
      data: (json['data'] as List? ?? [])
          .map((e) => OwnerPropertyModel.fromMap(e))
          .toList(),
    );
  }
}

class OwnerPropertyDetailResponseModel {
  final OwnerPropertyModel? data;

  OwnerPropertyDetailResponseModel({this.data});

  factory OwnerPropertyDetailResponseModel.fromJson(String str) =>
      OwnerPropertyDetailResponseModel.fromMap(jsonDecode(str));

  factory OwnerPropertyDetailResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerPropertyDetailResponseModel(
      data: json['data'] == null
          ? null
          : OwnerPropertyModel.fromMap(json['data']),
    );
  }
}

class OwnerPropertyActionResponseModel {
  final String message;
  final OwnerPropertyModel? data;

  OwnerPropertyActionResponseModel({required this.message, this.data});

  factory OwnerPropertyActionResponseModel.fromJson(String str) =>
      OwnerPropertyActionResponseModel.fromMap(jsonDecode(str));

  factory OwnerPropertyActionResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerPropertyActionResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] == null
          ? null
          : OwnerPropertyModel.fromMap(json['data']),
    );
  }
}

class OwnerPropertyToggleResponseModel {
  final String message;
  final String? status;

  OwnerPropertyToggleResponseModel({required this.message, this.status});

  factory OwnerPropertyToggleResponseModel.fromJson(String str) =>
      OwnerPropertyToggleResponseModel.fromMap(jsonDecode(str));

  factory OwnerPropertyToggleResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerPropertyToggleResponseModel(
      message: json['message']?.toString() ?? '',
      status: json['status']?.toString(),
    );
  }
}

class OwnerPropertyMessageResponseModel {
  final String message;

  OwnerPropertyMessageResponseModel({required this.message});

  factory OwnerPropertyMessageResponseModel.fromJson(String str) =>
      OwnerPropertyMessageResponseModel.fromMap(jsonDecode(str));

  factory OwnerPropertyMessageResponseModel.fromMap(Map<String, dynamic> json) {
    return OwnerPropertyMessageResponseModel(
      message: json['message']?.toString() ?? '',
    );
  }
}

class OwnerPropertyModel {
  final int? id;
  final int? ownerId;
  final String? name;
  final String? type;
  final String? address;
  final String? city;
  final String? province;
  final String? description;
  final String? status;
  final int roomsCount;
  final int availableRoomsCount;
  final int occupiedRoomsCount;
  final String? createdAt;
  final String? updatedAt;

  OwnerPropertyModel({
    this.id,
    this.ownerId,
    this.name,
    this.type,
    this.address,
    this.city,
    this.province,
    this.description,
    this.status,
    required this.roomsCount,
    required this.availableRoomsCount,
    required this.occupiedRoomsCount,
    this.createdAt,
    this.updatedAt,
  });

  factory OwnerPropertyModel.fromMap(Map<String, dynamic> json) {
    return OwnerPropertyModel(
      id: json['id'],
      ownerId: json['owner_id'],
      name: json['name']?.toString(),
      type: json['type']?.toString(),
      address: json['address']?.toString(),
      city: json['city']?.toString(),
      province: json['province']?.toString(),
      description: json['description']?.toString(),
      status: json['status']?.toString(),
      roomsCount: json['rooms_count'] ?? 0,
      availableRoomsCount: json['available_rooms_count'] ?? 0,
      occupiedRoomsCount: json['occupied_rooms_count'] ?? 0,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  bool get isActive => status == 'active';

  String get typeLabel {
    if (type == 'kos') return 'Kos';
    if (type == 'kontrakan') return 'Kontrakan';
    if (type == 'apartemen') return 'Apartemen';
    return type ?? '-';
  }

  String get statusLabel => isActive ? 'Aktif' : 'Nonaktif';
}
