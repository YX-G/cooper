import 'package:dio/dio.dart';
import 'result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async{
    RequestOptions option = response.requestOptions;
    try {
      if (option.contentType != null && option.contentType!.contains("text")) {
        ResultData(response.data, true, 200);
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {
        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
        int code = response.data["code"];
        if (code == 0) {
          ResultData(response.data, true, 200, headers: response.headers);
        } else {
          return response.data;
        }
      }
    } catch (e) {
      print(e.toString() + option.path);
      ResultData(response.data, false, response.statusCode!.toInt(),
          headers: response.headers);
    }
    ResultData(response.data, false, response.statusCode!.toInt(),
        headers: response.headers);
    super.onResponse(response, handler);
  }
}
