import 'package:cognito_login_example/data/model/jwt_token.dart';
import 'package:cognito_login_example/data/model/user.dart';

abstract class AuthGateWay {
  Future<void> signUp(String email, String password);

  Future<UserDto> signIn(String email, String password);

  Future<void> signOut();

  Future<UserDto?> getCurrentUser();

  Future<UserDto> refreshTokens(JwtTokenDto refreshToken);
}
