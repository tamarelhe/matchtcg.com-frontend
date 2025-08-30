import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SecureStorageService {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();

  // Convenience methods for auth tokens
  Future<void> saveAccessToken(String token);
  Future<String?> getAccessToken();
  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<void> saveUserInfo(Map<String, dynamic> userInfo);
  Future<Map<String, dynamic>?> getUserInfo();
  Future<void> clearAuthData();
}

class SecureStorageServiceImpl implements SecureStorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userInfoKey = 'user_info';

  // Use flutter_secure_storage for mobile, SharedPreferences for web
  final FlutterSecureStorage? _secureStorage;
  SharedPreferences? _prefs;

  SecureStorageServiceImpl()
    : _secureStorage =
          (kIsWeb || kDebugMode)
              ? null
              : const FlutterSecureStorage(
                aOptions: AndroidOptions(),
                iOptions: IOSOptions(
                  accessibility: KeychainAccessibility.first_unlock_this_device,
                ),
              );

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<void> write(String key, String value) async {
    if (kIsWeb || kDebugMode) {
      final prefs = await _preferences;
      await prefs.setString(key, value);
    } else {
      await _secureStorage!.write(key: key, value: value);
    }
  }

  @override
  Future<String?> read(String key) async {
    if (kIsWeb || kDebugMode) {
      final prefs = await _preferences;
      return prefs.getString(key);
    } else {
      return await _secureStorage!.read(key: key);
    }
  }

  @override
  Future<void> delete(String key) async {
    if (kIsWeb || kDebugMode) {
      final prefs = await _preferences;
      await prefs.remove(key);
    } else {
      await _secureStorage!.delete(key: key);
    }
  }

  @override
  Future<void> deleteAll() async {
    if (kIsWeb || kDebugMode) {
      final prefs = await _preferences;
      await prefs.clear();
    } else {
      await _secureStorage!.deleteAll();
    }
  }

  // Convenience methods for auth tokens
  @override
  Future<void> saveAccessToken(String token) async {
    await write(_accessTokenKey, token);
  }

  @override
  Future<String?> getAccessToken() async {
    return await read(_accessTokenKey);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await write(_refreshTokenKey, token);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await read(_refreshTokenKey);
  }

  @override
  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    await write(_userInfoKey, jsonEncode(userInfo));
  }

  @override
  Future<Map<String, dynamic>?> getUserInfo() async {
    final userInfoString = await read(_userInfoKey);
    if (userInfoString != null) {
      return jsonDecode(userInfoString) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Future<void> clearAuthData() async {
    await delete(_accessTokenKey);
    await delete(_refreshTokenKey);
    await delete(_userInfoKey);
  }
}
