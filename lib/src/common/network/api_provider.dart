import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/common/network/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiProvider {
  late Dio _dio;

  ApiProvider() {
    final dioOptions = BaseOptions();
    dioOptions.connectTimeout = AppConstant.timeOut;
    dioOptions.sendTimeout = AppConstant.timeOut;
    dioOptions.receiveTimeout = AppConstant.timeOut;
    dioOptions.baseUrl = AppConstant.baseUrl;
    dioOptions.responseType = ResponseType.json;


    _dio = Dio(dioOptions);

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          responseHeader: true,
          requestBody: true,
          responseBody: true,
          compact: false));
    }
  }

  Future<dynamic> get(String path,{ Map<String, dynamic>? params}) async {
    final res = await _dio.get(path, queryParameters: params);
    final responseData = _throwIfNotSuccess(response: res);
    return responseData;
  }

  Future<dynamic> post(String path,{ Map<String, dynamic>? params,
      Map<String, dynamic>? data}) async {
    final res = await _dio.post(path, queryParameters: params, data: data);
    final resData = _throwIfNotSuccess(response: res);
    return resData;
  }

  _throwIfNotSuccess({required Response response}) {
    final resData = response.data;
    switch (response.statusCode) {
      case 200:
        return resData;
      case 400:
        throw InvalidPrameter(response.statusCode);
      case 401:
        throw UnauthoriseException(response.statusCode);
      case 403:
        throw ForbiddenExeption(response.statusCode);
      case 404:
        throw ResourceNotFound(response.statusCode);
      default:
        throw FetchDataException(response.statusCode);
    }
  }
}
