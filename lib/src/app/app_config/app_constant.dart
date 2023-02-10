import 'package:get/get.dart';

abstract class AppConstant {
  //AppSize
  static double width = Get.width;
  static double height = Get.height;

  //Api
  static const token = 'token';
  static const timeOut = 10000;
  static const baseUrl = 'http://10.0.31.231:8080';

  static const login = '/account/login';
  static const getRoomUrl = '/room/get-room';
  static const sendMessageUrl = '/message/send-message';
  static const getMessageUrl = '/message/load-room';
  static const search = '/message/search';
  static const syncDataUrl = '/sync/sync-data';

  //storage
  static const apiKey = 'meton_api_token';
  static const lastSyncTime = 'meton_api_last_sync_time';

  //Infinite list
  static const defaultPageSize = 5;

  static const sendMessageTask = "SEND_MESSAGE_TASK";
  static const getRoomTask = "GET_ROOM_TASK";
  static const syncMessageTask = "SYNC_MESSAGE_TASK";

  static const isResetDb = true;
  static const isClearCache = true;
}
