part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignInEvent implements AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent implements AuthEvent {
  final String email;
  final String password;

  SignUpEvent({
    required this.email,
    required this.password,
  });
}

class SignOutEvent implements AuthEvent {}

class GetCurrentUserEvent implements AuthEvent {}
