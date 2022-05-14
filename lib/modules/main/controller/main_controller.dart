import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_increase/modules/Profile/views/screens/my_profile.dart';
import 'package:social_increase/modules/home/views/screens/byeType.dart';
import 'package:social_increase/modules/home/views/screens/home.dart';
import 'package:social_increase/modules/main/models/category.dart';
import 'package:social_increase/modules/notification/views/screens/notification_screen.dart';
import 'package:social_increase/modules/orders/views/screens/order_screen.dart';
import 'package:social_increase/services/data_fetch.dart';

class MainController extends GetxController {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    MyProfile(),
    ByeOrder(),
    NotificationScreen(),
    OrderScreen(),
  ];

  List<CategoryModel> allCategories = [];
  changeIndex(int index) {
    currentIndex = index;
    update();
  }

  getCategory() async {
    List<dynamic> categories = await DioHandler.apiHelper.getCategoriy();
    allCategories = categories.map((e) => CategoryModel.fromJson(e)).toList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }
}
