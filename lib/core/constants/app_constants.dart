class AppConstants {
  // App Info
  static const String appName = 'Dukafy';
  static const String appTagline = 'Mfumo wa Kusimamia Biashara';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String businessDataKey = 'business_data';
  static const String onboardingCompleteKey = 'onboarding_complete';
  static const String languageKey = 'app_language';
  static const String themeKey = 'app_theme';
  static const String notificationsEnabledKey = 'notifications_enabled';
  static const String biometricEnabledKey = 'biometric_enabled';
  static const String lastSyncKey = 'last_sync';
  
  // API Constants
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int maxRetries = 3;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Currency
  static const String defaultCurrency = 'TZS';
  static const String defaultCurrencySymbol = 'TSh';
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';
  static const String monthYearFormat = 'MMM yyyy';
  static const String apiDateFormat = 'yyyy-MM-dd';
  static const String apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss';
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const int phoneNumberLength = 10;
  static const int minProductNameLength = 2;
  static const int maxProductNameLength = 200;
  
  // Limits
  static const int maxProductsPerSale = 100;
  static const int maxReceiptItems = 50;
  static const double minSaleAmount = 0.01;
  static const double maxSaleAmount = 999999999.99;
  
  // Animation Durations
  static const int shortAnimationDuration = 200;
  static const int mediumAnimationDuration = 350;
  static const int longAnimationDuration = 500;
  
  // Debounce Delays
  static const int searchDebounceMs = 300;
  static const int refreshDebounceMs = 500;
  
  // Cache Durations (in minutes)
  static const int cacheDurationShort = 5;
  static const int cacheDurationMedium = 30;
  static const int cacheDurationLong = 60;
  
  // Notification Channels
  static const String lowStockChannelId = 'low_stock_channel';
  static const String salesChannelId = 'sales_channel';
  static const String debtChannelId = 'debt_channel';
  static const String generalChannelId = 'general_channel';
  
  // Low Stock Threshold
  static const int defaultLowStockThreshold = 10;
  
  // Roles
  static const String roleAdmin = 'admin';
  static const String roleManager = 'manager';
  static const String roleCashier = 'cashier';
  static const String roleAccountant = 'accountant';
  static const String roleSubAdmin = 'sub_admin';
  
  // Payment Methods
  static const String paymentCash = 'cash';
  static const String paymentMobileMoney = 'mobile_money';
  static const String paymentCredit = 'credit';
  static const String paymentBank = 'bank';
  static const String paymentCard = 'card';
  
  // Expense Categories
  static const List<String> expenseCategories = [
    'Rent',
    'Salaries',
    'Transport',
    'Purchases',
    'Utilities',
    'Maintenance',
    'Marketing',
    'Insurance',
    'Taxes',
    'Other',
  ];
  
  // Supported Languages
  static const List<String> supportedLanguages = ['en', 'sw'];
  static const String defaultLanguage = 'sw';
}
