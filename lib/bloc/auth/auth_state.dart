part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final Business? business;
  final bool? isOnboardingComplete;
  final bool? emailExists;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.business,
    this.isOnboardingComplete,
    this.emailExists,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    Business? business,
    bool? isOnboardingComplete,
    bool? emailExists,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      business: business ?? this.business,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      emailExists: emailExists ?? this.emailExists,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        business,
        isOnboardingComplete,
        emailExists,
        errorMessage,
      ];
}
