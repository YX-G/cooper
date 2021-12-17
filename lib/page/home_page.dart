import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:cooper/http/http_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    var params = {
      "cid": 500
    };
    HttpManager.getInstance()
        .get('/heg_api/advertising/getNodeList.do', params,
        //正常回调
            (data) {
          setState(() {
             list[2].content=data.toString();

          });
        },
        //错误回调
            (error) {
          print("网络异常，请稍后重试");
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
}

class BaseBean {
  String name;
  int age;
  String content;

  BaseBean(this.name, this.age, this.content);
}

List<BaseBean> list =
List<BaseBean>.generate(60, (i) => BaseBean("name$i", i, "content=$i"));

Widget _body() {
  return ListView.custom(
      scrollDirection: Axis.vertical,
      primary: true,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      childrenDelegate: ChildDelegate((BuildContext context, int i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Padding(padding: const EdgeInsets.all(20),
                child: Text(list[i].content.toString()))
          ],
        );
      }, childCount: list.length));
}

class ChildDelegate extends SliverChildBuilderDelegate {
  ChildDelegate(Widget Function(BuildContext, int) builder, {
    required int childCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) : super(builder,
      childCount: childCount,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries);

  @override
  bool shouldRebuild(SliverChildBuilderDelegate oldDelegate) {
    return super.shouldRebuild(oldDelegate);
  }

  @override
  void didFinishLayout(int firstIndex, int lastIndex) {}
}
