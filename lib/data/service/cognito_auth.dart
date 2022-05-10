import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:cognito_login_example/assembly/factory.dart';
import 'package:cognito_login_example/data/model/user.dart';
import 'package:cognito_login_example/domain/entity/user.dart';
import 'package:cognito_login_example/spine/gate_way/auth.dart';
import 'package:cognito_login_example/spine/service/auth.dart';

class CognitoAuthService implements AuthService {
  final AuthGateWay _authGateWay;
  final Factory<User, UserDto> _userFactory;

  CognitoAuthService(
    this._authGateWay,
    this._userFactory,
  );

  @override
  Future<User> signUp(String email, String password) async {
    await _authGateWay.signUp(email, password);
    final loginUserDto = await _authGateWay.signIn(email, password);
    return _userFactory.create(loginUserDto);
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final loginUserDto = await _authGateWay.signIn(email, password);
      return _userFactory.create(loginUserDto);
    } on CognitoClientException catch (e) {
      if (e.code == 'UserNotFoundException') {
        return signUp(email, password);
      }
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() => _authGateWay.signOut();

  @override
  Future<User?> getCurrentUser() async {
    final currentUser = await _authGateWay.getCurrentUser();
    if (currentUser != null) {
      if (DateTime.now()
              .add(const Duration(seconds: 60))
              .isAfter(currentUser.accessToken.getExpirationTime) &&
          currentUser.refreshToken != null) {
        final refreshedCurrentUser =
            await _authGateWay.refreshTokens(currentUser.refreshToken!);
        return _userFactory.create(refreshedCurrentUser);
      }
      return _userFactory.create(currentUser);
    }
    return null;
  }
}
