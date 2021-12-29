import 'package:cooper/enums/app_theme_enum.dart';
import 'package:cooper/view/theme_notifer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'me_page.dart';


class HomePageState extends StatefulWidget {
  const HomePageState({Key? key}) : super(key: key);

  @override
  State<HomePageState> createState() => MyHomePageState();
}
  List<Widget> _list=[];
  int _currentIndex=0;


class MyHomePageState extends State<HomePageState>{

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
      body:_list[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }



  BottomNavigationBar _bottomNavigationBar(){
    return BottomNavigationBar(
      items: _items(),
      backgroundColor: Colors.cyan,
      type: BottomNavigationBarType.shifting,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
  List<BottomNavigationBarItem> _items(){
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
