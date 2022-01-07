import 'package:cooper/model/user.dart';
import 'package:cooper/navi/navigation_service.dart';
import 'package:cooper/view/theme_notifer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ApplicationProvider{
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance{
    _instance??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (context) => ThemeNotifier(),),
    ChangeNotifierProvider<User>(create: (context) => User(),),
    Provider.value(value: NavigationService.instance),
  ];
}