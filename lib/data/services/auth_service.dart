import 'dart:convert';
import 'dart:math';
import 'package:uuid/uuid.dart';
import '../../core/enums/user_role.dart';
import '../models/user.dart';
import '../models/business.dart';
import 'storage_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final StorageService _storage = StorageService();
  final Uuid _uuid = const Uuid();

  User? _currentUser;
  Business? _currentBusiness;

  User? get currentUser => _currentUser;
  Business? get currentBusiness => _currentBusiness;
  bool get isAuthenticated => _currentUser != null;

  Future<void> init() async {
    await _loadUserFromStorage();
    await _loadBusinessFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final userData = _storage.getObject('user_data');
    if (userData != null) {
      _currentUser = User.fromMap(userData);
    }
  }

  Future<void> _loadBusinessFromStorage() async {
    final businessData = _storage.getObject('business_data');
    if (businessData != null) {
      _currentBusiness = Business.fromMap(businessData);
    }
  }

  // Demo login - in production, this would call an API
  Future<User> login(String email, String password) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Demo credentials check
    if (email != 'demo@dukafy.app' || password != 'password') {
      throw Exception('Invalid email or password');
    }

    // Create demo user
    final user = User(
      id: _uuid.v4(),
      businessId: _uuid.v4(),
      name: 'Demo User',
      email: email,
      phone: '+255712345678',
      role: UserRole.admin,
      isEmailVerified: true,
      isPhoneVerified: true,
      lastLoginAt: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );

    // Create demo business
    final business = Business(
      id: user.businessId!,
      name: 'Duka Langu',
      phone: '+255712345678',
      email: 'info@dukalangu.co.tz',
      address: 'Dar es Salaam, Tanzania',
      city: 'Dar es Salaam',
      country: 'Tanzania',
      currency: 'TZS',
      isMultiBranch: false,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );

    // Generate fake tokens
    final token = _generateFakeToken();
    final refreshToken = _generateFakeToken();

    // Save to storage
    await _storage.setAuthToken(token);
    await _storage.setRefreshToken(refreshToken);
    await _storage.setObject('user_data', user.toMap());
    await _storage.setObject('business_data', business.toMap());

    _currentUser = user;
    _currentBusiness = business;

    return user;
  }

  // Register new business with admin
  Future<Map<String, dynamic>> register({
    required String businessName,
    required String userName,
    required String email,
    required String phone,
    required String password,
    String? address,
    String? city,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    final businessId = _uuid.v4();
    final userId = _uuid.v4();

    final business = Business(
      id: businessId,
      name: businessName,
      phone: phone,
      email: email,
      address: address,
      city: city,
      country: 'Tanzania',
      currency: 'TZS',
      isMultiBranch: false,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final user = User(
      id: userId,
      businessId: businessId,
      name: userName,
      email: email,
      phone: phone,
      role: UserRole.admin,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final token = _generateFakeToken();
    final refreshToken = _generateFakeToken();

    await _storage.setAuthToken(token);
    await _storage.setRefreshToken(refreshToken);
    await _storage.setObject('user_data', user.toMap());
    await _storage.setObject('business_data', business.toMap());

    _currentUser = user;
    _currentBusiness = business;

    return {'user': user, 'business': business};
  }

  // Logout
  Future<void> logout() async {
    await _storage.clearAuth();
    _currentUser = null;
    _currentBusiness = null;
  }

  // Update user profile
  Future<User> updateProfile({
    String? name,
    String? phone,
    String? avatar,
  }) async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }

    _currentUser = _currentUser!.copyWith(
      name: name,
      phone: phone,
      avatar: avatar,
      updatedAt: DateTime.now(),
    );

    await _storage.setObject('user_data', _currentUser!.toMap());
    return _currentUser!;
  }

  // Update business profile
  Future<Business> updateBusinessProfile({
    String? name,
    String? phone,
    String? email,
    String? address,
    String? city,
    String? logo,
  }) async {
    if (_currentBusiness == null) {
      throw Exception('No business found');
    }

    _currentBusiness = _currentBusiness!.copyWith(
      name: name,
      phone: phone,
      email: email,
      address: address,
      city: city,
      logo: logo,
      updatedAt: DateTime.now(),
    );

    await _storage.setObject('business_data', _currentBusiness!.toMap());
    return _currentBusiness!;
  }

  // Change password
  Future<void> changePassword(String currentPassword, String newPassword) async {
    // In production, this would call an API
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo, just simulate success
    return;
  }

  // Refresh token
  Future<String?> refreshToken() async {
    final refreshToken = _storage.getRefreshToken();
    if (refreshToken == null) return null;

    // In production, this would call an API to refresh
    final newToken = _generateFakeToken();
    await _storage.setAuthToken(newToken);
    return newToken;
  }

  // Check if email exists
  Future<bool> checkEmailExists(String email) async {
    // In production, this would call an API
    return email == 'demo@dukafy.app';
  }

  // Generate fake token for demo
  String _generateFakeToken() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Url.encode(bytes);
  }
}
