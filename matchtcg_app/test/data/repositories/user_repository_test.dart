import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:matchtcg_app/data/repositories/user_repository_impl.dart';
import 'package:matchtcg_app/data/services/user_api_service.dart';
import 'package:matchtcg_app/data/services/secure_storage_service.dart';
import 'package:matchtcg_app/domain/entities/auth_user_info.dart';
import 'package:matchtcg_app/data/repositories/auth_exceptions.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserApiService, SecureStorageService])
void main() {
  late UserRepositoryImpl repository;
  late MockUserApiService mockApiService;
  late MockSecureStorageService mockStorageService;

  setUp(() {
    mockApiService = MockUserApiService();
    mockStorageService = MockSecureStorageService();
    repository = UserRepositoryImpl(mockApiService, mockStorageService);
  });

  group('UserRepository', () {
    const testUser = AuthUserInfo(
      id: 'test-id',
      email: 'test@example.com',
      displayName: 'Test User',
      locale: 'en',
    );

    group('getCurrentUser', () {
      test('should return user and cache it when API call succeeds', () async {
        // Arrange
        when(mockApiService.getCurrentUser()).thenAnswer((_) async => testUser);
        when(mockStorageService.saveUserInfo(any)).thenAnswer((_) async {});

        // Act
        final result = await repository.getCurrentUser();

        // Assert
        expect(result, equals(testUser));
        verify(mockApiService.getCurrentUser()).called(1);
        verify(mockStorageService.saveUserInfo(testUser.toJson())).called(1);
      });

      test('should throw AuthException when API call fails', () async {
        // Arrange
        when(mockApiService.getCurrentUser()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/me'),
            response: Response(
              requestOptions: RequestOptions(path: '/me'),
              statusCode: 401,
              data: {'message': 'Unauthorized'},
            ),
          ),
        );

        // Act & Assert
        expect(
          () => repository.getCurrentUser(),
          throwsA(isA<AuthenticationException>()),
        );
      });
    });

    group('updateProfile', () {
      test(
        'should update profile and cache result when API call succeeds',
        () async {
          // Arrange
          const updatedUser = AuthUserInfo(
            id: 'test-id',
            email: 'test@example.com',
            displayName: 'Updated User',
            locale: 'pt',
          );

          when(
            mockApiService.updateProfile(any),
          ).thenAnswer((_) async => updatedUser);
          when(mockStorageService.saveUserInfo(any)).thenAnswer((_) async {});

          // Act
          final result = await repository.updateProfile(
            displayName: 'Updated User',
            locale: 'pt',
          );

          // Assert
          expect(result, equals(updatedUser));
          verify(mockApiService.updateProfile(any)).called(1);
          verify(
            mockStorageService.saveUserInfo(updatedUser.toJson()),
          ).called(1);
        },
      );

      test('should throw ValidationException for invalid data', () async {
        // Arrange
        when(mockApiService.updateProfile(any)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/me'),
            response: Response(
              requestOptions: RequestOptions(path: '/me'),
              statusCode: 400,
              data: {'message': 'Invalid data'},
            ),
          ),
        );

        // Act & Assert
        expect(
          () => repository.updateProfile(displayName: ''),
          throwsA(isA<ValidationException>()),
        );
      });
    });

    group('deleteAccount', () {
      test(
        'should delete account and clear local data when API call succeeds',
        () async {
          // Arrange
          when(mockApiService.deleteAccount()).thenAnswer((_) async {});
          when(mockStorageService.clearAuthData()).thenAnswer((_) async {});

          // Act
          await repository.deleteAccount();

          // Assert
          verify(mockApiService.deleteAccount()).called(1);
          verify(mockStorageService.clearAuthData()).called(1);
        },
      );

      test('should throw AuthException when API call fails', () async {
        // Arrange
        when(mockApiService.deleteAccount()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/me'),
            response: Response(
              requestOptions: RequestOptions(path: '/me'),
              statusCode: 500,
              data: {'message': 'Server error'},
            ),
          ),
        );

        // Act & Assert
        expect(
          () => repository.deleteAccount(),
          throwsA(isA<ServerException>()),
        );
      });
    });

    group('exportUserData', () {
      test('should return user data when API call succeeds', () async {
        // Arrange
        const testData = {'user': 'data', 'events': [], 'groups': []};
        when(mockApiService.exportUserData()).thenAnswer((_) async => testData);

        // Act
        final result = await repository.exportUserData();

        // Assert
        expect(result, equals(testData));
        verify(mockApiService.exportUserData()).called(1);
      });

      test('should wrap non-map response in data field', () async {
        // Arrange
        const testData = 'string response';
        when(mockApiService.exportUserData()).thenAnswer((_) async => testData);

        // Act
        final result = await repository.exportUserData();

        // Assert
        expect(result, equals({'data': testData}));
        verify(mockApiService.exportUserData()).called(1);
      });

      test('should throw AuthException when API call fails', () async {
        // Arrange
        when(mockApiService.exportUserData()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/me/export'),
            response: Response(
              requestOptions: RequestOptions(path: '/me/export'),
              statusCode: 403,
              data: {'message': 'Forbidden'},
            ),
          ),
        );

        // Act & Assert
        expect(
          () => repository.exportUserData(),
          throwsA(isA<AuthException>()),
        );
      });
    });
  });
}
