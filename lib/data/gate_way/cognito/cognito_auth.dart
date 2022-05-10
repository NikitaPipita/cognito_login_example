import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:cognito_login_example/assembly/factory.dart';
import 'package:cognito_login_example/data/model/user.dart';
import 'package:cognito_login_example/spine/environment_config.dart';
import 'package:cognito_login_example/spine/gate_way/auth.dart';
import 'package:cognito_login_example/utils/errors/auth_errors/null_session_exception.dart';
import 'package:cognito_login_example/utils/errors/auth_errors/refresh_tokens_exception.dart';

class CognitoAuthGateWay implements AuthGateWay {
  final CognitoUserPool _cognitoUserPool;
  final Factory<UserDto, CognitoUserSession> _userDtoFactory;
  final CognitoStorage _cognitoStorage;

  CognitoAuthGateWay(
    this._userDtoFactory,
    this._cognitoStorage,
  ) : _cognitoUserPool = CognitoUserPool(
          EnvironmentConfig.cognitoUserPoolId,
          EnvironmentConfig.cognitoClientId,
          storage: _cognitoStorage,
        );

  @override
  Future<void> signUp(String username, String password) =>
      _cognitoUserPool.signUp(username, password);

  @override
  Future<UserDto> signIn(String username, String password) async {
    final cognitoUser = CognitoUser(
      username,
      _cognitoUserPool,
      storage: _cognitoStorage,
    );
    final authDetails = AuthenticationDetails(
      username: username,
      password: password,
    );
    final session = await cognitoUser.authenticateUser(authDetails);
    if (session == null) {
      throw NullSessionException();
    }
    await cognitoUser.cacheTokens();
    return _userDtoFactory.create(session);
  }

  @override
  Future<void> signOut() async {
    final currentUser = await _cognitoUserPool.getCurrentUser();
    if (currentUser != null) {
      await currentUser.signOut();
    }
  }

  @override
  Future<UserDto?> getCurrentUser() async {
    final currentUser = await _cognitoUserPool.getCurrentUser();
    if (currentUser != null) {
      final session = await currentUser.getSession();
      if (session != null) {
        return _userDtoFactory.create(session);
      }
    }
    return null;
  }

  @override
  Future<UserDto> refreshTokens(_) async {
    final currentUser = await _cognitoUserPool.getCurrentUser();
    if (currentUser != null) {
      final session = await currentUser.getSession();
      if (session != null) {
        final refreshToken = session.getRefreshToken();
        if (refreshToken != null) {
          final refreshedSession =
              await currentUser.refreshSession(refreshToken);
          if (refreshedSession != null) {
            return _userDtoFactory.create(refreshedSession);
          }
          throw RefreshTokensException('Null refresh session exception.');
        }
        throw RefreshTokensException('Null refresh token exception.');
      }
      throw RefreshTokensException('Null session exception.');
    }
    throw RefreshTokensException('Null user exception.');
  }
}
