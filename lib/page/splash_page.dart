import 'package:cooper/content/navigation_constants.dart';
import 'package:cooper/navi/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  NavigationService navigation = NavigationService.instance;
  var imgUrl = "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png";

  @override
  void initState() {
    super.initState();
    setState(() {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        navigation.navigateToPageClear(path: NavigationConstants.HOME);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Flex(
      direction: Axis.vertical,
      children: [
            Expanded(child: Image.network(imgUrl)),
      ],
    )));
  }
}
