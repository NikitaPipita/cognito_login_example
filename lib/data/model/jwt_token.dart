class JwtTokenDto {
  final String token;
  final int authTimeUnixSeconds;
  final int expirationTimeUnixSeconds;

  JwtTokenDto({
    required this.token,
    required this.authTimeUnixSeconds,
    required this.expirationTimeUnixSeconds,
  });

  DateTime get getAuthTime =>
      DateTime.fromMillisecondsSinceEpoch(authTimeUnixSeconds * 1000);

  DateTime get getExpirationTime =>
      DateTime.fromMillisecondsSinceEpoch(expirationTimeUnixSeconds * 1000);
}
