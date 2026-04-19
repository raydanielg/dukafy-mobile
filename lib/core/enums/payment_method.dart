enum PaymentMethod {
  cash,
  mobileMoney,
  credit,
  bank,
  card;

  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.mobileMoney:
        return 'Mobile Money';
      case PaymentMethod.credit:
        return 'Credit';
      case PaymentMethod.bank:
        return 'Bank';
      case PaymentMethod.card:
        return 'Card';
    }
  }

  String get swahiliName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Fedha';
      case PaymentMethod.mobileMoney:
        return 'Pesa ya Simu';
      case PaymentMethod.credit:
        return 'Mkopo';
      case PaymentMethod.bank:
        return 'Benki';
      case PaymentMethod.card:
        return 'Kadi';
    }
  }

  String get iconName {
    switch (this) {
      case PaymentMethod.cash:
        return 'cash';
      case PaymentMethod.mobileMoney:
        return 'mobile_money';
      case PaymentMethod.credit:
        return 'credit_card';
      case PaymentMethod.bank:
        return 'bank';
      case PaymentMethod.card:
        return 'credit_card';
    }
  }
}
