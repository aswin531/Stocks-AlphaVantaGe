class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}