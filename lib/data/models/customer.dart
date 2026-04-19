import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String businessId;
  final String? branchId;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final double? creditLimit;
  final double currentCredit;
  final double totalPurchases;
  final int totalTransactions;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? metadata;

  const Customer({
    required this.id,
    required this.businessId,
    this.branchId,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.creditLimit,
    this.currentCredit = 0,
    this.totalPurchases = 0,
    this.totalTransactions = 0,
    this.notes,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  double get availableCredit => (creditLimit ?? 0) - currentCredit;
  bool get hasCredit => currentCredit > 0;
  bool get hasCreditLimit => creditLimit != null && creditLimit! > 0;
  bool get isCreditLimitReached => hasCreditLimit && currentCredit >= creditLimit!;
  double get averagePurchase => totalTransactions > 0 ? totalPurchases / totalTransactions : 0;

  Customer copyWith({
    String? id,
    String? businessId,
    String? branchId,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? city,
    double? creditLimit,
    double? currentCredit,
    double? totalPurchases,
    int? totalTransactions,
    String? notes,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Customer(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      creditLimit: creditLimit ?? this.creditLimit,
      currentCredit: currentCredit ?? this.currentCredit,
      totalPurchases: totalPurchases ?? this.totalPurchases,
      totalTransactions: totalTransactions ?? this.totalTransactions,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      'address': address,
      'city': city,
      'creditLimit': creditLimit,
      'currentCredit': currentCredit,
      'totalPurchases': totalPurchases,
      'totalTransactions': totalTransactions,
      'notes': notes,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as String,
      businessId: map['businessId'] as String,
      branchId: map['branchId'] as String?,
      name: map['name'] as String,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      address: map['address'] as String?,
      city: map['city'] as String?,
      creditLimit: (map['creditLimit'] as num?)?.toDouble(),
      currentCredit: (map['currentCredit'] as num?)?.toDouble() ?? 0,
      totalPurchases: (map['totalPurchases'] as num?)?.toDouble() ?? 0,
      totalTransactions: map['totalTransactions'] as int? ?? 0,
      notes: map['notes'] as String?,
      isActive: map['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
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
        address,
        city,
        creditLimit,
        currentCredit,
        totalPurchases,
        totalTransactions,
        notes,
        isActive,
        createdAt,
        updatedAt,
        metadata,
      ];
}
