import 'package:cooper/http/api.dart';
import 'package:cooper/page/sign_in_page.dart';
import 'package:cooper/presenter/login_presenter.dart';
import 'package:cooper/utils/adapt_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin, LoginPresenter {
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
      body: Column(
         children: [SizedBox(
             height: 150,
             child:Center(child: Text(
               "Welcome to Cooper",
               style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
             ),)),
           SizedBox(height:screenAdapt.screenH()/2,child: TabBarView(
             children: _pageList,
             controller: _tabController,
           ),)],
      ),
    );
  }

  callback(bool isReg, String username, String password, {String? repassword}) {
    FormData formData = FormData.fromMap({
      "username": "$username",
      "password": "$password",
    });

    if (!isReg) {
      LoginOrReg(context, formData, Api.LOGIN);
    } else {
      formData.fields.add(MapEntry("repassword", repassword!));
      LoginOrReg(context, formData, Api.REGISTER);
    }
  }
}
