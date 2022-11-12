import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/common/network/api_provider.dart';
import 'package:chat_app_sync/src/common/network/api_response.dart';

class UserRepository {
  final ApiProvider _apiProvider;

  UserRepository(this._apiProvider);

  Future<ResponseData<Map<String, dynamic>>> login(String userName, String password) async {
    try {
      final params = {'user_name': userName, 'password': password};

      final res = await _apiProvider.post(AppConstant.login, params: params);
      return ResponseData.success(res.data, response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }
}
