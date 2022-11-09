import 'package:chat_app_sync/src/app/app_config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


final lightTheme = ThemeData(
  primaryColor: AppColors.kFF4328B5,
  brightness: Brightness.light,
  backgroundColor: AppColors.kFF242A3B,
  errorColor: AppColors.kFFFF295C,
  canvasColor: AppColors.kFF242A3B,
  secondaryHeaderColor: AppColors.kFF29FF5B,
  scaffoldBackgroundColor: AppColors.kFFFFFFFF,
  fontFamily: 'FiraSans',
  textTheme: TextTheme(headline4: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.bold),
        headline5: TextStyle(
            fontSize: 24.sp,
            color: AppColors.kFFFFFFFF,
            fontWeight: FontWeight.bold),
        headline6: TextStyle(
          fontSize: 20.sp,
          color: AppColors.kFFFFFFFF,
        ),
        bodyText1: TextStyle(
            fontSize: 16.sp,
            color: AppColors.kFFFFFFFF,
            fontWeight: FontWeight.bold),
        bodyText2: TextStyle(fontSize: 14.sp, color: AppColors.kFFFFFFFF),
        button: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kFFFFFFFF),
));