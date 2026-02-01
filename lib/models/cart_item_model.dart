import 'package:equatable/equatable.dart';
import 'guitar_model.dart';

class CartItem extends Equatable {
  final Guitar guitar;
  final int qty;

  CartItem({required this.guitar, required this.qty});

  CartItem copyWith({Guitar? guitar, int? qty}) {
    return CartItem(
      guitar: guitar ?? this.guitar,
      qty: qty ?? this.qty,
    );
  }

  @override
  List<Object?> get props => [guitar, qty];
}
