import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/services/auth_api_service.dart';
import '../../data/services/http_client.dart';
import '../../data/services/secure_storage_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/providers/auth_notifier.dart';
import '../constants/api_constants.dart';

// Storage service provider
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageServiceImpl();
});

// HTTP client provider
final httpClientProvider = Provider<HttpClient>((ref) {
  final storageService = ref.read(secureStorageServiceProvider);
  final client = HttpClient(storageService);
  client.setBaseUrl(ApiConstants.baseUrl);
  client.setTimeout(ApiConstants.connectTimeout);
  return client;
});

// Auth API service provider
final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final httpClient = ref.read(httpClientProvider);
  return AuthApiService(httpClient.dio, baseUrl: ApiConstants.baseUrl);
});

// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.read(authApiServiceProvider);
  final storageService = ref.read(secureStorageServiceProvider);
  return AuthRepositoryImpl(apiService, storageService);
});

// Auth state notifier provider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepository);
});
