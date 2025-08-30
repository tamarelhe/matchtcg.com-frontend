class ApiConstants {
  // Environment-based API URLs
  static const String _prodBaseUrl = 'https://api.matchtcg.com/api/v1';
  static const String _stagingBaseUrl =
      'https://staging-api.matchtcg.com/api/v1';
  static const String _localBaseUrl = 'http://localhost:8080/api/v1';

  // Default to staging for development
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: _localBaseUrl,
  );

  // Timeout configurations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Rate limiting
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  // Environment helpers
  static bool get isProduction => baseUrl == _prodBaseUrl;
  static bool get isStaging => baseUrl == _stagingBaseUrl;
  static bool get isLocal => baseUrl == _localBaseUrl;
}
