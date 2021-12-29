import 'dart:async';

import 'package:cooper/content/navigation_constants.dart';
import 'package:cooper/model/article.dart';
import 'package:cooper/model/route_values.dart';
import 'package:cooper/navi/navigation_service.dart';
import 'package:cooper/utils/adapt_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageArticleAdapter extends StatelessWidget {
  List<Article> _networkResult = [];

  late ScrollController _scrollController;

  HomePageArticleAdapter(
      {Key? key,
      required List<Article> articleList,
      ScrollController? mController})
      : super(key: key) {
    _networkResult = articleList;
    _scrollController = mController!;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            // controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 0),
            physics: const BouncingScrollPhysics(),
            childrenDelegate: ChildDelegate((BuildContext context, int i) {
              return GestureDetector(child:Card(
                clipBehavior: Clip.antiAlias,
                elevation: 5,
                //阴影
                shape: const RoundedRectangleBorder(
                  //形状
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                color: Colors.white,
                //margin
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    contentImage(i, _networkResult[i].envelopePic ?? ""),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: screenAdapt.screenW() - 40,
                      child: Text(
                        _networkResult[i].title ?? "",
                        maxLines: 3,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        width: screenAdapt.screenW() - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              authorStr(_networkResult[i].author ?? ""),
                              style: const TextStyle(fontSize: 10.0),
                            ),
                            Text(
                              "分类: ${_networkResult[i].chapterName ?? ""}",
                              style: const TextStyle(fontSize: 10.0),
                            ),
                            Text(
                              "发布时间: ${_networkResult[i].niceDate ?? ""}",
                              style: const TextStyle(fontSize: 10.0),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              onTap:(){
                NavigationService.instance.navigateToPage
                  (path: NavigationConstants.ARTICLEDETAILPAGE
                    ,data : RouteValue(title:_networkResult[i].title,url: _networkResult[i].link ));
              },);
            }, childCount: _networkResult.length)
        );
  }

  String authorStr(String str) {
    if (str != "") {
      str = "作者: $str";
    } else {
      str = "作者: 匿名作者";
    }
    return str;
  }

  Widget contentImage(int i, String imageUrl) {
    Image image;
    if (imageUrl != "") {
      image = Image.network(
        imageUrl,
        isAntiAlias: true,
        fit: BoxFit.fitWidth,
        width: screenAdapt.screenW() - 30,
      );
      Completer completer = Completer();
      image.image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((image, synchronousCall) {
        completer.complete(image.image);
      }));
      return image;
    } else {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}

class ChildDelegate extends SliverChildBuilderDelegate {
  ChildDelegate(
    Widget Function(BuildContext, int) builder, {
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
