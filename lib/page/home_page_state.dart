import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'me_page.dart';

class HomePageState extends StatefulWidget {
  const HomePageState({Key? key}) : super(key: key);

  @override
  State<HomePageState> createState() => MyHomePageState();
}

List<Widget> _list = [];
int _currentIndex = 0;
class MyHomePageState extends State<HomePageState> {


  @override
  void initState() {
    _list
      ..add(const HomePage())
      ..add(const MePage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _list[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            //设置背景色`BottomNavigationBar`
            canvasColor: Colors.white70,
            //设置高亮文字颜色
            primaryColor: Colors.white,
            //设置一般文字颜色
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: Colors.white))),
        child: _bottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      items: _items(),
      type: BottomNavigationBarType.shifting,
      currentIndex: _currentIndex,
      fixedColor: Colors.cyan,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  List<BottomNavigationBarItem> _items() {
    return [
      BottomNavigationBarItem(
        icon: getTabImage('images/tabz.png'),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: getTabImage('images/tabz.png'),
        label: 'Me',
      ),
    ];
  }

  Image getTabImage(path) {
    return Image.asset(
      path,
      width: 20.0,
      height: 20.0,
    );
  }
}

mixin _search {}
