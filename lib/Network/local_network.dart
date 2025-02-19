import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static Future<void> saveData({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    print("✅ Data Saved: $key = $value");
  }

  static Future<String?> getData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    print("🔄 Loaded Data: $key = $value");
    return value;
  }

  static Future<void> clearData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    print("❌ Data Cleared: $key");
  }
}
