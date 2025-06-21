

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {

  static Future<void> savePrefData({required String key,required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }


  static Future<String> getPrefData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<void> removePrefData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class SharedPrefKeys{
  static const accessToken = 'accessToken';

}

