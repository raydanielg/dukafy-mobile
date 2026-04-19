import 'package:equatable/equatable.dart';
import '../../core/enums/user_role.dart';

class User extends Equatable {
  final String id;
  final String? businessId;
  final String? branchId;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final UserRole role;
  final bool isActive;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime? lastLoginAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? permissions;
  final Map<String, dynamic>? metadata;

  const User({
    required this.id,
    this.businessId,
    this.branchId,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    required this.role,
    this.isActive = true,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    this.permissions,
    this.metadata,
  });

  User copyWith({
    String? id,
    String? businessId,
    String? branchId,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    UserRole? role,
    bool? isActive,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? permissions,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      permissions: permissions ?? this.permissions,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessId': businessId,
      'branchId': branchId,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'role': role.name,
      'isActive': isActive,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'permissions': permissions,
      'metadata': metadata,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      businessId: map['businessId'] as String?,
      branchId: map['branchId'] as String?,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      avatar: map['avatar'] as String?,
      role: UserRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => UserRole.cashier,
      ),
      isActive: map['isActive'] as bool? ?? true,
      isEmailVerified: map['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: map['isPhoneVerified'] as bool? ?? false,
      lastLoginAt: map['lastLoginAt'] != null
          ? DateTime.parse(map['lastLoginAt'] as String)
          : null,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      permissions: map['permissions'] as Map<String, dynamic>?,
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        businessId,
        branchId,
        name,
        email,
        phone,
        avatar,
        role,
        isActive,
        isEmailVerified,
        isPhoneVerified,
        lastLoginAt,
        createdAt,
        updatedAt,
        permissions,
        metadata,
      ];
}
