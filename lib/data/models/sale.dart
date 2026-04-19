import 'package:equatable/equatable.dart';
import '../../core/enums/payment_method.dart';
import 'product.dart';

class SaleItem extends Equatable {
  final String id;
  final String productId;
  final String productName;
  final double buyingPrice;
  final double sellingPrice;
  final int quantity;
  final double discount;
  final double total;
  final Product? product;

  const SaleItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.quantity,
    this.discount = 0,
    required this.total,
    this.product,
  });

  double get subtotal => sellingPrice * quantity;
  double get profit => (sellingPrice - buyingPrice) * quantity - discount;

  SaleItem copyWith({
    String? id,
    String? productId,
    String? productName,
    double? buyingPrice,
    double? sellingPrice,
    int? quantity,
    double? discount,
    double? total,
    Product? product,
  }) {
    return SaleItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'buyingPrice': buyingPrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
      'discount': discount,
      'total': total,
    };
  }

  factory SaleItem.fromMap(Map<String, dynamic> map) {
    return SaleItem(
      id: map['id'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      buyingPrice: (map['buyingPrice'] as num).toDouble(),
      sellingPrice: (map['sellingPrice'] as num).toDouble(),
      quantity: map['quantity'] as int,
      discount: (map['discount'] as num?)?.toDouble() ?? 0,
      total: (map['total'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        buyingPrice,
        sellingPrice,
        quantity,
        discount,
        total,
        product,
      ];
}

class Sale extends Equatable {
  final String id;
  final String businessId;
  final String? branchId;
  final String? customerId;
  final String? customerName;
  final String? userId;
  final String? userName;
  final List<SaleItem> items;
  final double subtotal;
  final double discount;
  final double tax;
  final double total;
  final double totalCost;
  final double profit;
  final PaymentMethod paymentMethod;
  final double? amountPaid;
  final double? change;
  final String? receiptNumber;
  final String? notes;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  const Sale({
    required this.id,
    required this.businessId,
    this.branchId,
    this.customerId,
    this.customerName,
    this.userId,
    this.userName,
    required this.items,
    required this.subtotal,
    this.discount = 0,
    this.tax = 0,
    required this.total,
    required this.totalCost,
    required this.profit,
    required this.paymentMethod,
    this.amountPaid,
    this.change,
    this.receiptNumber,
    this.notes,
    this.isSynced = false,
    required this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  double get totalDiscount => items.fold(0, (sum, item) => sum + item.discount) + discount;
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  bool get isCredit => paymentMethod == PaymentMethod.credit;
  double get creditAmount => isCredit ? total - (amountPaid ?? 0) : 0;
  bool get hasCredit => creditAmount > 0;

  Sale copyWith({
    String? id,
    String? businessId,
    String? branchId,
    String? customerId,
    String? customerName,
    String? userId,
    String? userName,
    List<SaleItem>? items,
    double? subtotal,
    double? discount,
    double? tax,
    double? total,
    double? totalCost,
    double? profit,
    PaymentMethod? paymentMethod,
    double? amountPaid,
    double? change,
    String? receiptNumber,
    String? notes,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Sale(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      totalCost: totalCost ?? this.totalCost,
      profit: profit ?? this.profit,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amountPaid: amountPaid ?? this.amountPaid,
      change: change ?? this.change,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      notes: notes ?? this.notes,
      isSynced: isSynced ?? this.isSynced,
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
      'customerId': customerId,
      'customerName': customerName,
      'userId': userId,
      'userName': userName,
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'tax': tax,
      'total': total,
      'totalCost': totalCost,
      'profit': profit,
      'paymentMethod': paymentMethod.name,
      'amountPaid': amountPaid,
      'change': change,
      'receiptNumber': receiptNumber,
      'notes': notes,
      'isSynced': isSynced,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] as String,
      businessId: map['businessId'] as String,
      branchId: map['branchId'] as String?,
      customerId: map['customerId'] as String?,
      customerName: map['customerName'] as String?,
      userId: map['userId'] as String?,
      userName: map['userName'] as String?,
      items: (map['items'] as List<dynamic>)
          .map((item) => SaleItem.fromMap(item as Map<String, dynamic>))
          .toList(),
      subtotal: (map['subtotal'] as num).toDouble(),
      discount: (map['discount'] as num?)?.toDouble() ?? 0,
      tax: (map['tax'] as num?)?.toDouble() ?? 0,
      total: (map['total'] as num).toDouble(),
      totalCost: (map['totalCost'] as num).toDouble(),
      profit: (map['profit'] as num).toDouble(),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == map['paymentMethod'],
        orElse: () => PaymentMethod.cash,
      ),
      amountPaid: (map['amountPaid'] as num?)?.toDouble(),
      change: (map['change'] as num?)?.toDouble(),
      receiptNumber: map['receiptNumber'] as String?,
      notes: map['notes'] as String?,
      isSynced: map['isSynced'] as bool? ?? false,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        businessId,
        branchId,
        customerId,
        customerName,
        userId,
        userName,
        items,
        subtotal,
        discount,
        tax,
        total,
        totalCost,
        profit,
        paymentMethod,
        amountPaid,
        change,
        receiptNumber,
        notes,
        isSynced,
        createdAt,
        updatedAt,
        metadata,
      ];
}
