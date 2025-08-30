import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_user_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_exceptions.dart';

/// Authentication state
class AuthState extends Equatable {
  final bool isLoading;
  final bool isAuthenticated;
  final AuthUserInfo? user;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    AuthUserInfo? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isAuthenticated, user, error];
}

/// Authentication state notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _checkAuthStatus();
  }

  /// Check if user is already authenticated on app start
  Future<void> _checkAuthStatus() async {
    state = state.copyWith(isLoading: true);

    try {
      final isAuthenticated = await _authRepository.isAuthenticated();

      if (isAuthenticated) {
        final user = await _authRepository.getCurrentUser();
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: user,
        );
      } else {
        state = state.copyWith(isLoading: false, isAuthenticated: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: 'Failed to check authentication status',
      );
    }
  }

  /// Login with email and password
  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.login(
        email: email,
        password: password,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.user,
      );
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  /// Register new user
  Future<void> register({
    required String email,
    required String password,
    required String timezone,
    required String locale,
    String? displayName,
    String? country,
    String? city,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.register(
        email: email,
        password: password,
        timezone: timezone,
        locale: locale,
        displayName: displayName,
        country: country,
        city: city,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.user,
      );
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  /// Logout user
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      await _authRepository.logout();
      state = const AuthState(isLoading: false, isAuthenticated: false);
    } catch (e) {
      // Even if logout fails, clear local state
      state = const AuthState(isLoading: false, isAuthenticated: false);
    }
  }

  /// Refresh authentication token
  Future<void> refreshToken() async {
    try {
      final response = await _authRepository.refresh();
      state = state.copyWith(isAuthenticated: true, user: response.user);
    } on AuthException catch (e) {
      // If refresh fails, logout user
      state = state.copyWith(
        isAuthenticated: false,
        user: null,
        error: e.message,
      );
    }
  }

  /// Get Google OAuth URL
  Future<Map<String, dynamic>?> getGoogleOAuthUrl() async {
    try {
      return await _authRepository.getGoogleOAuthUrl();
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message);
      return null;
    }
  }

  /// Get Apple OAuth URL
  Future<Map<String, dynamic>?> getAppleOAuthUrl() async {
    try {
      return await _authRepository.getAppleOAuthUrl();
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message);
      return null;
    }
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }
}
