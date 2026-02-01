import 'package:equatable/equatable.dart';

class Guitar extends Equatable {
  final int id;
  final String name;
  final String brand;
  final String image;
  final int price; // in Rupiah
  final String description;
  final int stock;
  final int discount; // in percentage (0-100)

  const Guitar({
    required this.id,
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    required this.description,
    this.stock = 10,
    this.discount = 0,
  });

  int get discountedPrice {
    return (price * (100 - discount) / 100).toInt();
  }

  bool get isInStock => stock > 0;

  // Format price to Rupiah string
  String get formattedPrice {
    return 'Rp${price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  String get formattedDiscountedPrice {
    return 'Rp${discountedPrice.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  @override
  List<Object?> get props => [id, name, brand, image, price, description, stock, discount];
}
