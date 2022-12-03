import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/data/local/models/my_account.model.dart';

import '../model/user.dart';
import '../network/network.dart';
import '../local/local.dart';

class UserRepository {
  final NetworkDatasource _networkDatasource;
  final LocalDatasource _localDatasource;

  UserRepository({
    required NetworkDatasource networkDatasource,
    required LocalDatasource localDatasource,
  })  : _networkDatasource = networkDatasource,
        _localDatasource = localDatasource;

  Future<MyAccount> login(String userName, String password) async {
    final response = await _networkDatasource.login(userName, password);
    if (response.isSuccess) {
      var data = response.data!["user"];
      var token = response.data!["token"];
      return MyAccount(
        id: data["id"],
        name: data["name"],
        imageUri: data["imageUri"],
        userName: data["userName"],
        password: password,
        token: token,
      );
    }
    throw Exception(response.message);
  }
}
