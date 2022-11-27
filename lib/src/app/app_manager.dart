import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/common/base/storaged_service.dart';
import 'package:chat_app_sync/src/data/model/user.dart';

class AppManager{
  static final AppManager _singleton = AppManager._internal();
  final _storageService = StorageService();
  factory AppManager() => _singleton;


  AppManager._internal();

  Map<String, String>? authHeader;
  User? _currentUser;
  User? get currentUser => _currentUser;

  isSignIn() => _currentUser != null;

   Future<void> saveKeyAndCurrentInfor(User user, String token) async {
    await _storageService.setApiToken(token);

    _currentUser = user;
  }

   Future<String?> getUserToken() async {
    final token = await _storageService.apiToken;
    if (token == null) return null;
    return token;
  }


}