import 'dart:ffi';

import 'package:cooper/view/theme_notifer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'base/app_init_provider.dart';
import 'navi/navigation_route.dart';
import 'navi/navigation_service.dart';
import 'package:provider/provider.dart';

//main入口
Future<void> main() async {
  await _init();
  runApp(MultiProvider(
    // 初始化
    providers: [...ApplicationProvider.instance.dependItems],
    child: const MyApp(),
  ));
}
//初始化
Future<void> _init() async {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeNotifier>().currentTheme,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
