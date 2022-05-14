import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_increase/modules/auth/views/widgets/login_widget.dart';
import 'package:social_increase/modules/main/controller/main_controller.dart';
import 'package:social_increase/modules/main/views/screens/main_screen.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(MainController());
  @override
  void initState() {
    // TODO: implement initState
    controller.getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Get.offAll(MainScreen());
                          },
                          icon: const Text('Try it'))),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    child: Center(
                        child: Image.asset(
                      'assets/images/logo.jpg',
                      width: 150.w,
                      height: 94.h,
                    )),
                  ),
                  Center(
                    child: Text(
                      'HoY Order',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 22.sp),
                    ),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  const LoginWidget(),
                ],
              )))),
    );
  }
}
