import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/auth_user_info.dart';
import '../../domain/repositories/user_repository.dart';
import '../../data/repositories/auth_exceptions.dart';

class UserState {
  final AuthUserInfo? user;
  final bool isLoading;
  final String? error;
  final bool isUpdating;
  final bool isDeleting;
  final bool isExporting;

  const UserState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isUpdating = false,
    this.isDeleting = false,
    this.isExporting = false,
  });

  UserState copyWith({
    AuthUserInfo? user,
    bool? isLoading,
    String? error,
    bool? isUpdating,
    bool? isDeleting,
    bool? isExporting,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      isExporting: isExporting ?? this.isExporting,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _userRepository;

  UserNotifier(this._userRepository) : super(const UserState());

  /// Load current user profile
  Future<void> loadCurrentUser() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _userRepository.getCurrentUser();
      state = state.copyWith(user: user, isLoading: false);
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to load user profile',
        isLoading: false,
      );
    }
  }

  /// Update user profile
  Future<bool> updateProfile({
    String? displayName,
    String? locale,
    String? timezone,
    String? city,
    String? country,
    List<String>? interestedGames,
  }) async {
    state = state.copyWith(isUpdating: true, error: null);

    try {
      final updatedUser = await _userRepository.updateProfile(
        displayName: displayName,
        locale: locale,
        timezone: timezone,
        city: city,
        country: country,
        interestedGames: interestedGames,
      );

      state = state.copyWith(user: updatedUser, isUpdating: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message, isUpdating: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to update profile',
        isUpdating: false,
      );
      return false;
    }
  }

  /// Delete user account
  Future<bool> deleteAccount() async {
    state = state.copyWith(isDeleting: true, error: null);

    try {
      await _userRepository.deleteAccount();
      state = const UserState(); // Reset state after account deletion
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message, isDeleting: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to delete account',
        isDeleting: false,
      );
      return false;
    }
  }

  /// Export user data
  Future<Map<String, dynamic>?> exportUserData() async {
    state = state.copyWith(isExporting: true, error: null);

    try {
      final data = await _userRepository.exportUserData();
      state = state.copyWith(isExporting: false);
      return data;
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message, isExporting: false);
      return null;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to export user data',
        isExporting: false,
      );
      return null;
    }
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }
}
