import 'news_model.dart';

class NewsResponse {
  List<News> news;

  NewsResponse({this.news});

  NewsResponse.fromJson(List<dynamic> json) {
    if (json != null) {
      news = <News>[];
      news.addAll(
        (json)
            ?.map((dynamic v) => News.fromJson(v as Map<String, dynamic>))
            ?.cast<News>()
            ?.toList(),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news.map((News v) => v.toJson()).toList();
    }
    return data;
  }
}
