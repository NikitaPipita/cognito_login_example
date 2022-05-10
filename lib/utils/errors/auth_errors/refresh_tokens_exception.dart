class RefreshTokensException implements Exception {
  final String message = 'Refresh tokens exception.';
  final String reason;

  RefreshTokensException(this.reason);
}