import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

class StorageItem {
  final String key;
  final dynamic value;

  StorageItem({required this.key, required this.value});
}

class StorageService {
  final _secureStorage = const FlutterSecureStorage();
  final _getStorage = GetStorage();

  static final StorageService _singleton = StorageService._internal();

  factory StorageService() {
    return _singleton;
  }

  StorageService._internal();

  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll();
  }

  Future<void> writeNormalData(StorageItem item) async {
    await _getStorage.write(item.key, item.value);
  }

  dynamic readNormalData(String key) {
    return _getStorage.read(key);
  }

  Future<void> deleteNormalData(String key) async {
    await _getStorage.remove(key);
  }
}

extension StorageServiceExt on StorageService {
  Future<String?> get apiToken async =>
      await _secureStorage.read(key: AppConstant.apiKey);

  Future<void> setApiToken(String? apiToken) =>
      _secureStorage.write(key: AppConstant.apiKey, value: apiToken);
}
