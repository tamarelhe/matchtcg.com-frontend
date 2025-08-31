import '../entities/auth_user_info.dart';

abstract class UserRepository {
  /// Get current user profile information
  Future<AuthUserInfo> getCurrentUser();

  /// Update user profile information
  Future<AuthUserInfo> updateProfile({
    String? displayName,
    String? locale,
    String? timezone,
    String? city,
    String? country,
    List<String>? interestedGames,
  });

  /// Delete user account permanently (GDPR compliance)
  Future<void> deleteAccount();

  /// Export all user data (GDPR compliance)
  Future<Map<String, dynamic>> exportUserData();
}
