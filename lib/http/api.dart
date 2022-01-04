class Api {

  static String BASE_URL = "https://www.wanandroid.com";
  static String LOGIN = "/user/login";
  static String REGISTER = "user/register";

  static String articlePage(int page){
    return "/article/list/$page/json";
  }
}
