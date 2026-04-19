import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String businessId;
  final String? branchId;
  final String name;
  final String? description;
  final String? category;
  final String? sku;
  final String? barcode;
  final double buyingPrice;
  final double sellingPrice;
  final int quantity;
  final int? lowStockThreshold;
  final String? unit;
  final String? image;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? metadata;

  const Product({
    required this.id,
    required this.businessId,
    this.branchId,
    required this.name,
    this.description,
    this.category,
    this.sku,
    this.barcode,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.quantity,
    this.lowStockThreshold,
    this.unit,
    this.image,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  double get profitMargin => sellingPrice - buyingPrice;
  double get profitMarginPercentage => buyingPrice > 0 ? (profitMargin / buyingPrice) * 100 : 0;
  bool get isLowStock => lowStockThreshold != null && quantity <= lowStockThreshold!;
  double get totalValue => quantity * sellingPrice;
  double get totalCost => quantity * buyingPrice;
  double get potentialProfit => quantity * profitMargin;

  Product copyWith({
    String? id,
    String? businessId,
    String? branchId,
    String? name,
    String? description,
    String? category,
    String? sku,
    String? barcode,
    double? buyingPrice,
    double? sellingPrice,
    int? quantity,
    int? lowStockThreshold,
    String? unit,
    String? image,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Product(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      unit: unit ?? this.unit,
      image: image ?? this.image,
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
      'description': description,
      'category': category,
      'sku': sku,
      'barcode': barcode,
      'buyingPrice': buyingPrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
      'lowStockThreshold': lowStockThreshold,
      'unit': unit,
      'image': image,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      businessId: map['businessId'] as String,
      branchId: map['branchId'] as String?,
      name: map['name'] as String,
      description: map['description'] as String?,
      category: map['category'] as String?,
      sku: map['sku'] as String?,
      barcode: map['barcode'] as String?,
      buyingPrice: (map['buyingPrice'] as num).toDouble(),
      sellingPrice: (map['sellingPrice'] as num).toDouble(),
      quantity: map['quantity'] as int,
      lowStockThreshold: map['lowStockThreshold'] as int?,
      unit: map['unit'] as String?,
      image: map['image'] as String?,
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
        description,
        category,
        sku,
        barcode,
        buyingPrice,
        sellingPrice,
        quantity,
        lowStockThreshold,
        unit,
        image,
        isActive,
        createdAt,
        updatedAt,
        metadata,
      ];
}
