import 'package:dio/dio.dart';
import 'package:forte_life/core/client/http_client.dart';
import 'package:forte_life/core/models/blinchiki_calculation_result.dart';
import 'package:forte_life/core/services/blinchiki_service.dart';
import 'package:forte_life/utils/constants/api_constants.dart';

class BlinchikiWSImpl implements BlinchikiService {
  final AppHttpClient _client;

  BlinchikiWSImpl(this._client);

  @override
  Future<BlinckikiCalculationResult> calculate(int sum) async {
    final Response<Map<String, dynamic>> response = await _client.get(
      "index.php",
      query: <String, dynamic>{
        "dispatch": ApiConstants.calculate_blinchiki,
        "api_key": ApiConstants.apiKey,
        'summ': sum,
      },
    );
    return BlinckikiCalculationResult.fromJson(response.data);
  }

  @override
  Future<bool> validateCode(String code) async {
    final Response<bool> response = await _client.get(
      "index.php",
      query: <String, dynamic>{
        "dispatch": ApiConstants.confirm_code_blinchiki,
        "api_key": ApiConstants.apiKey,
        'code': code,
      },
    );
    return response.data;
  }
}
