import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/user.dart';
import '../../data/models/business.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/storage_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final StorageService _storageService;

  AuthBloc({
    AuthService? authService,
    StorageService? storageService,
  })  : _authService = authService ?? AuthService(),
        _storageService = storageService ?? StorageService(),
        super(const AuthState()) {
    on<AuthInitialize>(_onInitialize);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthProfileUpdateRequested>(_onProfileUpdateRequested);
    on<AuthBusinessUpdateRequested>(_onBusinessUpdateRequested);
    on<AuthCheckEmailExists>(_onCheckEmailExists);
  }

  Future<void> _onInitialize(
    AuthInitialize event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await _authService.init();
      await _storageService.init();

      final isOnboardingComplete = _storageService.isOnboardingComplete() ?? false;
      
      if (_authService.isAuthenticated) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: _authService.currentUser,
          business: _authService.currentBusiness,
          isOnboardingComplete: isOnboardingComplete,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          isOnboardingComplete: isOnboardingComplete,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await _authService.login(event.email, event.password);
      
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        business: _authService.currentBusiness,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final result = await _authService.register(
        businessName: event.businessName,
        userName: event.userName,
        email: event.email,
        phone: event.phone,
        password: event.password,
        address: event.address,
        city: event.city,
      );

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: result['user'] as User,
        business: result['business'] as Business,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await _authService.logout();
      emit(const AuthState(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onProfileUpdateRequested(
    AuthProfileUpdateRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await _authService.updateProfile(
        name: event.name,
        phone: event.phone,
        avatar: event.avatar,
      );

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onBusinessUpdateRequested(
    AuthBusinessUpdateRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final business = await _authService.updateBusinessProfile(
        name: event.name,
        phone: event.phone,
        email: event.email,
        address: event.address,
        city: event.city,
        logo: event.logo,
      );

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        business: business,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCheckEmailExists(
    AuthCheckEmailExists event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final exists = await _authService.checkEmailExists(event.email);
      emit(state.copyWith(emailExists: exists));
    } catch (e) {
      // Silently fail for email check
    }
  }
}
