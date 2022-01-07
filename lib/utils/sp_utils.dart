import 'package:shared_preferences/shared_preferences.dart';

class SpUtils{
  static const String KEY_ACCOUNT = "account";
  // 异步保存
  static Future save(String key, int value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(key, value);
  }
  // 异步读取
  static Future<int?> get(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }
}