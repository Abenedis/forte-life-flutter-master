import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:forte_life/core/client/http_client.dart';
import 'package:forte_life/core/models/calculate_program_entity.dart';
import 'package:forte_life/core/models/program/popup_program_response.dart';
import 'package:forte_life/core/models/program/program_detail.dart';
import 'package:forte_life/core/models/program/zayava_request.dart';
import 'package:forte_life/core/models/program_model.dart';
import 'package:forte_life/core/models/program_response.dart';
import 'package:forte_life/core/services/program_service.dart';
import 'package:forte_life/utils/constants/api_constants.dart';

class ProgramWebServiceImpl implements ProgramService {
  final AppHttpClient _client;

  ProgramWebServiceImpl(this._client);

  @override
  Future<List<Program>> getPrograms() async {
    try {
      final Response<List<dynamic>> response = await _client.get("index.php",
          query: <String, String>{
            "dispatch": ApiConstants.programs,
            "api_key": ApiConstants.apiKey
          });
      return ProgramResponse.fromJson(response.data).programs;
    } on DioError {
      return ProgramResponse.fromJson(jsonDecode(_cachedJson)).programs;
    }
  }

  @override
  Future<ProgramDetail> getProgramById(int id) async {
    final Response<Map<String, dynamic>> response =
        await _client.get("index.php", query: <String, dynamic>{
      "dispatch": ApiConstants.program,
      'program_id': id,
      "api_key": ApiConstants.apiKey
    });
    return ProgramDetail.fromJson(response.data);
  }

  @override
  Future<PopupProgramResponse> calculateProgram(
      CalculateProgramEntity payload) async {
    final Response<Map<String, dynamic>> response = await _client.post(
      "index.php",
      payload.toJson(),
      query: <String, dynamic>{
        "dispatch": ApiConstants.calc,
        "api_key": ApiConstants.apiKey
      },
    );
    return PopupProgramResponse.fromJson(response.data);
  }

  @override
  Future<dynamic> createOrderRequest(ZayavaRequest payload) async {
    final Response<dynamic> response = await _client.post(
      "index.php",
      payload.toJson(),
      query: <String, dynamic>{
        "dispatch": ApiConstants.request_code,
        "api_key": ApiConstants.apiKey
      },
    );
    return response.data;
  }

  @override
  Future validateSMS(String phone, String code) async {
    final Response<dynamic> response = await _client.post(
      "index.php",
      <String, dynamic>{
        'phone': phone,
        'code': code,
      },
      query: <String, dynamic>{
        "dispatch": ApiConstants.confirm_code,
        "api_key": ApiConstants.apiKey
      },
    );
    return response.data;
  }
}

const String _cachedJson =
    '[{"program_id":36,"name":"36 Invest","iconUrl":"https://forte-life.com.ua/www/images/mobile_app/program_icons/36.svg","isPromo":false,"isBlinchiki":false},{"program_id":11,"name":"11 \u041d\u0435\u0440\u0443\u0445\u043e\u043c\u0456\u0441\u0442\u044c","iconUrl":"https://forte-life.com.ua/www/images/mobile_app/program_icons/11.svg","isPromo":false,"isBlinchiki":false},{"program_id":42,"name":"42 \u041e\u0431\u043b\u0456\u0433\u0430\u0446\u0456\u0457","iconUrl":"https://forte-life.com.ua/www/images/mobile_app/program_icons/42.svg","isPromo":false,"isBlinchiki":false},{"program_id":55,"name":"55 Wels","iconUrl":"https://forte-life.com.ua/www/images/mobile_app/program_icons/55.svg","isPromo":false,"isBlinchiki":false},{"program_id":37,"name":"37 Kids","iconUrl":"https://forte-life.com.ua/www/images/mobile_app/program_icons/37.svg","isPromo":false,"isBlinchiki":false},{"program_id":999,"name":"Demo Forte-Dom","iconUrl":"https://forte-life.com.ua/www/images/mobile_app/program_icons/demo-house.svg","isPromo":false,"isBlinchiki":true}]';
