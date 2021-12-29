import 'package:flutter/material.dart';

abstract class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
         return _commonTitle();

  }

  Widget _commonTitle() {
    return AppBar();
  }
}
