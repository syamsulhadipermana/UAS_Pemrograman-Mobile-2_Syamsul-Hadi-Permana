import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/guitar_model.dart';
import '../data/dummy_guitars.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());

  Future<void> loadProducts() async {
    try {
      emit(ProductLoading());

      // simulasi fetch API
      await Future.delayed(const Duration(milliseconds: 500));

      if (dummyGuitars.isEmpty) {
        emit(ProductError('Tidak ada produk tersedia'));
        return;
      }

      emit(ProductLoaded(dummyGuitars));
    } catch (e) {
      emit(ProductError('Gagal memuat produk: ${e.toString()}'));
    }
  }
}

/// STATES

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductLoading extends ProductState {
  const ProductLoading();

  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Guitar> products;

  const ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
