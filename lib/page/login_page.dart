import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=> _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {

     return _body();
  }
  Widget _body() {
    return const Scaffold(
       body: Text("login page"),
    );
  }
}
