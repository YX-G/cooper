import 'package:cooper/content/navigation_constants.dart';
import 'package:cooper/model/user.dart';
import 'package:cooper/navi/navigation_service.dart';
import 'package:cooper/utils/adapt_screen.dart';
import 'package:cooper/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MeState();
}

class _MeState extends State<MePage> {
  bool isLogin = false;
  String states = "注册/登录";
  final Map<Icon, String> _itemList = {
    const Icon(Icons.http_sharp): "我的发布",
    const Icon(Icons.assistant_photo): "收藏",
    const Icon(Icons.hourglass_bottom_rounded): "关于",
  };

  @override
  void initState() {
    super.initState();

  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      SpUtils.get(SpUtils.KEY_ACCOUNT).then((value) => {
        if (value != 0) {states = "已登录"} else {states = "注册/登录"}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      // if(scrollController.offset<100){
      //   scrollController.animateTo(100.0, duration: const Duration(milliseconds: 1000),curve: Curves.ease);
      // }
    });
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        // physics: const NeverScrollableScrollPhysics(),
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: TextButton(
                onPressed: () {
                  NavigationService.instance
                      .navigateToPage(path: NavigationConstants.LOGIN);
                },
                child: Text(
                  states,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.black87;
                    }
                    return Colors.black12;
                  }),
                ),
              ),
              centerTitle: true,
              background: Image.asset(
                'images/test.jpg',
                fit: BoxFit.fill,
              ),
              collapseMode: CollapseMode.pin,
            ),
            expandedHeight: 150.0,
            backgroundColor: Colors.cyan,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 5,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  print("更多");
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: _itemList.keys.elementAt(index),
                enabled: false,
                title: Text(_itemList.values.elementAt(index)),
              ),
              childCount: _itemList.length,
            ),
          ),
          const SliverFillRemaining(),
        ],
      ),
    );
  }
}
