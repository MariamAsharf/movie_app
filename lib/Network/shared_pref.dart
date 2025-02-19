import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /// ✅ حفظ التوكن كـ String فقط
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    print("✅ Token Saved: $token");
  }

  /// ✅ تحميل التوكن بدون أي تحويل غير ضروري
  static Future<String?> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("🔄 Loaded Token: $token");
    return token;
  }

  /// ✅ مسح التوكن فقط بدون حذف كل البيانات
  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    print("❌ Token Cleared");
  }
}
