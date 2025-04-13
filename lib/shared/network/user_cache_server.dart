import 'package:hive/hive.dart';

class UserCacheServer {
  static late Box _avatarBox;

  static Future<void> init() async {
    _avatarBox = await Hive.openBox('avatar_cache');
  }

  static Future<void> saveAvatar(String token, String avatarUrl) async {
    await _avatarBox.put('avatar_$token', avatarUrl);
  }

  static String? getAvatar(String token) {
    return _avatarBox.get('avatar_$token');
  }

  static Future<void> clearAvatar(String token) async {
    await _avatarBox.delete('avatar_$token');
  }
}
