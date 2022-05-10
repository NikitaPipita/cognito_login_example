import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:get_it/get_it.dart';
import 'package:cognito_login_example/assembly/entity/from_dto/user_from_dto.dart';
import 'package:cognito_login_example/assembly/factory.dart';
import 'package:cognito_login_example/assembly/model/from_data/cognito/jwt_token_dto_from_cognito_access_token.dart';
import 'package:cognito_login_example/assembly/model/from_data/cognito/jwt_token_dto_from_cognito_refresh_token.dart';
import 'package:cognito_login_example/assembly/model/from_data/cognito/user_dto_from_cognito_user_session.dart';
import 'package:cognito_login_example/data/gate_way/cognito/cognito_auth.dart';
import 'package:cognito_login_example/data/gate_way/cognito/cognito_secure_storage.dart';
import 'package:cognito_login_example/data/model/jwt_token.dart';
import 'package:cognito_login_example/data/model/user.dart';
import 'package:cognito_login_example/data/service/cognito_auth.dart';
import 'package:cognito_login_example/domain/entity/user.dart';
import 'package:cognito_login_example/domain/use_case/auth/auth_sign_in.dart';
import 'package:cognito_login_example/domain/use_case/auth/auth_sign_out.dart';
import 'package:cognito_login_example/domain/use_case/auth/get_auth_current_user.dart';
import 'package:cognito_login_example/presentation/bloc/auth/auth_bloc.dart';
import 'package:cognito_login_example/spine/gate_way/auth.dart';
import 'package:cognito_login_example/spine/service/auth.dart';
import 'package:cognito_login_example/spine/use_case/auth/get_current_user.dart';
import 'package:cognito_login_example/spine/use_case/auth/sign_in.dart';
import 'package:cognito_login_example/spine/use_case/auth/sign_out.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<Factory<JwtTokenDto, CognitoAccessToken>>(
      () => JwtTokenDtoFromCognitoAccessToken());
  getIt.registerLazySingleton<Factory<JwtTokenDto, CognitoRefreshToken>>(
      () => JwtTokenDtoFromCognitoRefreshToken());
  getIt.registerLazySingleton<Factory<UserDto, CognitoUserSession>>(
      () => UserDtoFromCognitoUserSessionFactory(getIt.get(), getIt.get()));
  getIt.registerLazySingleton<Factory<User, UserDto>>(
      () => UserFromDtoFactory());
  getIt.registerLazySingleton<CognitoStorage>(
      () => CognitoSecureStorageGateWay(getIt.get()));
  getIt.registerLazySingleton<AuthGateWay>(
      () => CognitoAuthGateWay(getIt.get(), getIt.get()));
  getIt.registerLazySingleton<AuthService>(
      () => CognitoAuthService(getIt.get(), getIt.get()));
  getIt.registerLazySingleton<SignInUseCase>(
      () => AuthSignInUseCase(getIt.get()));
  getIt.registerLazySingleton<SignOutUseCase>(
      () => AuthSignOutUseCase(getIt.get()));
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetAuthCurrentUserUseCase(getIt.get()));
  getIt.registerSingleton<AuthBloc>(
      AuthBloc(getIt.get(), getIt.get(), getIt.get()));
}
