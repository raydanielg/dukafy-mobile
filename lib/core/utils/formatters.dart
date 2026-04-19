import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class Formatters {
  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    symbol: AppConstants.defaultCurrencySymbol,
    decimalDigits: 0,
    locale: 'en_US',
  );

  static final NumberFormat _currencyWithDecimalsFormatter = NumberFormat.currency(
    symbol: AppConstants.defaultCurrencySymbol,
    decimalDigits: 2,
    locale: 'en_US',
  );

  static final NumberFormat _numberFormatter = NumberFormat('#,##0', 'en_US');
  
  static final NumberFormat _numberWithDecimalsFormatter = NumberFormat('#,##0.00', 'en_US');

  static final DateFormat _dateFormatter = DateFormat(AppConstants.dateFormat);
  static final DateFormat _dateTimeFormatter = DateFormat(AppConstants.dateTimeFormat);
  static final DateFormat _timeFormatter = DateFormat(AppConstants.timeFormat);
  static final DateFormat _monthYearFormatter = DateFormat(AppConstants.monthYearFormat);
  static final DateFormat _apiDateFormatter = DateFormat(AppConstants.apiDateFormat);
  static final DateFormat _apiDateTimeFormatter = DateFormat(AppConstants.apiDateTimeFormat);

  // Currency formatting
  static String formatCurrency(double amount, {bool showDecimals = false}) {
    if (showDecimals) {
      return _currencyWithDecimalsFormatter.format(amount);
    }
    return _currencyFormatter.format(amount);
  }

  static String formatCurrencyWithoutSymbol(double amount, {bool showDecimals = false}) {
    if (showDecimals) {
      return _numberWithDecimalsFormatter.format(amount);
    }
    return _numberFormatter.format(amount);
  }

  // Number formatting
  static String formatNumber(int number) {
    return _numberFormatter.format(number);
  }

  static String formatNumberDouble(double number, {int decimalDigits = 2}) {
    final formatter = NumberFormat('#,##0.${'0' * decimalDigits}', 'en_US');
    return formatter.format(number);
  }

  // Percentage formatting
  static String formatPercentage(double value, {int decimalDigits = 1}) {
    final formatter = NumberFormat('0.${'0' * decimalDigits}%', 'en_US');
    return formatter.format(value / 100);
  }

  // Date formatting
  static String formatDate(DateTime date) {
    return _dateFormatter.format(date);
  }

  static String formatDateTime(DateTime dateTime) {
    return _dateTimeFormatter.format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return _timeFormatter.format(dateTime);
  }

  static String formatMonthYear(DateTime date) {
    return _monthYearFormatter.format(date);
  }

  static String formatApiDate(DateTime date) {
    return _apiDateFormatter.format(date);
  }

  static String formatApiDateTime(DateTime dateTime) {
    return _apiDateTimeFormatter.format(dateTime);
  }

  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);
    final difference = dateToCheck.difference(today).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference > -7 && difference < 0) {
      return '${difference.abs()} days ago';
    } else if (difference > 0 && difference < 7) {
      return 'In $difference days';
    } else {
      return formatDate(date);
    }
  }

  static String formatRelativeDateSwahili(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);
    final difference = dateToCheck.difference(today).inDays;

    if (difference == 0) {
      return 'Leo';
    } else if (difference == -1) {
      return 'Jana';
    } else if (difference == 1) {
      return 'Kesho';
    } else if (difference > -7 && difference < 0) {
      return 'Siku ${difference.abs()} zilizopita';
    } else if (difference > 0 && difference < 7) {
      return 'Baada ya siku $difference';
    } else {
      return formatDate(date);
    }
  }

  // Phone number formatting
  static String formatPhoneNumber(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    if (cleanPhone.startsWith('+255')) {
      // International format: +255 XXX XXX XXX
      return '+255 ${cleanPhone.substring(3, 6)} ${cleanPhone.substring(6, 9)} ${cleanPhone.substring(9)}';
    } else if (cleanPhone.startsWith('0')) {
      // Local format: 0XXX XXX XXX
      return '${cleanPhone.substring(0, 4)} ${cleanPhone.substring(4, 7)} ${cleanPhone.substring(7)}';
    }
    
    return cleanPhone;
  }

  static String formatPhoneNumberReadable(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    if (cleanPhone.startsWith('+255')) {
      return '+255 ${cleanPhone.substring(3, 6)} ${cleanPhone.substring(6, 9)} ${cleanPhone.substring(9)}';
    } else if (cleanPhone.startsWith('0')) {
      return '0${cleanPhone.substring(1, 4)} ${cleanPhone.substring(4, 7)} ${cleanPhone.substring(7)}';
    }
    
    return cleanPhone;
  }

  // Text formatting
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength - suffix.length) + suffix;
  }

  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double size = bytes.toDouble();
    
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    
    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  static String formatStockQuantity(int quantity, int? threshold) {
    if (threshold != null && quantity <= threshold) {
      return '$quantity (Low)';
    }
    return quantity.toString();
  }

  static String formatStockQuantitySwahili(int quantity, int? threshold) {
    if (threshold != null && quantity <= threshold) {
      return '$quantity (Chache)';
    }
    return quantity.toString();
  }

  // Parse helpers
  static double? parseCurrency(String value) {
    final cleanValue = value.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleanValue);
  }

  static int? parseInteger(String value) {
    final cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(cleanValue);
  }

  static DateTime? parseDate(String value, {String? format}) {
    try {
      if (format != null) {
        return DateFormat(format).parse(value);
      }
      return _dateFormatter.parse(value);
    } catch (e) {
      return null;
    }
  }

  static DateTime? parseApiDate(String value) {
    try {
      return _apiDateFormatter.parse(value);
    } catch (e) {
      return null;
    }
  }
}
