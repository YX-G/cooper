import 'package:cooper/content/navigation_constants.dart';
import 'package:cooper/navi/navigation_service.dart';
import 'package:cooper/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MeState();
}

class _MeState extends State<MePage> with WidgetsBindingObserver {
  bool isLogin = false;
  String states = "";
  final Map<Icon, String> _itemList = {
    const Icon(Icons.http_sharp): "我的发布",
    const Icon(Icons.assistant_photo): "收藏",
    const Icon(Icons.hourglass_bottom_rounded): "关于",
  };

  @override
  void initState() {
    super.initState();
    print("AA====initState");
    checkLogin();
    WidgetsBinding.instance!.addObserver(this);
  }

  void checkLogin() {
    setState(() {
      int? value = SpUtils.getIntValue(SpUtils.KEY_ACCOUNT);
      if (value! > 0) {
        states = "已登录";
        isLogin = true;
      } else {
        states = "注册/登录";
        isLogin = false;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkLogin();
    print("AA====didChangeDependencies");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("AA====deactivate");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        // 应用任然托管在flutter引擎上,但是不可见.
        // 当应用处于这个状态时,引擎没有视图的运行.要不就是当引擎第一次初始化时处于attach视        图中,要不就是由于导航弹出导致的视图销毁后
        print("AA====AppLifecycleState.detached");
        break;
      case AppLifecycleState.inactive:
        // 应用在一个不活跃的状态,不会收到用户的输入
        // 在ios上,这个状态相当于应用或者flutter托管的视图在前台不活跃状态运行.当有电话进来时候应用转到这个状态等
        // 在安卓上,这个状态相当于应用或者flutter托管的视图在前台不活跃状态运行.另外一个activity获得焦点时,应用转到这个状态.比如分屏,电话等
        //   在这状态的应用应该假设他们是可能被paused的.

        print("AA====AppLifecycleState.inactive");
        break;
      case AppLifecycleState.paused:
        //应用当前对于用户不可见,不会响应用户输入,运行在后台.
        print("AA====AppLifecycleState.paused");
        break;
      case AppLifecycleState.resumed:
        // 应用可见,响应用户输入
        checkLogin();
        print("AA====AppLifecycleState.resumed");
        break;
      default:
    }
  }

  @override
  void dispose() {
    print("AA====dispose");
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("AA====build");
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {});
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        // physics: const NeverScrollableScrollPhysics(),
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: isLogin ? loginView() : signInBtn(),
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
              Visibility(
                visible: isLogin,
                child: IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    print("更多");
                  },
                ),
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

  TextButton signInBtn() {
    return TextButton(
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
    );
  }

  Widget loginView() {
    return Text(
      SpUtils.getIntValue(SpUtils.KEY_ACCOUNT).toString(),
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
