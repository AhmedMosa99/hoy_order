// ignore_for_file: implementation_imports

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:social_increase/modules/notification/controller/controller.dart';
import 'package:social_increase/modules/notification/views/screens/payment.dart';
import 'package:social_increase/modules/notification/views/widgets/no_notification.dart';
import 'package:social_increase/utils/constant.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var controller = Get.put(NotificationController());
  @override
  void initState() {
    // TODO: implement initState

    if (userInfo != null) {
      controller.getNoification();
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 18.sp),
        ),
      ),
      body: DoubleBack(
          message: "Press back again to close",
          child: GetBuilder<NotificationController>(builder: (logic) {
            return logic.allNotifications.isEmpty
                ? NoNotification()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (c, i) => InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                      title: "OrderDetails",
                                      titleStyle: TextStyle(fontSize: 18.sp),
                                      cancel: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                          ),
                                          onPressed: () {
                                            logic.cancelOrder(
                                                logic.allNotifications[i].id);
                                            Get.back();
                                          },
                                          child: Text("cancel")),
                                      confirm: ElevatedButton(
                                          onPressed: () async {
                                            logic.id =
                                                logic.allNotifications[i].id;
                                            await logic.getDetails();
                                            Get.back();
                                            await Get.to(Payment());
                                          },
                                          child: Text("Pay")),
                                      content: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text('Quantity:',
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(logic.allNotifications[i].qty
                                                  .toString()),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          logic.allNotifications[i].color != ""
                                              ? Row(
                                                  children: [
                                                    Text('Color:',
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(logic
                                                        .allNotifications[i]
                                                        .color),
                                                  ],
                                                )
                                              : Container(),
                                          logic.allNotifications[i].color != ""
                                              ? SizedBox(
                                                  height: 15.h,
                                                )
                                              : Container(),
                                          logic.allNotifications[i].size != ""
                                              ? Row(
                                                  children: [
                                                    Text('Size:',
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(logic
                                                        .allNotifications[i]
                                                        .size),
                                                  ],
                                                )
                                              : Container(),
                                          logic.allNotifications[i].size != ""
                                              ? SizedBox(
                                                  height: 15.h,
                                                )
                                              : Container(),
                                          Row(
                                            children: [
                                              Text(
                                                'Price:',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(logic
                                                  .allNotifications[i].price),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Application tax:',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(logic
                                                  .allNotifications[i].tax),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Text('Shipping expenses:',
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(logic.allNotifications[i]
                                                  .shipping),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Text('Total:',
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(logic
                                                  .allNotifications[i].total),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          logic.allNotifications[i].notes != ""
                                              ? Row(
                                                  children: [
                                                    Text('Notes:',
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Expanded(
                                                        child: Text(logic
                                                            .allNotifications[i]
                                                            .notes)),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ));
                                },
                                child: buildContainerNotification(
                                    context: context,
                                    time: logic.allNotifications[i].since,
                                    title:
                                        logic.allNotifications[i].status.name,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.17))),
                            itemCount: logic.allNotifications.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 16.h,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
          })),
    );
  }

  Container buildContainerNotification(
      {required BuildContext context,
      Color? color,
      required String title,
      required String time}) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              children: const [
                Icon(
                  Icons.notifications_active,
                  size: 24,
                  color: Color(0xff009196),
                )
              ],
            ),
            const SizedBox(
              width: 12,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
            ),
            //  IconButton(onPressed: (){}, icon: Icon(Icons.share)),
          ],
        ),
      ),
    );
  }
}
