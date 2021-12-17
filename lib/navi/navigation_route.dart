import 'package:cooper/content/navigation_constants.dart';
import 'package:cooper/page/home_page_state.dart';
import 'package:cooper/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.DEFAULT:
        return normalNavigate(const SplashPage(),NavigationConstants.DEFAULT);
      case NavigationConstants.HOME:
         return normalNavigate(const HomePageState(),NavigationConstants.HOME);
    }
    throw Exception(args.arguments);

  }

  MaterialPageRoute normalNavigate(Widget widget,String pageName) {
    return MaterialPageRoute(
      builder: (context) => widget,
      //analytciste görülecek olan sayfa ismi için pageName veriyoruz
      settings: RouteSettings(name: pageName)
    );
  }
}
