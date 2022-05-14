import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:social_increase/modules/main/controller/main_controller.dart';
import 'package:social_increase/modules/notification/controller/controller.dart';
import 'package:social_increase/modules/notification/views/screens/payment.dart';
import 'package:social_increase/services/data_fetch.dart';
import 'package:social_increase/utils/constant.dart';

class HomeController extends GetxController {
  late String page;
  TextEditingController color = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController note = TextEditingController();
  String price = '';

  int counterOrder = 1;

  getPrice() async {
    dynamic data = await DioHandler.apiHelper.getPrice();
    price = data;
    print(price);
    update();
  }

  conectPusher() {
    if (userInfo == null) {
    } else {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('app_icon');
      final InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      PusherClient pusher = PusherClient(
        'bb9f68af55b58c7c23c0',
        PusherOptions(encrypted: false),
      );
      PusherOptions options = PusherOptions(
        encrypted: false,
        cluster: 'eu',
      );
      pusher.connect();
      pusher.onConnectionStateChange((state) async {
        print(
            "previousState: ${state!.previousState}, currentState: ${state.currentState}");
      });
      pusher.onConnectionError((error) {
        print("error: ${error!.message}");
      });
      Channel channel = pusher.subscribe("user_order${userInfo!.id}");
      channel.bind('SendOrder', (PusherEvent? e) async {
        //  print(jsonEncode(e!.data));
        dynamic data = jsonDecode(e!.data.toString());

        Get.defaultDialog(
            title: "Order Details",
            titleStyle: TextStyle(fontSize: 18.sp),
            cancel: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () async {
                  var controllerHome = Get.put(NotificationController());
                  controllerHome.cancelOrder(data['id']);
                  Get.back();
                },
                child: Text("cancel")),
            confirm: ElevatedButton(
                onPressed: () async {
                  var controllerHome = Get.put(NotificationController());
                  controllerHome.id = data['id'];
                  await controllerHome.getDetails();
                  Get.back();
                  await Get.to(() => Payment());
                },
                child: Text("Pay")),
            content: Column(
              children: [
                Row(
                  children: [
                    Text('Quantity:',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(data['qty']),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                data['color'] != ""
                    ? Row(
                        children: [
                          Text('Color:',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(data['color']),
                        ],
                      )
                    : Container(),
                data['color'] != ""
                    ? SizedBox(
                        height: 15.h,
                      )
                    : Container(),
                data['size'] != ""
                    ? Row(
                        children: [
                          Text('Size:',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(data['size']),
                        ],
                      )
                    : Container(),
                data['size'] != ""
                    ? SizedBox(
                        height: 15.h,
                      )
                    : Container(),
                Row(
                  children: [
                    Text(
                      'Price:',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(data['price']),
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
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(data['tax']),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text('Shipping expenses:',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(data['shipping']),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text('Time Offer:',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(data['time_offer']),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text('Total:',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(data['total']),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                data['notes'] != ""
                    ? Row(
                        children: [
                          Text('Notes:',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(child: Text(data['notes'])),
                        ],
                      )
                    : Container(),
              ],
            ));
        // flutterLocalNotificationsPlugin.initialize(
        //   initializationSettings,
        //   onSelectNotification: (payload) async {},
        // );
        flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onSelectNotification: (payload) async {
            Get.defaultDialog(
                title: "Order Details",
                titleStyle: TextStyle(fontSize: 18.sp),
                cancel: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () async {
                      var controllerHome = Get.put(NotificationController());
                      controllerHome.cancelOrder(data['id']);
                      Get.back();
                    },
                    child: Text("cancel")),
                confirm: ElevatedButton(
                    onPressed: () async {
                      var controllerHome = Get.put(NotificationController());
                      controllerHome.id = data['id'];
                      await controllerHome.getDetails();
                      Get.back();
                      await Get.to(() => Payment());
                    },
                    child: Text("Pay")),
                content: Column(
                  children: [
                    Row(
                      children: [
                        Text('Quantity:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(data['qty']),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    data['color'] != ""
                        ? Row(
                            children: [
                              Text('Color:',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(data['color']),
                            ],
                          )
                        : Container(),
                    data['color'] != ""
                        ? SizedBox(
                            height: 15.h,
                          )
                        : Container(),
                    data['size'] != ""
                        ? Row(
                            children: [
                              Text('Size:',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(data['size']),
                            ],
                          )
                        : Container(),
                    data['size'] != ""
                        ? SizedBox(
                            height: 15.h,
                          )
                        : Container(),
                    Row(
                      children: [
                        Text(
                          'Price:',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(data['price']),
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
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(data['tax']),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text('Shipping expenses:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(data['shipping']),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text('Time Offer:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(data['time_offer']),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text('Total:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(data['total']),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    data['notes'] != ""
                        ? Row(
                            children: [
                              Text('Notes:',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(child: Text(data['notes'])),
                            ],
                          )
                        : Container(),
                  ],
                ));
          },
        );
        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            'your other channel id', 'your other channel name',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            enableLights: true,
            enableVibration: true,
            color: Color.fromARGB(255, 255, 0, 0),
            ledColor: Color.fromARGB(255, 255, 0, 0),
            ledOnMs: 1000,
            ledOffMs: 500);

        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics, iOS: null);
        await flutterLocalNotificationsPlugin.show(
          1,
          'HoyOrder',
          'You are due to pay to complete the application',
          platformChannelSpecifics,
          payload: 'This is notification detail Text...',
        );

        // pusher.disconnect();
      });
    }
  }

  postOrder(String page, String counterOrder, String color, String size) async {
    dynamic a = await DioHandler.apiHelper
        .makeOrder(page, counterOrder.toString(), color, size);
    if (a == true) {
      Get.back();
      Get.defaultDialog(
          title: 'Thank you',
          content: const Text("Your request is being processed"),
          cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Ok')));
      this.color.text = "";
      this.counterOrder = 1;
      this.size.text = "";
      this.link.text = '';
      Future.delayed(const Duration(seconds: 3), () {
        Get.back();
      });
    } else {
      Get.defaultDialog(
          title: 'Sorry',
          content: const Text("Try again"),
          cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Ok')));
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    }
    update();
  }

  addPackageCounter() {
    ++counterOrder;
    update();
  }

  minusPackageCounter() {
    --counterOrder;
    update();
  }

  @override
  void onInit() {
    getPrice();
    conectPusher();
    super.onInit();
  }
}
