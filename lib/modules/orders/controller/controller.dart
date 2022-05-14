import 'package:get/get.dart';
import 'package:social_increase/modules/orders/models/order_model.dart';
import 'package:social_increase/services/data_fetch.dart';
import 'package:social_increase/utils/constant.dart';

class OrderController extends GetxController {
  List<Order> allorders = [];
  @override
  void onInit() {
    if (userInfo != null) {
      getOrder();
    }

    super.onInit();
  }

  getOrder() async {
    List<dynamic> orders = await DioHandler.apiHelper.getOrder();
    allorders = orders.map((e) => Order.fromJson(e)).toList();
    update();
  }
}
