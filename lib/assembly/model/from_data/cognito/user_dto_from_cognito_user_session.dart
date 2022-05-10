import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:cognito_login_example/assembly/factory.dart';
import 'package:cognito_login_example/data/model/jwt_token.dart';
import 'package:cognito_login_example/data/model/user.dart';

class UserDtoFromCognitoUserSessionFactory
    implements Factory<UserDto, CognitoUserSession> {
  final Factory<JwtTokenDto, CognitoAccessToken> _accessTokenFactory;
  final Factory<JwtTokenDto, CognitoRefreshToken> _refreshTokenFactory;

  UserDtoFromCognitoUserSessionFactory(
    this._accessTokenFactory,
    this._refreshTokenFactory,
  );

  @override
  UserDto create(CognitoUserSession arg) {
    return UserDto(
      id: arg.getIdToken().getSub() ?? '',
      email: arg.getIdToken().payload is Map
          ? arg.getIdToken().payload['email']
          : '',
      accessToken: _accessTokenFactory.create(arg.getAccessToken()),
      refreshToken: arg.getRefreshToken() != null
          ? _refreshTokenFactory.create(arg.getRefreshToken()!)
          : null,
    );
  }
}
