part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthInitialize extends AuthEvent {
  const AuthInitialize();
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String businessName;
  final String userName;
  final String email;
  final String phone;
  final String password;
  final String? address;
  final String? city;

  const AuthRegisterRequested({
    required this.businessName,
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
    this.address,
    this.city,
  });

  @override
  List<Object?> get props => [
        businessName,
        userName,
        email,
        phone,
        password,
        address,
        city,
      ];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthProfileUpdateRequested extends AuthEvent {
  final String? name;
  final String? phone;
  final String? avatar;

  const AuthProfileUpdateRequested({
    this.name,
    this.phone,
    this.avatar,
  });

  @override
  List<Object?> get props => [name, phone, avatar];
}

class AuthBusinessUpdateRequested extends AuthEvent {
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? city;
  final String? logo;

  const AuthBusinessUpdateRequested({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.city,
    this.logo,
  });

  @override
  List<Object?> get props => [name, phone, email, address, city, logo];
}

class AuthCheckEmailExists extends AuthEvent {
  final String email;

  const AuthCheckEmailExists(this.email);

  @override
  List<Object?> get props => [email];
}
