import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _sharedPreferences;
  static LocalStorage? _instance;

  static Future<LocalStorage> get instance async {
    _instance ??= await LocalStorage().initial();
    return _instance!;
  }

  Future<LocalStorage> initial() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<String?> readString(String key) async {
    await _sharedPreferences.reload();
    return _sharedPreferences.getString(key);
  }

  Future<bool> delete(String key) async {
    return await _sharedPreferences.remove(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _sharedPreferences.setInt(key, value);
  }
}
