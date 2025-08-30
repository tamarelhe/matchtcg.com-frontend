/// Base exception class for authentication-related errors
class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// Exception thrown when authentication credentials are invalid
class AuthenticationException extends AuthException {
  const AuthenticationException(super.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Exception thrown when request data is invalid
class ValidationException extends AuthException {
  const ValidationException(super.message);

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception thrown when there's a conflict (e.g., email already exists)
class ConflictException extends AuthException {
  const ConflictException(super.message);

  @override
  String toString() => 'ConflictException: $message';
}

/// Exception thrown when rate limit is exceeded
class RateLimitException extends AuthException {
  const RateLimitException(super.message);

  @override
  String toString() => 'RateLimitException: $message';
}

/// Exception thrown when there's a server error
class ServerException extends AuthException {
  const ServerException(super.message);

  @override
  String toString() => 'ServerException: $message';
}

/// Exception thrown when there's a network connectivity issue
class NetworkException extends AuthException {
  const NetworkException(super.message);

  @override
  String toString() => 'NetworkException: $message';
}
