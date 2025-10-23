import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exceptions.dart';
import 'package:shop/model/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = [];
  final _baseUrl = "shop-iuri-default-rtdb.firebaseio.com";
  bool favoritesOnly = false;

  int get itemsCount => _products.length;

  List<Product> get getProducts => [..._products];
  List<Product> get getFavorites =>
      _products.where((product) => product.isFavorite).toList();

  Future<void> loadProducts() async {
    _products.clear();
    var response = await http.get(Uri.https(_baseUrl, '/products.json'));
    Map<String, dynamic> decoded = jsonDecode(response.body);

    decoded.forEach((productId, productData) {
      var product = Product(
        id: productId,
        title: productData['title'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite']
      );
      _products.add(product);
    });
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    var response = await http.post(
      Uri.https(_baseUrl, "/products.json"),
      body: jsonEncode(product.toJson()),
    );

    final id = jsonDecode(response.body)['name'];
    product.id = id;
    _products.add(product);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int oldProductIndex = _products.indexWhere(
      (oldProduct) => oldProduct.id == product.id,
    );

    if (oldProductIndex < 0) return;

    var oldProduct = _products[oldProductIndex];
    oldProduct.title = product.title;
    oldProduct.description = product.description;
    oldProduct.price = product.price;
    oldProduct.imageUrl = product.imageUrl;

    await http.patch(
      Uri.https(_baseUrl, "/products/${oldProduct.id}.json"),
      body: jsonEncode(oldProduct.toJson()),
    );

    _products[oldProductIndex] = oldProduct;
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    int productIndex = _products.indexWhere((oldProduct) => oldProduct.id == id);
    if (productIndex < 0) return;

    var product = _products[productIndex];
    _products.remove(product);
  
    var response = await http.delete(Uri.https(_baseUrl, "/products/$id.json"));

    if (response.statusCode >= 400){
      _products.insert(productIndex, product);
      notifyListeners();
      throw HttpExceptions(message: "Falha ao excluir produto", statusCode: 500);
    }

    notifyListeners();

  }
}
