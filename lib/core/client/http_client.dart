import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:forte_life/core/errors/server_error.dart';
import 'package:forte_life/utils/constants/api_constants.dart';

import 'retry_interceptor.dart';

class AppHttpClient {
  AppHttpClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.timeout,
        responseType: ResponseType.json,
        // contentType: 'application/json',
      ),
    );
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onResponse: _interceptResponse,
        onRequest: _interceptRequest,
        onError: _interceptError,
      ),
      if (kDebugMode)
        LogInterceptor(
          responseBody: true,
          requestHeader: false,
          responseHeader: false,
          requestBody: true,
        ),
    ]);
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(dio: _dio),
      ),
    );
  }

  Dio _dio;

  Future<Response<T>> get<T>(String url,
      {Map<String, dynamic> query = const <String, dynamic>{}}) async {
    return _dio.get<T>(
      url,
      queryParameters: query,
    );
  }

  Future<Object> request(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
    Map<String, dynamic> query = const <String, dynamic>{},
  }) {
    _dio.request<Map<String, dynamic>>(
      url,
    );
    return null;
  }

  Future<Response<T>> post<T>(
    String url,
    Map<String, dynamic> body, {
    Map<String, dynamic> query = const <String, dynamic>{},
  }) async {
    return _dio.post<T>(
      url,
      data: body,
      queryParameters: query,
    );
  }

  Future<Response<Map<String, dynamic>>> put(
    String url, {
    Map<String, dynamic> query = const <String, dynamic>{},
  }) async {
    return _dio.put<Map<String, dynamic>>(
      url,
      queryParameters: query,
    );
  }

  Future<Response<dynamic>> delete(
    String url, {
    Map<String, dynamic> query = const <String, dynamic>{},
  }) async {
    return _dio.delete<dynamic>(
      url,
      queryParameters: query,
    );
  }

  Future<void> _interceptError(DioError error) async {
    if ((error.response?.statusCode == HttpStatus.internalServerError) ??
        false) {
      final dynamic responseData = error.response.data;
      Map<String, dynamic> json;
      if (responseData is Map) {
        json = responseData.cast<String, dynamic>();
      } else {
        json =
            jsonDecode(error.response.data.toString()) as Map<String, dynamic>;
      }
      throw ServerError.fromJson(json);
    }
  }

  Future<RequestOptions> _interceptRequest(RequestOptions request) async =>
      request;

  Future<Response<dynamic>> _interceptResponse(
          Response<dynamic> response) async =>
      response;
}
