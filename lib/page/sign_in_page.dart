import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  bool isReg = false;
  Function(String username, String password, {String? repassword}) onClickListener;

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
              child: EditText("请输入用户名", _controllerUserName),),
            Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: EditText("请输入密码", _controllerPwd),),
            Visibility(visible: isReg, child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: EditText("请再次输入密码", _controllerRePwd),)),
            Padding(padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: MaterialButton(
                minWidth: 100,
                color: Colors.cyan,
                child: Text(isReg ? "注册" : "登录"),
                onPressed: () {
                  onClickListener(_controllerUserName.text, _controllerPwd.text,
                      repassword: _controllerRePwd.text);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),),)
          ],
        ),)
    );
  }

  Widget EditText(String hint, TextEditingController _controller) {
    return TextField(
        textInputAction: TextInputAction.search,
        cursorColor: Colors.deepOrangeAccent,
        maxLines: 1,
        controller: _controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              onPressed: () {
                _controller.clear();
              },
              icon: const Icon(
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

