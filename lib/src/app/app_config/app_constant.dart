import 'package:get/get.dart';

abstract class AppConstant {
  //AppSize 
  static double width = Get.width;
  static double height = Get.height;

  //Api
  static const token = 'token';
  static const timeOut = 20000;
  static const baseUrl = 'http://172.16.0.244:8080';
  static const login = '/account/login';

  //storage
  static const apiKey = 'meton_api_token';


  //Infinite list
  static const pageSize = 5;
}