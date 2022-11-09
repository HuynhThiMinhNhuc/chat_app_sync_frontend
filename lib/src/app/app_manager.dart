import 'package:chat_app_sync/src/data/user.dart';

class AppManager{
  static final AppManager _singleton = AppManager._internal();
  factory AppManager() => _singleton;

  AppManager._internal();

  User? _currentUser;
  User? get currentUser => _currentUser;

  isSignIn() => _currentUser != null;
}