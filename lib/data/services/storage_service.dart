import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String operations
  Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Bool operations
  Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Int operations
  Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    return await _prefs?.setDouble(key, value) ?? false;
  }

  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  // StringList operations
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs?.setStringList(key, value) ?? false;
  }

  List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  // Object operations
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    return await _prefs?.setString(key, jsonEncode(value)) ?? false;
  }

  Map<String, dynamic>? getObject(String key) {
    final jsonString = _prefs?.getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Remove operations
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  // Auth specific helpers
  Future<bool> setAuthToken(String token) async {
    return await setString(AppConstants.authTokenKey, token);
  }

  String? getAuthToken() {
    return getString(AppConstants.authTokenKey);
  }

  Future<bool> setRefreshToken(String token) async {
    return await setString(AppConstants.refreshTokenKey, token);
  }

  String? getRefreshToken() {
    return getString(AppConstants.refreshTokenKey);
  }

  Future<bool> clearAuth() async {
    final results = await Future.wait([
      remove(AppConstants.authTokenKey),
      remove(AppConstants.refreshTokenKey),
      remove(AppConstants.userDataKey),
      remove(AppConstants.businessDataKey),
    ]);
    return results.every((result) => result);
  }

  // Onboarding
  Future<bool> setOnboardingComplete(bool value) async {
    return await setBool(AppConstants.onboardingCompleteKey, value);
  }

  bool? isOnboardingComplete() {
    return getBool(AppConstants.onboardingCompleteKey);
  }

  // Language
  Future<bool> setLanguage(String language) async {
    return await setString(AppConstants.languageKey, language);
  }

  String? getLanguage() {
    return getString(AppConstants.languageKey);
  }

  // Theme
  Future<bool> setTheme(String theme) async {
    return await setString(AppConstants.themeKey, theme);
  }

  String? getTheme() {
    return getString(AppConstants.themeKey);
  }

  // Notifications
  Future<bool> setNotificationsEnabled(bool value) async {
    return await setBool(AppConstants.notificationsEnabledKey, value);
  }

  bool? areNotificationsEnabled() {
    return getBool(AppConstants.notificationsEnabledKey);
  }

  // Biometric
  Future<bool> setBiometricEnabled(bool value) async {
    return await setBool(AppConstants.biometricEnabledKey, value);
  }

  bool? isBiometricEnabled() {
    return getBool(AppConstants.biometricEnabledKey);
  }

  // Check if key exists
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  // Get all keys
  Set<String> getKeys() {
    return _prefs?.getKeys() ?? {};
  }
}
