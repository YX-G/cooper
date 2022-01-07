import 'package:cooper/http/api.dart';
import 'package:cooper/http/http_client.dart';
import 'package:cooper/model/user.dart';
import 'package:cooper/page/sign_in_page.dart';
import 'package:cooper/utils/sp_utils.dart';
import 'package:cooper/view/loading_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool isReg = false;
  var id = 0;
  @override
  void initState() {
    super.initState();

    _tabList.add(Text("登录"));
    _tabList.add(Text("注册"));

    _pageList.add(SignInPage(isReg: false, onClickListener: callback));
    _pageList.add(SignInPage(isReg: true, onClickListener: callback));

    _tabController = TabController(length: _tabList.length, vsync: this);
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

  callback(bool isReg, String username, String password, {String? repassword}) {
    FormData formData = FormData.fromMap({
      "username": "$username",
      "password": "$password",
    });

    if (!isReg) {
      HttpManager.getInstance().post(Api.LOGIN, formData,
        (data) {
        setState(() {
          id = User.from(data["data"]).id!;
          if (id!=0) {
            SpUtils.save(SpUtils.KEY_ACCOUNT, id);
            Navigator.of(context).pop();
          }
        });
      }, (error) {
        print("网络异常，请稍后重试 $error");
      });
    }
  }
}
