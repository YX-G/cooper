import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatelessWidget {
  bool isReg = false;
  Function(bool isReg,String username, String password, {String? repassword}) onClickListener;

  SignInPage({Key? key, required this.isReg, required this.onClickListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controllerUserName = TextEditingController();
    var _controllerPwd = TextEditingController();
    var _controllerRePwd = TextEditingController();
    return Scaffold(
        body: Center(child: Column(
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: EditText("请输入用户名", _controllerUserName,false),),
            Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: EditText("请输入密码", _controllerPwd,true),),
            Visibility(visible: isReg, child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: EditText("请再次输入密码", _controllerRePwd,true),)),
            Padding(padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: MaterialButton(
                minWidth: 100,
                textColor:Colors.white,
                color: Colors.cyan,
                child: Text(isReg ? "注册" : "登录"),
                onPressed: () {
                  onClickListener(isReg,_controllerUserName.text, _controllerPwd.text,
                      repassword: _controllerRePwd.text);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),),)
          ],
        ),)
    );
  }

  Widget EditText(String hint, TextEditingController _controller,bool needHid) {
    return TextField(
        obscureText:needHid ,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.deepOrangeAccent,
        maxLines: 1,
        controller: _controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(needHid?Icons.lock:Icons.search),
          suffixIcon: IconButton(
              onPressed: () {
                _controller.clear();
              },
              icon: Icon(
                Icons.clear,
              )),
          focusColor: Colors.grey,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              color: Colors.black54,
              width: 0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              borderSide: BorderSide(
                color: Colors.amber,
                width: 1, //宽度为5
              )),
        ));
  }
}

