import 'jwt_token.dart';

class UserDto {
  final String id;
  final String email;
  final JwtTokenDto accessToken;
  final JwtTokenDto? refreshToken;

  UserDto({
    required this.id,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });
}
