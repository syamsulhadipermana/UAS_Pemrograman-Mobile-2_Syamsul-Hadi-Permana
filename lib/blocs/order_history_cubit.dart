import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart';

class OrderHistoryCubit extends Cubit<List<Order>> {
  OrderHistoryCubit() : super([]);

  void addOrder(Order order) {
    final currentOrders = state;
    emit([order, ...currentOrders]);
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final updatedOrders = state.map((order) {
      if (order.id == orderId) {
        return Order(
          id: order.id,
          items: order.items,
          totalPrice: order.totalPrice,
          orderDate: order.orderDate,
          status: newStatus,
        );
      }
      return order;
    }).toList();
    emit(updatedOrders);
  }

  void clearOrderHistory() {
    emit([]);
  }
}
