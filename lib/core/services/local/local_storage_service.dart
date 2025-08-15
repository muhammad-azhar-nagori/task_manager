import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences _sharedPreferences;

  Future<void> setString(String key, String json) async {
    await _sharedPreferences.setString(key, json);
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<bool> setStringList(String key, List<String> stringList) async {
    return await _sharedPreferences.setStringList(key, stringList);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  Future<bool> setInt(String key, int value) async {
    return _sharedPreferences.setInt(key, value);
  }

  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return _sharedPreferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
