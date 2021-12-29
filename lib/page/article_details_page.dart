import 'package:cooper/model/route_values.dart';
import 'package:cooper/utils/adapt_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatefulWidget {
  ArticleDetailPage({Key? key, required RouteValue value}) : super(key: key) {
    mValue = value;
  }

  @override
  State<StatefulWidget> createState() => _ArticlePage();
}

RouteValue? mValue;

class _ArticlePage extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(
            mValue!.title ?? "",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: WebView(
          initialUrl: mValue!.url ?? "",
          javascriptMode: JavascriptMode.unrestricted,
        )
      );
  }
}
