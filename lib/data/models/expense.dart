import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final String id;
  final String businessId;
  final String? branchId;
  final String category;
  final String description;
  final double amount;
  final DateTime date;
  final String? receiptNumber;
  final String? receiptImage;
  final String? notes;
  final String? userId;
  final String? userName;
  final bool isRecurring;
  final String? recurringFrequency; // daily, weekly, monthly, yearly
  final DateTime? nextRecurringDate;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  const Expense({
    required this.id,
    required this.businessId,
    this.branchId,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    this.receiptNumber,
    this.receiptImage,
    this.notes,
    this.userId,
    this.userName,
    this.isRecurring = false,
    this.recurringFrequency,
    this.nextRecurringDate,
    this.isSynced = false,
    required this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  Expense copyWith({
    String? id,
    String? businessId,
    String? branchId,
    String? category,
    String? description,
    double? amount,
    DateTime? date,
    String? receiptNumber,
    String? receiptImage,
    String? notes,
    String? userId,
    String? userName,
    bool? isRecurring,
    String? recurringFrequency,
    DateTime? nextRecurringDate,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Expense(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      category: category ?? this.category,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      receiptImage: receiptImage ?? this.receiptImage,
      notes: notes ?? this.notes,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringFrequency: recurringFrequency ?? this.recurringFrequency,
      nextRecurringDate: nextRecurringDate ?? this.nextRecurringDate,
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
      'category': category,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'receiptNumber': receiptNumber,
      'receiptImage': receiptImage,
      'notes': notes,
      'userId': userId,
      'userName': userName,
      'isRecurring': isRecurring,
      'recurringFrequency': recurringFrequency,
      'nextRecurringDate': nextRecurringDate?.toIso8601String(),
      'isSynced': isSynced,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as String,
      businessId: map['businessId'] as String,
      branchId: map['branchId'] as String?,
      category: map['category'] as String,
      description: map['description'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
      receiptNumber: map['receiptNumber'] as String?,
      receiptImage: map['receiptImage'] as String?,
      notes: map['notes'] as String?,
      userId: map['userId'] as String?,
      userName: map['userName'] as String?,
      isRecurring: map['isRecurring'] as bool? ?? false,
      recurringFrequency: map['recurringFrequency'] as String?,
      nextRecurringDate: map['nextRecurringDate'] != null
          ? DateTime.parse(map['nextRecurringDate'] as String)
          : null,
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
        category,
        description,
        amount,
        date,
        receiptNumber,
        receiptImage,
        notes,
        userId,
        userName,
        isRecurring,
        recurringFrequency,
        nextRecurringDate,
        isSynced,
        createdAt,
        updatedAt,
        metadata,
      ];
}
