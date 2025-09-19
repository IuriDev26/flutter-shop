import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/model/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProducts;
  bool favoritesOnly = false;

  List<Product> get getProducts => [..._products];
  List<Product> get getFavorites => _products.where( (product) => product.isFavorite ).toList();

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

}
