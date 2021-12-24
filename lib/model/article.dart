
class ArticleBean {
  int? curPage;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;
  List<Article>? datas =[];

  ArticleBean(
      {this.curPage,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total,
      this.datas});

  factory ArticleBean.from(Map<String, dynamic> parsedJson) {
    return ArticleBean(
      curPage: parsedJson["curPage"],
      offset: parsedJson["offset"],
      over: parsedJson["over"],
      pageCount: parsedJson["pageCount"],
      size: parsedJson["size"],
      total: parsedJson["total"],
      datas: (parsedJson['datas'] as List)
          .map((i) => Article.fromJson(i))
          .toList(),
    );
  }
}

class Article {
   String? author;
   String? chapterName;
   String? title;
   String? niceDate;
   String? superChapterName;
   String? link;
   List<Tag>? tags;

  Article(
      {this.author,
      this.chapterName,
      this.title,
      this.niceDate,
      this.superChapterName,
      this.link,
      this.tags});

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    return Article(
        author: parsedJson['author'],
        chapterName: parsedJson['chapterName'],
        title: parsedJson['title'],
        niceDate: parsedJson['niceDate'],
        superChapterName: parsedJson['superChapterName'],
        link: parsedJson['link'],
      tags: (parsedJson['tags'] as List)
          .map((i) => Tag.fromJson(i))
          .toList(),);
  }

}

class Tag{
  String? name;
  String? url;

  Tag({this.name, this.url});

  factory Tag.fromJson(Map<String, dynamic> parsedJson){
    return Tag(
      name: parsedJson['name'],
      url: parsedJson['url']
    );
  }
}
