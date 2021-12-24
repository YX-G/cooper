import 'model_base.dart';

class ArticleList implements Model {
  @override
  int? errorCode;

  @override
  String? errorMsg;

  Data? data;

  @override
  Model? createModel(json) => ArticleList.fromJson(json);

  ArticleList({this.data});

  ArticleList.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   if (data != null) {
  //     map['data'] = data?.toJson();
  //   }
  //   return map;
  // }
}

class Data {
  int? curPage;
  List<ArticleListData>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  Data({this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total
  });

  Data.fromJson(dynamic json) {
    curPage = json['curPage'];
    datas = List<ArticleListData>.from(json['datas']);
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map['curPage'] = curPage;
  //   map['datas'] = datas;
  //   map['offset'] = offset;
  //   map['over'] = over;
  //   map['pageCount'] = pageCount;
  //   map['size'] = size;
  //   map['total'] = total;
  //   return map;
  // }
}

class ArticleListData {
  String? apkLink;
  String? chapterName;
  int? courseId;
  String? envelopePic;
  String? superChapterName;
  String? link;
  String? origin;
  String? projectLink;
  String? title;
}


