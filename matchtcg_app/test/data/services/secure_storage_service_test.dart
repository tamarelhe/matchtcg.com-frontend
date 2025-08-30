import 'package:flutter_test/flutter_test.dart';
import 'package:matchtcg_app/data/services/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SecureStorageServiceImpl storageService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    // Initialize SharedPreferences for testing (simulates web environment)
    SharedPreferences.setMockInitialValues({});
    storageService = SecureStorageServiceImpl();
  });

  group('SecureStorageService (Web/SharedPreferences)', () {
    test('should save and retrieve access token', () async {
      const testToken = 'test-access-token';

      // Act
      await storageService.write('access_token', testToken);
      final retrievedToken = await storageService.read('access_token');

      // Assert
      expect(retrievedToken, equals(testToken));
    });

    test('should save and retrieve refresh token', () async {
      const testToken = 'test-refresh-token';

      // Act
      await storageService.write('refresh_token', testToken);
      final retrievedToken = await storageService.read('refresh_token');

      // Assert
      expect(retrievedToken, equals(testToken));
    });

    test(
      'should save and retrieve user info using convenience methods',
      () async {
        final testUserInfo = {
          'id': 'test-id',
          'email': 'test@example.com',
          'display_name': 'Test User',
          'locale': 'en',
        };

        // Act
        await storageService.saveUserInfo(testUserInfo);
        final retrievedUserInfo = await storageService.getUserInfo();

        // Assert
        expect(retrievedUserInfo, equals(testUserInfo));
      },
    );

    test('should delete specific keys', () async {
      // Arrange
      await storageService.write('test_key', 'test_value');

      // Act
      await storageService.delete('test_key');
      final retrievedValue = await storageService.read('test_key');

      // Assert
      expect(retrievedValue, isNull);
    });

    test('should clear all auth data using convenience method', () async {
      // Arrange - save some data first using convenience methods
      await storageService.saveAccessToken('access-token');
      await storageService.saveRefreshToken('refresh-token');
      await storageService.saveUserInfo({'id': 'test'});

      // Act
      await storageService.clearAuthData();

      // Assert
      expect(await storageService.getAccessToken(), isNull);
      expect(await storageService.getRefreshToken(), isNull);
      expect(await storageService.getUserInfo(), isNull);
    });

    test('should return null for non-existent keys', () async {
      // Act & Assert
      expect(await storageService.read('non_existent_key'), isNull);
      expect(await storageService.getAccessToken(), isNull);
      expect(await storageService.getRefreshToken(), isNull);
      expect(await storageService.getUserInfo(), isNull);
    });

    test('should handle JSON serialization for user info', () async {
      final complexUserInfo = {
        'id': 'user-123',
        'email': 'user@example.com',
        'display_name': 'John Doe',
        'locale': 'pt-BR',
        'preferences': {'theme': 'dark', 'notifications': true},
        'roles': ['user', 'premium'],
      };

      // Act
      await storageService.saveUserInfo(complexUserInfo);
      final retrievedUserInfo = await storageService.getUserInfo();

      // Assert
      expect(retrievedUserInfo, equals(complexUserInfo));
      expect(retrievedUserInfo!['preferences']['theme'], equals('dark'));
      expect(retrievedUserInfo['roles'], isA<List>());
    });
  });
}
