import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:forte_life/core/client/http_client.dart';
import 'package:forte_life/core/models/news_model.dart';
import 'package:forte_life/core/models/news_response.dart';
import 'package:forte_life/core/services/news_service.dart';
import 'package:forte_life/utils/constants/api_constants.dart';

class NewsWebServiceImpl implements NewsService {
  final AppHttpClient _client;

  NewsWebServiceImpl(this._client);

  @override
  Future<List<News>> getNews() async {
    try {
      final Response<String> response = await _client.get("index.php",
          query: <String, String>{
            "dispatch": ApiConstants.news,
            "api_key": ApiConstants.apiKey
          });
      return NewsResponse.fromJson(jsonDecode(response.data) as List<dynamic>)
          .news;
    } on DioError {
      return NewsResponse.fromJson(jsonDecode(_cachedJson)).news;
    }
  }
}

const String _cachedJson = '['
    '{'
    '"page_id":370,'
    '"name":"Щоденні виплати клієнтам ",'
    '"short_description":"Статистика страхових виплат за 14 грудня 2020 року.",'
    '"timestamp":1607896800,'
    '   "isFromCache":true,'
    '"iconUrl":"https:\/\/forte-life.com.ua\/images\/mobile\/0\/money.png"'
    '},'
    '{'
    '"page_id":369,'
    '   "isFromCache":true,'
    '"name":"Онлайн-вебінари агентської мережі",'
    '"short_description":"Навчання онлайн для потенційних клієнтів, агентів та менеджерів",'
    '"timestamp":1607637600,'
    '"iconUrl":"https:\/\/forte-life.com.ua\/images\/mobile\/0\/agent.png"'
    '},'
    '{'
    '"page_id":368,'
    '   "isFromCache":true,'
    '"name":"15 років «Форте Лайф»: досягнення у цифрах",'
    '"short_description":"За 15 років діяльності СК «Форте Лайф» досягла високих показників. Читайте детальніше про здобутки компанії",'
    '"timestamp":1607378400,'
    '"iconUrl":"https:\/\/forte-life.com.ua\/images\/mobile\/0\/rost.png"'
    '},'
    '{'
    '   "isFromCache":true,'
    '"page_id":365,'
    '"name":"Відпочивай з Форте Лайф!",'
    '"short_description":"Переможці акції «Wels» відпочивають у Єгипті",'
    '"timestamp":1606946400,'
    '"iconUrl":"https:\/\/forte-life.com.ua\/images\/mobile\/0\/travelling.png"'
    '}'
    ']';
