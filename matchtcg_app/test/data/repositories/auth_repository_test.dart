import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:matchtcg_app/data/repositories/auth_repository_impl.dart';
import 'package:matchtcg_app/data/repositories/auth_exceptions.dart';
import 'package:matchtcg_app/data/services/auth_api_service.dart';
import 'package:matchtcg_app/data/services/secure_storage_service.dart';
import 'package:matchtcg_app/domain/entities/auth_response.dart';
import 'package:matchtcg_app/domain/entities/auth_user_info.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthApiService, SecureStorageService])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthApiService mockApiService;
  late MockSecureStorageService mockStorageService;

  setUp(() {
    mockApiService = MockAuthApiService();
    mockStorageService = MockSecureStorageService();
    repository = AuthRepositoryImpl(mockApiService, mockStorageService);
  });

  group('AuthRepository', () {
    const testUser = AuthUserInfo(
      id: 'test-id',
      email: 'test@example.com',
      displayName: 'Test User',
      locale: 'en',
    );

    const testAuthResponse = AuthResponse(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
      tokenType: 'Bearer',
      expiresAt: '2025-08-30T22:51:43+01:00',
      user: testUser,
    );

    group('login', () {
      test('should return AuthResponse on successful login', () async {
        // Arrange
        when(
          mockApiService.login(any),
        ).thenAnswer((_) async => testAuthResponse);
        when(mockStorageService.saveAccessToken(any)).thenAnswer((_) async {});
        when(mockStorageService.saveRefreshToken(any)).thenAnswer((_) async {});
        when(mockStorageService.saveUserInfo(any)).thenAnswer((_) async {});

        // Act
        final result = await repository.login(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(result, equals(testAuthResponse));
        verify(mockStorageService.saveAccessToken('access-token')).called(1);
        verify(mockStorageService.saveRefreshToken('refresh-token')).called(1);
        verify(mockStorageService.saveUserInfo(testUser.toJson())).called(1);
      });

      test('should throw AuthenticationException on 401 error', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 401,
            data: {'message': 'Invalid credentials'},
          ),
        );
        when(mockApiService.login(any)).thenThrow(dioException);

        // Act & Assert
        expect(
          () => repository.login(email: 'test@example.com', password: 'wrong'),
          throwsA(isA<AuthenticationException>()),
        );
      });
    });

    group('register', () {
      test('should return AuthResponse on successful registration', () async {
        // Arrange
        when(
          mockApiService.register(any),
        ).thenAnswer((_) async => testAuthResponse);
        when(mockStorageService.saveAccessToken(any)).thenAnswer((_) async {});
        when(mockStorageService.saveRefreshToken(any)).thenAnswer((_) async {});
        when(mockStorageService.saveUserInfo(any)).thenAnswer((_) async {});

        // Act
        final result = await repository.register(
          email: 'test@example.com',
          password: 'password123',
          timezone: 'UTC',
          locale: 'en',
        );

        // Assert
        expect(result, equals(testAuthResponse));
        verify(mockStorageService.saveAccessToken('access-token')).called(1);
        verify(mockStorageService.saveRefreshToken('refresh-token')).called(1);
      });

      test('should throw ConflictException on 409 error', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/auth/register'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 409,
            data: {'message': 'Email already exists'},
          ),
        );
        when(mockApiService.register(any)).thenThrow(dioException);

        // Act & Assert
        expect(
          () => repository.register(
            email: 'test@example.com',
            password: 'password123',
            timezone: 'UTC',
            locale: 'en',
          ),
          throwsA(isA<ConflictException>()),
        );
      });
    });

    group('isAuthenticated', () {
      test('should return true when access token exists', () async {
        // Arrange
        when(
          mockStorageService.getAccessToken(),
        ).thenAnswer((_) async => 'token');

        // Act
        final result = await repository.isAuthenticated();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when no access token exists', () async {
        // Arrange
        when(mockStorageService.getAccessToken()).thenAnswer((_) async => null);

        // Act
        final result = await repository.isAuthenticated();

        // Assert
        expect(result, isFalse);
      });
    });

    group('logout', () {
      test('should clear auth data even if API call fails', () async {
        // Arrange
        when(mockApiService.logout()).thenThrow(Exception('API error'));
        when(mockStorageService.clearAuthData()).thenAnswer((_) async {});

        // Act
        await repository.logout();

        // Assert
        verify(mockStorageService.clearAuthData()).called(1);
      });
    });
  });
}
