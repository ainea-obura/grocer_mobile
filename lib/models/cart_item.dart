import 'package:grocerygo/models/products_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, {this.quantity = 1});
}


// class CartItem {
//   final Product product;
//   int quantity;
//
//   CartItem({required this.product, this.quantity = 1});
//
//   int get totalPrice => quantity * product.price;
//
//   void incrementQuantity() {
//     quantity++;
//   }
//
//   void decrementQuantity() {
//     if (quantity > 1) {
//       quantity--;
//     }
//   }
// }
