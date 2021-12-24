class Api {

  static String BASE_URL = "https://www.wanandroid.com";

  static String articlePage(int page){
    return "/article/list/$page/json";
  }
}
