import 'package:get/get.dart';

abstract class AppConstant {
  //AppSize
  static double width = Get.width;
  static double height = Get.height;

  //Api
  static const token = 'token';
  static const timeOut = 20000;
  static const baseUrl = 'http://172.16.1.221:8080';

  static const login = '/account/login';
  static const getRoomUrl = '/room/get-room';
  static const sendMessageUrl = '/message/send-message';
  static const getMessageUrl = '/message/load-room';

  //storage
  static const apiKey = 'meton_api_token';

  //Infinite list
  static const defaultPageSize = 5;

  static const sendMessageTask = "SEND_MESSAGE_TASK";
  static const getRoomTask = "GET_ROOM_TASK";
  static const syncMessageTask = "SYNC_MESSAGE_TASK";
}
