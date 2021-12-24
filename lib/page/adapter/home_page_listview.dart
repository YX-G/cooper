import 'package:cooper/model/article.dart';
import 'package:flutter/material.dart';

class HomePageArticleAdapter extends StatelessWidget{
  List<Article> _networkResult = [];

  HomePageArticleAdapter({Key? key, required List<Article> articleList})
      : super(key: key) {
    _networkResult = articleList;
  }
  @override
  Widget build(BuildContext context) {
    return ListView.custom(
        scrollDirection: Axis.vertical,
        primary: true,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,0),
        physics:  const BouncingScrollPhysics(),
        childrenDelegate: ChildDelegate((BuildContext context, int i) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(_networkResult[i].title.toString())))
            ],
          );
        }, childCount: _networkResult.length));
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