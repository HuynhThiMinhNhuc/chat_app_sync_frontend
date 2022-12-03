import 'dart:developer';

import 'package:chat_app_sync/src/data/local/local.dart';
import 'package:chat_app_sync/src/data/local/models/my_account.model.dart';
import 'package:get/get.dart';

// class Authenticate {
//   MyAccount? _instance;
//   MyAccount? get instance => _instance;

//   Future<MyAccount?> loadFromLocal() async {
//     var localDataSource = Get.find<LocalDatasource>();
//     _instance = await localDataSource.getAccountUser();
//     return instance;
//   }

//   Future<bool> set(MyAccount? newInstance) async {
//     var localDataSource = Get.find<LocalDatasource>();
//     var success = await localDataSource.setAccountUser(newInstance);
//     if (success) {
//       _instance = newInstance;
//     }
//     log('Set Authenticate to local success: $success');
//     return success;
//   }
// }
