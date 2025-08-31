import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/user_api_service.dart';
import '../../domain/repositories/user_repository.dart';
import '../../presentation/providers/user_notifier.dart';
import 'auth_providers.dart';

// User API Service Provider
final userApiServiceProvider = Provider<UserApiService>((ref) {
  final httpClient = ref.read(httpClientProvider);
  return UserApiService(httpClient.dio);
});

// User Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiService = ref.read(userApiServiceProvider);
  final storageService = ref.read(secureStorageServiceProvider);
  return UserRepositoryImpl(apiService, storageService);
});

// User State Provider
final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>((
  ref,
) {
  return UserNotifier(ref.read(userRepositoryProvider));
});
