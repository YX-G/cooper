import 'dart:collection';

import 'package:cooper/http/api.dart';
import 'package:cooper/model/article.dart';
import 'package:cooper/model/model_article_list_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:cooper/http/http_client.dart';

import 'adapter/home_page_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

ArticleList articleResponse = ArticleList();
List<ArticleListData>? aListData = [];
List<Article> _networkResult = [];

class _HomeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    var params = {};
    HttpManager.getInstance().get(Api.articlePage(0), params,
        //正常回调
        (data) {
      setState(() {
        _networkResult = ArticleBean.from(data["data"]).datas!;
      });
    }, (error) {
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

Widget _body() {
  return HomePageArticleAdapter(articleList: _networkResult);
}
