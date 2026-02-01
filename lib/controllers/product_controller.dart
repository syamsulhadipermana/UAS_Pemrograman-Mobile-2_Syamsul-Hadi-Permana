import '../models/guitar_model.dart';
import '../data/dummy_guitars.dart';

class ProductController {
  static final List<Guitar> products = dummyGuitars;

  static void add(Guitar guitar) {
    products.add(guitar);
  }

  static void delete(Guitar guitar) {
    products.remove(guitar);
  }

  static void update(int index, Guitar newGuitar) {
    products[index] = newGuitar;
  }
}
