import '../entities/auth_response.dart';
import '../entities/auth_user_info.dart';

abstract class AuthRepository {
  Future<AuthResponse> login({required String email, required String password});

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String timezone,
    required String locale,
    String? displayName,
    String? country,
    String? city,
  });

  Future<AuthResponse> refresh();

  Future<void> logout();

  Future<AuthUserInfo?> getCurrentUser();

  Future<bool> isAuthenticated();

  Future<String?> getAccessToken();

  Future<Map<String, dynamic>> getGoogleOAuthUrl();

  Future<Map<String, dynamic>> getAppleOAuthUrl();
}
