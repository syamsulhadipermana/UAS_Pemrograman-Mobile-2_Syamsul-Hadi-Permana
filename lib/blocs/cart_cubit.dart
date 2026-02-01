import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item_model.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addToCart(CartItem item) {
    final currentCart = List<CartItem>.from(state);
    
    // Cek apakah item sudah ada di cart
    final existingIndex = currentCart.indexWhere(
      (cartItem) => cartItem.guitar.id == item.guitar.id,
    );

    if (existingIndex >= 0) {
      // Jika sudah ada, tambah quantity menggunakan copyWith
      currentCart[existingIndex] = currentCart[existingIndex].copyWith(
        qty: currentCart[existingIndex].qty + item.qty,
      );
    } else {
      // Jika belum ada, tambah item baru
      currentCart.add(item);
    }
    
    emit(currentCart);
  }

  void updateQuantity(int guitarId, int newQuantity) {
    final currentCart = List<CartItem>.from(state);
    final index = currentCart.indexWhere(
      (item) => item.guitar.id == guitarId,
    );

    if (index >= 0) {
      if (newQuantity <= 0) {
        currentCart.removeAt(index);
      } else {
        currentCart[index] = currentCart[index].copyWith(qty: newQuantity);
      }
      emit(currentCart);
    }
  }

  void removeFromCart(int guitarId) {
    final newList = state.where(
      (item) => item.guitar.id != guitarId,
    ).toList();
    emit(newList);
  }

  void clearCart() {
    emit([]);
  }

  int getTotalPrice() {
    return state.fold(
      0,
      (total, item) => total + (item.guitar.discountedPrice * item.qty),
    );
  }

  int getTotalItems() {
    return state.fold(0, (total, item) => total + item.qty);
  }
}
