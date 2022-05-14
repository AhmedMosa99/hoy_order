import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_increase/services/shared_pref.dart';
import 'package:social_increase/utils/bindings.dart';
import 'package:social_increase/utils/constant.dart';
import 'package:social_increase/utils/languages/lang.dart';
import 'package:social_increase/utils/splash_screen.dart';
import 'package:social_increase/utils/themeing/theme_data.dart';

import 'modules/auth/models/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  userInfo = await SharePref.getData(key: 'userInfo') == null
      ? null
      : LoginModel.fromJson(
          json.decode(await SharePref.getData(key: 'userInfo')));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_) => GetMaterialApp(
          smartManagement: SmartManagement.keepFactory,
          translations: Messages(),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en', 'US'),
          initialBinding: Binding(),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          home: const SplashScreen()),
    );
  }
}
