import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

/// Manages automatic token refresh and logout on expiration
class TokenRefreshManager {
  static Timer? _refreshTimer;
  static WidgetRef? _ref;

  /// Initialize the token refresh manager
  static void initialize(WidgetRef ref, {bool enableTimer = true}) {
    _ref = ref;
    // Only start timer if explicitly enabled (disabled during tests)
    if (enableTimer) {
      _scheduleTokenRefresh();
    }
  }

  /// Schedule the next token refresh
  static void _scheduleTokenRefresh() {
    _refreshTimer?.cancel();

    // Refresh token every 50 minutes (assuming 1-hour token expiry)
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 50),
      (_) => _refreshTokenIfNeeded(),
    );
  }

  /// Refresh token if user is authenticated
  static Future<void> _refreshTokenIfNeeded() async {
    if (_ref == null) return;

    final authState = _ref!.read(authNotifierProvider);

    if (authState.isAuthenticated) {
      try {
        await _ref!.read(authNotifierProvider.notifier).refreshToken();
      } catch (e) {
        // If refresh fails, the AuthNotifier will handle logout
        // In production, this should use proper logging
        assert(() {
          return true;
        }());
      }
    }
  }

  /// Manually trigger token refresh
  static Future<void> refreshToken() async {
    if (_ref == null) return;

    await _ref!.read(authNotifierProvider.notifier).refreshToken();
  }

  /// Stop the token refresh timer
  static void dispose() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _ref = null;
  }
}
