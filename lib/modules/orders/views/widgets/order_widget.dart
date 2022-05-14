import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_increase/modules/orders/controller/controller.dart';

class OrderWidget extends StatefulWidget {
  OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (logic) {

      return ListView.builder(
        itemCount: logic.allorders.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffC6C6C6), width: .5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width:100.w,
                        height: 30.h,
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            logic.allorders[index].status.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white,fontSize: 16.sp),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Quantity :',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                                logic.allorders[index].qty
                            ),
                          ],
                        ),
                      ),
                      logic.allorders[index].size!=""?  SizedBox(
                        height: 8.h,
                      ):Container(),
                    logic.allorders[index].size!=""?  Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Size :',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              logic.allorders[index].size,
                            ),
                          ],
                        ),
                      ):Container(),
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Date :',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              logic.allorders[index].since,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Price :',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              logic.allorders[index].price,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Tax :',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          Text("50"),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Expenses :',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          Text( logic.allorders[index].shipping),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total :',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                        Text(logic.allorders[index].total),

                        ],

                      ),
                      logic.allorders[index].notes!=""?SizedBox(height: 8.h,):Container(),
                      logic.allorders[index].notes!=""?Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Notes :',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              logic.allorders[index].notes,
                            ),
                          ],
                        ),
                      ):Container(),
                      SizedBox(
                        height: 8.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
