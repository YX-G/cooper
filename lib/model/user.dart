import 'package:cooper/http/api.dart';
import 'package:cooper/http/http_client.dart';
import 'package:cooper/utils/sp_utils.dart';
import 'package:cooper/view/loading_utils.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {

  // {"data":{"admin":false,"chapterTops":[]
  // ,"coinCount":33,"collectIds":[],"email":"",
  // "icon":"","id":123160,"nickname":"test911","password":""
  // ,"publicName":"test911","token":"","type":0,"username":"test911"},
  // "errorCode":0,"errorMsg":""}
  int? id;
  String? token;
  String? nickname;
  String? publicName;

  User({this.id,
        this.token,
        this.nickname,
        this.publicName,
  });

  factory User.from(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson["id"],
      token: parsedJson["token"],
      nickname: parsedJson["nickname"],
      publicName: parsedJson["publicName"],
    );
  }

  bool checkUser() {
    var params = {
    };
    if (SpUtils.getIntValue(SpUtils.KEY_ACCOUNT) != 0) {
      HttpManager.getInstance().get(Api.USERDATA, params,
          //正常回调
          (data) {
        LoadingUtils.showToast(data.toString());
      }, (error) {
        print("网络异常，请稍后重试 $error");
      });
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
