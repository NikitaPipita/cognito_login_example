import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:cognito_login_example/assembly/factory.dart';
import 'package:cognito_login_example/data/model/jwt_token.dart';

class JwtTokenDtoFromCognitoAccessToken
    implements Factory<JwtTokenDto, CognitoAccessToken> {
  @override
  JwtTokenDto create(CognitoAccessToken arg) {
    return JwtTokenDto(
      token: arg.jwtToken ?? '',
      authTimeUnixSeconds: arg.getAuthTime(),
      expirationTimeUnixSeconds: arg.getExpiration(),
    );
  }
}
