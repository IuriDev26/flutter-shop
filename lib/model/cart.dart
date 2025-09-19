import 'package:flutter/material.dart';
import 'package:shop/model/cart_item.dart';
import 'package:shop/model/product.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  int get itemCount => _items.length;

  double get totalAmount {
    if (_items.isEmpty) return 0;

    return _items
        .map((cartItem) => cartItem.totalPrice)
        .reduce((value, element) => value + element);
  }

  remove(String productId) {
    _items.removeWhere((cartItem) => cartItem.productId == productId);
    notifyListeners();
  }

  CartItem? getById(String productId) {

    int index = _items.indexWhere( (cartItem) => cartItem.productId == productId);

    if (index < 0) return null;

    return _items.elementAt(index);
  }

  add(Product product) {
    int index = _items.indexWhere(
      (cartItem) => cartItem.productId == product.id,
    );
    bool isProductIncluded = index >= 0;

    if (!isProductIncluded) {
      _items.add(
        CartItem(
          id: (_items.length + 1).toString(),
          productId: product.id,
          unitPrice: product.price,
          quantity: 1,
          title: product.title,
          imageUrl: product.imageUrl,
        ),
      );
      notifyListeners();
      return;
    }

    var cartItem = _items[index];
    cartItem.add();

    notifyListeners();
  }

  addById(String productId){
    
    var cartItem = getById(productId);

    if (cartItem == null) return;

    cartItem.add();
    notifyListeners();

  }

  subtractById(String productId){
    var cartItem = getById(productId);

    if (cartItem == null) return;

    cartItem.subtract();

    if (cartItem.quantity == 0) remove(productId);

    notifyListeners();
  }

  clear(){
    _items = [];
    notifyListeners();
  }

}
