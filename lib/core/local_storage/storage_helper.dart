import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static T? getData<T>({required String key}) {
    try {
      return sharedPreferences.get(key) as T?;
    } catch (e, st) {
      log(
        e.toString(),
        stackTrace: st,
        name: "CacheHelper getData",
      );
      return null;
    }
  }

  // Login credentials specific methods
  static Future<bool> saveLoginCredentials({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    if (rememberMe) {
      await saveData(key: 'email', value: email);
      await saveData(key: 'password', value: password);
      return await saveData(key: 'rememberMe', value: true);
    } else {
      await removeLoginCredentials();
      return true;
    }
  }

  static Future<void> removeLoginCredentials() async {
    await removeData(key: 'email');
    await removeData(key: 'password');
    await removeData(key: 'rememberMe');
  }

  static Map<String, dynamic>? getLoginCredentials() {
    final email = getData<String>(key: 'email');
    final password = getData<String>(key: 'password');
    final rememberMe = getData<bool>(key: 'rememberMe') ?? false;

    if (email != null && password != null) {
      return {
        'email': email,
        'password': password,
        'rememberMe': rememberMe,
      };
    }
    return null;
  }

  static Future<void> deleteData({required String key}) async {
    await LocalStorage.removeData(key: key);
  }


  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> saveStringListData({
    required String key,
    required List<String> value,
  }) async {
    return await sharedPreferences.setStringList(key, value);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

}
