

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {

  static Future<void> savePrefData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }


  static Future<String> getPrefData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }
}

class SharedPrefKeys{
  static const accessToken = 'accessToken';
  static const animalDetailPrefsKey = 'animalDetailPrefsKey';
}