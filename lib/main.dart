import 'dart:async';
import 'dart:io';

import 'package:cooper/utils/sp_utils.dart';
import 'package:cooper/view/theme_notifer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'base/app_init_provider.dart';
import 'navi/navigation_route.dart';
import 'navi/navigation_service.dart';
import 'package:provider/provider.dart';

//main入口
Future<void> main() async {
  // 转发至 Zone 的错误回调
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };
  runApp(MultiProvider(
    // 初始化
    providers: [...ApplicationProvider.instance.dependItems],
    child: const MyApp(),
  ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    if(Platform.isAndroid){//沉浸式状态栏
    //写在组件渲染之后，是为了在渲染后进行设置赋值，覆盖状态栏，写在渲染之前对MaterialApp组件会覆盖这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  await _init();

}
//初始化
Future<void> _init() async {
  await SpUtils.getInstance();

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeNotifier>().currentTheme,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      builder: EasyLoading.init()
    );
  }
}
