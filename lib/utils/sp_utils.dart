
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpUtils{
  static const String KEY_ACCOUNT = "account";
  static SpUtils? _singleton;
  static SharedPreferences? _prefs;
  static Lock _lock = Lock();

  static Future<SpUtils?> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = SpUtils._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SpUtils._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //例举的String型存储及获取
  static int? getIntValue(String key) {
    if (_prefs == null) return null;
    var status = _prefs?.getInt(key);
    if (status == null) return 0;
    return status;
  }

  static Future<bool>? putIntVale(String key, int value) {
    if (_prefs == null) return null;
    return _prefs?.setInt(key, value);
  }
}

