import 'dart:math';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_increase/modules/Profile/views/widgets/no_auth.dart';
import 'package:social_increase/modules/home/controller/home_controller.dart';
import 'package:social_increase/modules/main/views/screens/main_screen.dart';
import 'package:social_increase/utils/component/component.dart';
import 'package:social_increase/utils/constant.dart';

// ignore: use_key_in_widget_constructors
class ByeOrder extends StatefulWidget {
  @override
  State<ByeOrder> createState() => _ByeOrderState();
}

class _ByeOrderState extends State<ByeOrder> {
  final controller1 = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Buy by Link ",
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 18.sp),
        ),
      ),
      body: DoubleBack(
        message: "Press back again to close",
        child: userInfo == null
            ? Center(child: NoAuth())
            : Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<HomeController>(
                        builder: (logic) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Link',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              defaultFormField(
                                type: TextInputType.url,
                                controller: logic.link,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'Quantity',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                height: 44.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffC6C6C6),
                                        width: .5),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffC6C6C6),
                                                width: .5),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12))),
                                        child: IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () async {
                                              if (logic.counterOrder > 1) {
                                                await logic
                                                    .minusPackageCounter();
                                                setState(() {});
                                              }
                                            })),
                                    Text(
                                      logic.counterOrder.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffC6C6C6),
                                                width: .5),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    bottomLeft:
                                                        Radius.circular(12))),
                                        child: IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () async {
                                              await logic.addPackageCounter();
                                              setState(() {});
                                            })),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Color ',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('(Option)'),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              defaultFormField(
                                type: TextInputType.text,
                                controller: logic.color,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Size ',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('(Option)'),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              defaultFormField(
                                type: TextInputType.text,
                                controller: logic.size,
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text("Hoy Order"),
                                    onPressed: () {
                                      logic.postOrder(
                                        logic.link.text,
                                        logic.counterOrder.toString(),
                                        logic.color.text,
                                        logic.size.text,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
