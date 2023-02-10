import 'dart:developer';

import 'package:chat_app_sync/src/common/base/storaged_service.dart';
import 'package:chat_app_sync/src/data/local/local.dart';
import 'package:chat_app_sync/src/data/local/models/my_account.model.dart';
import 'package:chat_app_sync/src/data/repository/user_repository.dart';
import 'package:get/get.dart';

class AppManager {
  static final AppManager _singleton = AppManager._internal();
  final _storageService = StorageService();
  factory AppManager() => _singleton;

  AppManager._internal();

  final Map<String, String> authHeader = <String, String>{};
  MyAccount? _currentUser;
  MyAccount? get currentUser => _currentUser;

  isSignIn() => currentUser != null;

  Future<void> setup() async {
    _currentUser = await Get.find<LocalDatasource>().getAccountUser();
  }

  Future<bool> tryLogIn() async {
    if (_currentUser == null) {
      return false;
    }
    var userRepo = Get.find<UserRepository>();
    try {
      var account =
          await userRepo.login(_currentUser!.userName, _currentUser!.password);
      saveKeyAndCurrentInfor(account, account.token);
    } catch (e) {
      log("Cannot tryLogin, err = ${e.toString()}");
      return false;
    }
    return true;
  }

  Future<void> cleanData() async {
    await saveKeyAndCurrentInfor(null, null);
    await setLastSyncTime(null);
    await Get.find<LocalDatasource>().cleanData();
    return;
  }

  Future<void> saveKeyAndCurrentInfor(MyAccount? user, String? token) async {
    _currentUser = user;
    await _storageService.setApiToken(token);
    if (token == null) {
      authHeader.remove('token');
    } else {
      authHeader.addAll({'token': token});
    }
    try {
      await Get.find<LocalDatasource>().setAccountUser(user);
    } catch (e) {
      log("Save account fail ${e.toString()}");
    }
  }

  Future<void> setLastSyncTime(DateTime? lastSyncTime) =>
      _storageService.setLastSyncTime(lastSyncTime);

  Future<String?> getUserToken() => _storageService.apiToken;
  Future<DateTime?> getLastSyncTime() => _storageService.lastSyncTime;
}
