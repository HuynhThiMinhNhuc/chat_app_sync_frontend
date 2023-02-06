import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends InterceptorsWrapper {
  ApiInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await setHeaderRequest(options);
    super.onRequest(options, handler);
  }

  Future<void> setHeaderRequest(RequestOptions options) async {
    final appManager = AppManager();
    if (appManager.isSignIn()) {
      options.headers[AppConstant.token] = await appManager.getUserToken();
    }
  }
}
