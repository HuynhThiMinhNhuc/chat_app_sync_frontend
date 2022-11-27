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

  Future<User> login(String userName, String password) async {
    final response = await _networkDatasource.login(userName, password);
    if (response.isSuccess()) {
      return User.fromJson(response.data!);
    }
    throw Exception(response.message);
  }

  



}
