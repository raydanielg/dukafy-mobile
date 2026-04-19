import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String id;
  final String businessId;
  final String name;
  final String? code;
  final String? address;
  final String? city;
  final String? phone;
  final String? email;
  final String? managerId;
  final String? managerName;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? settings;
  final Map<String, dynamic>? metadata;

  const Branch({
    required this.id,
    required this.businessId,
    required this.name,
    this.code,
    this.address,
    this.city,
    this.phone,
    this.email,
    this.managerId,
    this.managerName,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.settings,
    this.metadata,
  });

  Branch copyWith({
    String? id,
    String? businessId,
    String? name,
    String? code,
    String? address,
    String? city,
    String? phone,
    String? email,
    String? managerId,
    String? managerName,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? settings,
    Map<String, dynamic>? metadata,
  }) {
    return Branch(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      code: code ?? this.code,
      address: address ?? this.address,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      managerId: managerId ?? this.managerId,
      managerName: managerName ?? this.managerName,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      settings: settings ?? this.settings,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessId': businessId,
      'name': name,
      'code': code,
      'address': address,
      'city': city,
      'phone': phone,
      'email': email,
      'managerId': managerId,
      'managerName': managerName,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'settings': settings,
      'metadata': metadata,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map['id'] as String,
      businessId: map['businessId'] as String,
      name: map['name'] as String,
      code: map['code'] as String?,
      address: map['address'] as String?,
      city: map['city'] as String?,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      managerId: map['managerId'] as String?,
      managerName: map['managerName'] as String?,
      isActive: map['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      settings: map['settings'] as Map<String, dynamic>?,
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        businessId,
        name,
        code,
        address,
        city,
        phone,
        email,
        managerId,
        managerName,
        isActive,
        createdAt,
        updatedAt,
        settings,
        metadata,
      ];
}
