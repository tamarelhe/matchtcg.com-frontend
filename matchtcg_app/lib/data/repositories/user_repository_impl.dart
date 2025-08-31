import 'package:dio/dio.dart';
import '../../domain/entities/auth_user_info.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_requests.dart';
import '../services/user_api_service.dart';
import '../services/secure_storage_service.dart';
import 'auth_exceptions.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _apiService;
  final SecureStorageService _storageService;

  UserRepositoryImpl(this._apiService, this._storageService);

  @override
  Future<AuthUserInfo> getCurrentUser() async {
    try {
      final user = await _apiService.getCurrentUser();

      // Update cached user info
      await _storageService.saveUserInfo(user.toJson());

      return user;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Failed to get current user');
    }
  }

  @override
  Future<AuthUserInfo> updateProfile({
    String? displayName,
    String? locale,
    String? timezone,
    String? city,
    String? country,
    List<String>? interestedGames,
  }) async {
    try {
      final request = UpdateProfileRequest(
        displayName: displayName,
        locale: locale,
        timezone: timezone,
        city: city,
        country: country,
        preferredGames: interestedGames,
      );

      final updatedUser = await _apiService.updateProfile(request);

      // Update cached user info
      await _storageService.saveUserInfo(updatedUser.toJson());

      return updatedUser;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Failed to update profile');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _apiService.deleteAccount();

      // Clear all local data after successful account deletion
      await _storageService.clearAuthData();
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Failed to delete account');
    }
  }

  @override
  Future<Map<String, dynamic>> exportUserData() async {
    try {
      final response = await _apiService.exportUserData();
      if (response is Map<String, dynamic>) {
        return response;
      } else {
        return {'data': response};
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Failed to export user data');
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
          e.response?.data['message'] ?? 'Authentication required',
        );
      case 404:
        return AuthException(e.response?.data['message'] ?? 'User not found');
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
