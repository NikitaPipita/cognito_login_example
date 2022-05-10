part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState implements BlocErrorState {
  factory AuthState({
    @Default(false) bool loading,
    User? user,
    Object? error,
  }) = _AuthState;
}
