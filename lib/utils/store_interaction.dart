import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _token = 'token';

@singleton
class StoreInteraction {
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token) ?? '';
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_token, token);
  }

  Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
