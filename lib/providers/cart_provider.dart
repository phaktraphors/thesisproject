import 'package:kate_botique_app/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:kate_botique_app/services/cate_service.dart';

class CartProvider extends ChangeNotifier {

  CartService _cartService;
  int _itemQuantity = 0;

  int get getCartQuantity => _itemQuantity;

  set setCartQuantity(int quantity){
    _itemQuantity = quantity;
    notifyListeners();
  }

  addToCart(Product product) async {
    _cartService = CartService();
    var result = await _cartService.addToCart(product);
    notifyListeners();
    return result;
  }

  cartItems() async {
    _cartService = CartService();
    var _cartItems = await _cartService.getCartItems();
    setCartQuantity = _cartItems.length;
    notifyListeners();
    return _cartItems;
  }
}