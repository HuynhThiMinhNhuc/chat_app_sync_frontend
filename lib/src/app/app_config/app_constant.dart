import 'package:get/get.dart';

abstract class AppConstant {
  //AppSize 
  static double width = Get.width;
  static double height = Get.height;

  //Api
  static const timeOut = 20000;
  static const baseUrl = 'http://localhost:3069/';
  static const login = '/user/login';

  //Infinite list
  static const pageSize = 5;
}