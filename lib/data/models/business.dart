import 'package:equatable/equatable.dart';

class Business extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? logo;
  final String? taxNumber;
  final String? registrationNumber;
  final String? phone;
  final String? email;
  final String? website;
  final String? address;
  final String? city;
  final String? country;
  final String? currency;
  final String? timezone;
  final bool isMultiBranch;
  final int? maxBranches;
  final bool isActive;
  final String? subscriptionPlan;
  final DateTime? subscriptionExpiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? settings;
  final Map<String, dynamic>? metadata;

  const Business({
    required this.id,
    required this.name,
    this.description,
    this.logo,
    this.taxNumber,
    this.registrationNumber,
    this.phone,
    this.email,
    this.website,
    this.address,
    this.city,
    this.country,
    this.currency,
    this.timezone,
    this.isMultiBranch = false,
    this.maxBranches,
    this.isActive = true,
    this.subscriptionPlan,
    this.subscriptionExpiresAt,
    required this.createdAt,
    required this.updatedAt,
    this.settings,
    this.metadata,
  });

  Business copyWith({
    String? id,
    String? name,
    String? description,
    String? logo,
    String? taxNumber,
    String? registrationNumber,
    String? phone,
    String? email,
    String? website,
    String? address,
    String? city,
    String? country,
    String? currency,
    String? timezone,
    bool? isMultiBranch,
    int? maxBranches,
    bool? isActive,
    String? subscriptionPlan,
    DateTime? subscriptionExpiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? settings,
    Map<String, dynamic>? metadata,
  }) {
    return Business(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      taxNumber: taxNumber ?? this.taxNumber,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      currency: currency ?? this.currency,
      timezone: timezone ?? this.timezone,
      isMultiBranch: isMultiBranch ?? this.isMultiBranch,
      maxBranches: maxBranches ?? this.maxBranches,
      isActive: isActive ?? this.isActive,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      subscriptionExpiresAt: subscriptionExpiresAt ?? this.subscriptionExpiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      settings: settings ?? this.settings,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'taxNumber': taxNumber,
      'registrationNumber': registrationNumber,
      'phone': phone,
      'email': email,
      'website': website,
      'address': address,
      'city': city,
      'country': country,
      'currency': currency,
      'timezone': timezone,
      'isMultiBranch': isMultiBranch,
      'maxBranches': maxBranches,
      'isActive': isActive,
      'subscriptionPlan': subscriptionPlan,
      'subscriptionExpiresAt': subscriptionExpiresAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'settings': settings,
      'metadata': metadata,
    };
  }

  factory Business.fromMap(Map<String, dynamic> map) {
    return Business(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      logo: map['logo'] as String?,
      taxNumber: map['taxNumber'] as String?,
      registrationNumber: map['registrationNumber'] as String?,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      website: map['website'] as String?,
      address: map['address'] as String?,
      city: map['city'] as String?,
      country: map['country'] as String?,
      currency: map['currency'] as String?,
      timezone: map['timezone'] as String?,
      isMultiBranch: map['isMultiBranch'] as bool? ?? false,
      maxBranches: map['maxBranches'] as int?,
      isActive: map['isActive'] as bool? ?? true,
      subscriptionPlan: map['subscriptionPlan'] as String?,
      subscriptionExpiresAt: map['subscriptionExpiresAt'] != null
          ? DateTime.parse(map['subscriptionExpiresAt'] as String)
          : null,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      settings: map['settings'] as Map<String, dynamic>?,
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        logo,
        taxNumber,
        registrationNumber,
        phone,
        email,
        website,
        address,
        city,
        country,
        currency,
        timezone,
        isMultiBranch,
        maxBranches,
        isActive,
        subscriptionPlan,
        subscriptionExpiresAt,
        createdAt,
        updatedAt,
        settings,
        metadata,
      ];
}
