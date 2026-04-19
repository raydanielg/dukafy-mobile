enum UserRole {
  admin,
  manager,
  cashier,
  accountant,
  subAdmin;

  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.manager:
        return 'Manager';
      case UserRole.cashier:
        return 'Cashier';
      case UserRole.accountant:
        return 'Accountant';
      case UserRole.subAdmin:
        return 'Sub Admin';
    }
  }

  String get swahiliName {
    switch (this) {
      case UserRole.admin:
        return 'Msimamizi Mkuu';
      case UserRole.manager:
        return 'Msimamizi';
      case UserRole.cashier:
        return 'Mhasibu';
      case UserRole.accountant:
        return 'Mhasibu Mkuu';
      case UserRole.subAdmin:
        return 'Msimamizi Msaidizi';
    }
  }

  bool get canManageUsers {
    return this == UserRole.admin || this == UserRole.subAdmin;
  }

  bool get canManageProducts {
    return this == UserRole.admin || this == UserRole.manager || this == UserRole.subAdmin;
  }

  bool get canViewReports {
    return this == UserRole.admin || this == UserRole.manager || this == UserRole.accountant || this == UserRole.subAdmin;
  }

  bool get canMakeSales {
    return this == UserRole.admin || this == UserRole.cashier || this == UserRole.manager;
  }

  bool get canManageExpenses {
    return this == UserRole.admin || this == UserRole.accountant || this == UserRole.manager;
  }

  bool get canManageSettings {
    return this == UserRole.admin;
  }
}
