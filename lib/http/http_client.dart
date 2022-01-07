import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'api.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };
  static late HttpManager _instance;
  PersistCookieJar cookieJar= PersistCookieJar();
  static HttpManager getInstance() {
    _instance = HttpManager();
    return _instance;
  }

  Dio dio = Dio();
  HttpManager() {
    dio.options.baseUrl = Api.BASE_URL;
    // dio.options.headers= {"Access-Control-Allow-Origin", "*"};
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.interceptors.add(LogInterceptor(responseBody: true)); //是否开启请求日志
    cookieInit();

  }

  Future<void> cookieInit() async {
    Directory? documentsDir = await getExternalStorageDirectory();
    String path =documentsDir!.path + '/cookies';
    var dir = new Directory(path);
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(storage: FileStorage(dir.path))));
  }

  //get请求
  get(String url, Map params, Function successCallBack,
      Function errorCallBack) async {
    _requestHttp(url, successCallBack, 'get', params, errorCallBack);
  }

  //post请求
  post(String url, params, Function successCallBack,
      Function errorCallBack) async {
    _requestHttp(url, successCallBack, "post", params, errorCallBack);
  }

  _requestHttp(String url, Function successCallBack,
      [method, params, errorCallBack]) async {
    late Response response;
    cookieInit();

    if (method == 'get') {
      if (params != null && params.length > 0) {
        response = await dio.get(url, queryParameters: params);
      } else {
        response = await dio.get(url);
      }
    } else if (method == 'post') {
      if (params != null && params.length > 0) {
        response = await dio.post(url, data: params);
      } else {
        response = await dio.post(url);
      }
    }

    try {
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      successCallBack(dataMap);
    } on Exception catch (e) {
      errorCallBack(e);
    }
  }
  clearData(){
    dio.clear();
  }
}
