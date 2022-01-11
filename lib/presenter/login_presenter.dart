

import 'package:cooper/http/api.dart';
import 'package:cooper/http/http_client.dart';
import 'package:cooper/model/user.dart';
import 'package:cooper/utils/sp_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class LoginPresenter {
  var id = 0;
  void LoginOrReg(BuildContext context,FormData formData, String api) {
    HttpManager.getInstance().post(Api.LOGIN, formData, (data) {
      id = User.from(data["data"]).id!;
      if (id != 0) {
        SpUtils.putIntVale(SpUtils.KEY_ACCOUNT, id);
        Navigator.of(context).pop();
      }
    }, (error) {
      print("网络异常，请稍后重试 $error");
    });
  }
}
