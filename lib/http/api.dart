class Api {

  static String BASE_URL = "https://www.wanandroid.com";
  static String LOGIN = "/user/login";
  static String REGISTER = "/user/register";
  static String USERDATA = "//user/lg/userinfo/json";

  static String articlePage(int page){
    return "/article/list/$page/json";
  }
}
