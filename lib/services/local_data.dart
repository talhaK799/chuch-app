import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  Future<void> setMemberStatus(bool isMember) async {
    final SharedPreferences prefs = await await _prefs;
    await prefs.setBool('isMember', isMember);
  }

  Future<bool> getMemberStatus() async {
    final SharedPreferences prefs = await await _prefs;
    return prefs.getBool('isMember') ?? false;
  }

  Future setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  Future setInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  Future<int> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key) ?? 99999999;
  }
}
