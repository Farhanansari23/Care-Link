// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class SecureStorageResponse {
//   final String value;
//
//   SecureStorageResponse({
//     required this.value,
//   });
// }
//
// class SecureStorage {
//   static String userEmail = 'userEmail';
//   static String userName = 'name';
//   static String password = 'password';
//   static String accessToken = 'accessToken';
//   static String refreshToken = 'refreshToken';
//   static String role = 'role';
//   static String roleValue = 'roleValue';
//   static String userId = 'userId';
//   static String rememberMe = 'false';
//   static String userDob = 'userDob';
//   static String userDoj = 'userDoj';
//   static String userDepartment = 'userDepartment';
//   static String userDesignation = 'userDesignation';
//   static String userGender = 'userGender';
//   static String userMaritalStatus = 'userMaritalStatus';
//   static String userNationality = 'userNationality';
//   static String userAddress = 'userAddress';
//   static String userProfileImage = 'userProfileImage';
//
//   static FlutterSecureStorage storage = const FlutterSecureStorage();
//
//   Future<void> writeLoginCredentials(String key, String value) async {
//     await storage.write(key: key, value: value);
//   }
//
//   Future<SecureStorageResponse> readLoginCredentials(String key) async {
//     String value = await storage.read(key: key) ?? '';
//     return SecureStorageResponse(value: value);
//   }
//
//   Future<void> deleteLoginCredentials(String key) async {
//     await storage.delete(key: key);
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionController{
  static final SessionController instance = SessionController._internal();

  factory SessionController() => instance;

  SessionController._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? token;
  String? userId;
  String? usersName;

  Future<void> saveSession(String accessToken, String id,String usersName) async {
    token = accessToken;
    userId = id;
    this.usersName = usersName;

    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'user_id', value: id);
    await _storage.write(key: 'user_name', value: usersName);
  }

  Future<void> loadSession() async {
    token = await _storage.read(key: 'access_token');
    userId = await _storage.read(key: 'user_id');
    usersName = await _storage.read(key: 'user_name');
  }

  Future<void> clearSession() async {
    token = null;
    userId = null;
    await _storage.deleteAll();
  }

}
