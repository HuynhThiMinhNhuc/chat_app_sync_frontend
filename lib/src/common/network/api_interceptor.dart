import 'package:dio/dio.dart';

class ApiInterceptor extends InterceptorsWrapper{
  ApiInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }
  void setHeaderRequest(RequestOptions options) {
    //TODO: set apiToken
  }
}