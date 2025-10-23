import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop/exceptions/http_exceptions.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/cart_item.dart';
import 'package:shop/model/order.dart';
import 'package:http/http.dart' as http;

class OrdersList with ChangeNotifier {
  final List<Order> _orders = [];
  final _baseUrl = 'https://shop-iuri-default-rtdb.firebaseio.com';

  List<Order> get orders => [..._orders];

  int get itemsCount => _orders.length;

  Future<void> addOrder(Cart cart) async {
    Order order = Order(
      id: "",
      amount: cart.totalAmount,
      items: cart.items,
      dateTime: DateTime.now(),
    );

    var response = await http.post(
      Uri.parse('$_baseUrl/orders.json'),
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode >= 400) {
      throw HttpExceptions(
        message: 'Falha ao processar venda',
        statusCode: 500,
      );
    }

    final id = jsonDecode(response.body)['name'];

    order.id = id;
    _orders.insert(0, order);

    notifyListeners();
  }

  Future<void> loadOrders() async {
    var response = await http.get(Uri.parse('$_baseUrl/orders.json'));

    if (response.statusCode >= 400) {
      throw HttpExceptions(message: 'Falha ao buscar pedidos', statusCode: 500);
    }

    _orders.clear();
    Map<String, dynamic> orders = jsonDecode(response.body);

    orders.forEach((orderId, orderData) {
      List<CartItem> items = [];

      (orderData['items'] as List<dynamic>).forEach((item) {
        var cartItem = CartItem(
          id: item['id'],
          productId: item['productId'],
          unitPrice: item['unitPrice'],
          quantity: item['quantity'],
          title: item['title'],
          imageUrl: item['imageUrl'],
        );
        items.add(cartItem);
      });

      var order = Order(
        id: orderId,
        amount: orderData['amount'],
        items: items,
        dateTime: DateTime.parse(orderData['dateTime']),
      );

      _orders.add(order);
    });

    notifyListeners();
  }
}
