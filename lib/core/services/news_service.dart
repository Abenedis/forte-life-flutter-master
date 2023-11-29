import 'package:forte_life/core/models/news_model.dart';

abstract class NewsService {
  Future<List<News>> getNews();
}
