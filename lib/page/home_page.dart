import 'package:cooper/http/api.dart';
import 'package:cooper/model/article.dart';
import 'package:cooper/model/model_article_list_entity.dart';
import 'package:cooper/view/adapter/home_page_listview.dart';
import 'package:cooper/view/loading_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cooper/http/http_client.dart';
import 'package:cooper/utils/adapt_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

ArticleList articleResponse = ArticleList();
List<ArticleListData>? aListData = [];
List<Article> _networkResult = [];

class _HomeState extends State<HomePage> {
  final ScrollController? _scrollController = ScrollController();
  int page = 0;
  bool addFlag = true;

  @override
  void initState() {
    super.initState();
    showList(0);
    _scrollController!.addListener(() {
      if (_scrollController!.position.pixels >
          _scrollController!.position.maxScrollExtent - 20) {
        setState(() {
          addFlag = false;
          showList(page + 1, isAdd: true);
        });
      }
    });
  }

  showList(int page, {bool isAdd = false}) {
    var params = {};
    HttpManager.getInstance().get(Api.articlePage(page), params,
        //正常回调
        (data) {
      setState(() {
        if (isAdd && addFlag) {
          LoadingUtils.show();
          _networkResult.addAll(ArticleBean.from(data["data"]).datas!);
          LoadingUtils.showToast("加载完成");
          addFlag = false;
          Future.delayed(const Duration(milliseconds: 3))
              .then((value) => {LoadingUtils.dismiss()});
        } else {
          _networkResult.clear();
          _networkResult = ArticleBean.from(data["data"]).datas!;
          LoadingUtils.showToast("刷新完成");
        }
      });
    }, (error) {
      print("网络异常，请稍后重试 $error");
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

  Widget _body() {
    var _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.cyan,
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  cursorColor: Colors.deepOrangeAccent,
                  maxLines: 1,
                  controller: _controller,
                  decoration: InputDecoration(
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
                  )),
              ),)
          ],
        ),
      ),
      body: RefreshIndicator(
        //圆圈进度颜色
        color: Colors.blue,
        //下拉停止的距离
        displacement: 30.0,
        //背景颜色
        backgroundColor: Colors.grey[200],
        onRefresh: () async {
          await showList(0);
          return Future.value();
        },
        child: HomePageArticleAdapter(
          articleList: _networkResult,
          mController: _scrollController,
        ),
      ),
    );
  }

  void onPressed() {
  }
}
