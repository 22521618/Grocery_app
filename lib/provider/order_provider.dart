import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/models/order.dart';

class OrderProvider extends StateNotifier<List<Order>> {
  OrderProvider() : super([]);

  void setOrders(List<Order> oders) {
    state = oders;
  }
}

final orderProvider = StateNotifierProvider<OrderProvider, List<Order>>((ref) {
  return OrderProvider();
});
