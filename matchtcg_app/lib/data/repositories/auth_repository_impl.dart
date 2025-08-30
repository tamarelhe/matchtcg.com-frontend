import 'package:dio/dio.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/auth_user_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_requests.dart';
import '../services/auth_api_service.dart';
import '../services/secure_storage_service.dart';
import 'auth_exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;
  final SecureStorageService _storageService;

  AuthRepositoryImpl(this._apiService, this._storageService);

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _apiService.login(request);

      // Store tokens and user info
      await _storageService.saveAccessToken(response.accessToken);
      await _storageService.saveRefreshToken(response.refreshToken);
      await _storageService.saveUserInfo(response.user.toJson());

      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred during login');
    }
  }

  @override
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String timezone,
    required String locale,
    String? displayName,
    String? country,
    String? city,
  }) async {
    try {
      final request = RegisterRequest(
        email: email,
        password: password,
        timezone: timezone,
        locale: locale,
        displayName: displayName,
        country: country,
        city: city,
      );

      final response = await _apiService.register(request);

      // Store tokens and user info
      await _storageService.saveAccessToken(response.accessToken);
      await _storageService.saveRefreshToken(response.refreshToken);
      await _storageService.saveUserInfo(response.user.toJson());

      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred during registration');
    }
  }

  @override
  Future<AuthResponse> refresh() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null) {
        throw AuthException('No refresh token available');
      }

      final request = RefreshRequest(refreshToken: refreshToken);
      final response = await _apiService.refresh(request);

      // Update stored tokens and user info
      await _storageService.saveAccessToken(response.accessToken);
      await _storageService.saveRefreshToken(response.refreshToken);
      await _storageService.saveUserInfo(response.user.toJson());

      return response;
    } on DioException catch (e) {
      // Clear stored data if refresh fails
      await _storageService.clearAuthData();
      throw _handleDioException(e);
    } catch (e) {
      await _storageService.clearAuthData();
      throw AuthException('An unexpected error occurred during token refresh');
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Try to call logout endpoint (best effort)
      await _apiService.logout();
    } catch (e) {
      // Continue with local logout even if API call fails
    } finally {
      // Always clear local data
      await _storageService.clearAuthData();
    }
  }

  @override
  Future<AuthUserInfo?> getCurrentUser() async {
    try {
      final userInfoData = await _storageService.getUserInfo();
      if (userInfoData != null) {
        return AuthUserInfo.fromJson(userInfoData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final accessToken = await _storageService.getAccessToken();
    return accessToken != null;
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storageService.getAccessToken();
  }

  @override
  Future<Map<String, dynamic>> getGoogleOAuthUrl() async {
    try {
      final response = await _apiService.getGoogleOAuthUrl();
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Failed to get Google OAuth URL');
    }
  }

  @override
  Future<Map<String, dynamic>> getAppleOAuthUrl() async {
    try {
      final response = await _apiService.getAppleOAuthUrl();
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Failed to get Apple OAuth URL');
    }
  }

  AuthException _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return ValidationException(
          e.response?.data['message'] ?? 'Invalid request data',
        );
      case 401:
        return AuthenticationException(
          e.response?.data['message'] ?? 'Invalid credentials',
        );
      case 409:
        return ConflictException(
          e.response?.data['message'] ?? 'Email already exists',
        );
      case 429:
        return RateLimitException(
          e.response?.data['message'] ?? 'Too many requests',
        );
      case 500:
      case 502:
      case 503:
        return ServerException(
          e.response?.data['message'] ?? 'Server error occurred',
        );
      default:
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.connectionError) {
          return NetworkException('Network connection failed');
        }
        return AuthException(
          e.response?.data['message'] ?? 'An unexpected error occurred',
        );
    }
  }
}
