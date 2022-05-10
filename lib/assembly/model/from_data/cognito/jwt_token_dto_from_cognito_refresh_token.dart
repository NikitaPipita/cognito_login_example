import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:cognito_login_example/assembly/factory.dart';
import 'package:cognito_login_example/data/model/jwt_token.dart';

class JwtTokenDtoFromCognitoRefreshToken
    implements Factory<JwtTokenDto, CognitoRefreshToken> {
  @override
  JwtTokenDto create(CognitoRefreshToken arg) {
    return JwtTokenDto(
      token: arg.getToken() ?? '',
      authTimeUnixSeconds: 0,
      expirationTimeUnixSeconds: 0,
    );
  }
}
