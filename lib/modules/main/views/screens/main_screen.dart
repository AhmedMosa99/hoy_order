// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social_increase/modules/home/controller/home_controller.dart';
import 'package:social_increase/modules/main/controller/main_controller.dart';
import 'package:social_increase/modules/orders/controller/controller.dart';
import 'package:social_increase/utils/component/component.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var controlMain = Get.put(() => MainController());
  var controlHome = Get.put( HomeController());
  var controlOrder = Get.lazyPut(() => OrderController(), fenix: true);
  @override
  void initState() {
    controlHome.getPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (logic) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: logic.screens[logic.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              logic.changeIndex(index);
            },
            enableFeedback: true,
            currentIndex: logic.currentIndex,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),

                  label: 'Profile'


              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),

                  label: 'Link'


              ),

              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active_outlined),
                  label: 'Notifications',



              ),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding:  EdgeInsets.only(bottom: 4.0.h),
                    child: SvgPicture.asset('assets/images/order.svg',
                      color: logic.currentIndex==4? Color(0xff232f3e):Color(0xff707070),

                    ),
                  ),

                  label: 'Orders'),

            ],
          ),
        ),
      );
    });
  }
}
