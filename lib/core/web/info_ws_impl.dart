import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:forte_life/core/client/http_client.dart';
import 'package:forte_life/core/models/info_model.dart';
import 'package:forte_life/core/models/info_response.dart';
import 'package:forte_life/core/services/info_service.dart';
import 'package:forte_life/utils/constants/api_constants.dart';

class InfoWebServiceImpl implements InfoService {
  final AppHttpClient _client;

  InfoWebServiceImpl(this._client);

  @override
  Future<List<Info>> getInfo() async {
    try {
      final Response<List<dynamic>> response = await _client.get("index.php",
          query: <String, String>{
            "dispatch": ApiConstants.info,
            "api_key": ApiConstants.apiKey
          });
      return InfoResponse.fromJson(response.data).info;
    } on DioError {
      return InfoResponse.fromJson(jsonDecode(_cachedJson)).info;
    }
  }
}

const String _cachedJson = '['
    '{'
    '   "page_id":0,'
    '   "isFromCache":true,'
    '   "externalUrl":"https:\/\/forte-life.com.ua\/ua\/pay\/?mobile=1",'
    '   "name":"\u041f\u043e\u0432\u0442\u043e\u0440\u043d\u0430 \u043e\u043f\u043b\u0430\u0442\u0430",'
    '   "iconUrl":"https:\/\/forte-life.com.ua\/www\/images\/mobile_app\/pages_icons\/pay.svg"'
    '},'
    '{'
    '   "page_id":345,'
    '   "isFromCache":true,'
    '   "name":"\u041f\u0440\u043e \u043a\u043e\u043c\u043f\u0430\u043d\u0456\u044e",'
    '   "iconUrl":"https:\/\/forte-life.com.ua\/www\/images\/mobile_app\/pages_icons\/345.svg",'
    '   "callback":true'
    '},'
    '{'
    '   "page_id":347,'
    '   "isFromCache":true,'
    '   "name":"\u0420\u0435\u043a\u0432\u0456\u0437\u0438\u0442\u0438",'
    '   "iconUrl":"https:\/\/forte-life.com.ua\/www\/images\/mobile_app\/pages_icons\/347.svg",'
    '    "callback":true'
    ' },'
    ' {'
    '    "page_id":348,'
    '   "isFromCache":true,'
    '    "name":"\u041a\u043e\u043d\u0442\u0430\u043a\u0442\u0438",'
    '    "iconUrl":"https:\/\/forte-life.com.ua\/www\/images\/mobile_app\/pages_icons\/348.svg"'
    ' },'
    ' {'
    '    "page_id":349,'
    '   "isFromCache":true,'
    '    "name":"\u0422\u0440\u0435\u043d\u0456\u043d\u0433-\u0446\u0435\u043d\u0442\u0440",'
    '    "iconUrl":"https:\/\/forte-life.com.ua\/www\/images\/mobile_app\/pages_icons\/349.svg"'
    ' },'
    ' {'
    '    "page_id":350,'
    '   "isFromCache":true,'
    '    "name":"\u0410\u0433\u0435\u043d\u0442\u0441\u044c\u043a\u0430 \u043c\u0435\u0440\u0435\u0436\u0430",'
    '    "iconUrl":"https:\/\/forte-life.com.ua\/www\/images\/mobile_app\/pages_icons\/350.svg"'
    ' },'
    ' {'
    '    "page_id":346,'
    '   "isFromCache":true,'
    '    "name":"\u0422\u0440\u0430\u043f\u0438\u0432\u0441\u044f \u0441\u0442\u0440\u0430\u0445\u043e\u0432\u0438\u0439 \u0432\u0438\u043f\u0430\u0434\u043e\u043a?",'
    '    "iconUrl":"https:\/\/forte-life.com.ua\/www\/images\/mobile_app\/pages_icons\/346.svg"'
    ' }'
    ']';
