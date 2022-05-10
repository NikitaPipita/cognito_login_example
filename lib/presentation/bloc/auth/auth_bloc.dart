import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cognito_login_example/domain/entity/user.dart';
import 'package:cognito_login_example/presentation/bloc/bloc_error_state.dart';
import 'package:cognito_login_example/spine/use_case/auth/get_current_user.dart';
import 'package:cognito_login_example/spine/use_case/auth/sign_in.dart';
import 'package:cognito_login_example/spine/use_case/auth/sign_out.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthBloc(
    this._signInUseCase,
    this._getCurrentUserUseCase,
    this._signOutUseCase,
  ) : super(AuthState()) {
    on<SignInEvent>(_onSignInEvent);
    on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
    on<SignOutEvent>(_onSignedOutEvent);

    add(GetCurrentUserEvent());
  }

  Future<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthState(loading: true));
      final user = await _signInUseCase(event.email, event.password);
      emit(AuthState(user: user));
    } catch (e) {
      _onError(e, emit);
    }
  }

  Future<void> _onGetCurrentUserEvent(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(loading: true));
      final user = await _getCurrentUserUseCase();
      emit(AuthState(user: user));
    } catch (e) {
      _onError(e, emit);
    }
  }

  Future<void> _onSignedOutEvent(
      SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthState(user: null));
      await _signOutUseCase();
    } catch (e) {
      _onError(e, emit);
    }
  }

  void _onError(Object error, Emitter<AuthState> emit) {
    log(error.toString());
    emit(state.copyWith(error: error, loading: false));
  }
}
