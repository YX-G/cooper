import 'package:cooper/page/sign_in_page.dart';
import 'package:cooper/view/loading_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  List<Widget> _tabList = [];
  List<Widget> _pageList = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabList.add(Text("登录"));
    _tabList.add(Text("注册"));

    _pageList.add(SignInPage(isReg: false,onClickListener: callback));
    _pageList.add(SignInPage(isReg: true, onClickListener: callback));

    _tabController = TabController(length: _tabList.length, vsync: this);
    _tabController.addListener(() {
      //点击tab回调一次，滑动切换tab不会回调
      if (_tabController.indexIsChanging) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        // title: const Text("登录/注册"),
        bottom: TabBar(
          unselectedLabelColor: Colors.black87,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          // isScrollable: true,
          controller: _tabController,
          tabs: _tabList,
          physics: const BouncingScrollPhysics(),
          onTap: (int index) {},
        ),
      ),
      body: SafeArea(
        child: TabBarView(
        children: _pageList,
        controller: _tabController,
      )),
    );
  }

  callback(String username, String password, {String? repassword}) {
    LoadingUtils.showToast(username);
  }
}
