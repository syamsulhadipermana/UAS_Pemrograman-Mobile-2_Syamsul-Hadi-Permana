import 'package:equatable/equatable.dart';
import 'guitar_model.dart';

class OrderItem extends Equatable {
  final Guitar guitar;
  final int qty;

  const OrderItem({
    required this.guitar,
    required this.qty,
  });

  @override
  List<Object?> get props => [guitar, qty];
}

class Order extends Equatable {
  final String id;
  final List<OrderItem> items;
  final int totalPrice;
  final DateTime orderDate;
  final String status; // "Pending", "Processing", "Shipped", "Delivered"

  const Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
  });

  int get totalItems => items.fold(0, (sum, item) => sum + item.qty);

  @override
  List<Object?> get props => [id, items, totalPrice, orderDate, status];
}
