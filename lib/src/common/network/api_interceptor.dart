import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends InterceptorsWrapper{
  ApiInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final appManager = AppManager();
   if (appManager.isSignIn()){
    options.headers[AppConstant.token] = appManager.getUserToken();  
   }
    super.onRequest(options, handler);
  }
  void setHeaderRequest(RequestOptions options) {
    //TODO: set apiToken
  }
}