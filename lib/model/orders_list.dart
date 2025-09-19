import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/order.dart';

class OrdersList with ChangeNotifier{
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  int get itemsCount => _orders.length;

  addOrder(Cart cart){
    Order order = new Order(id: Random().nextDouble().toString(), amount: cart.totalAmount, items: cart.items, dateTime: DateTime.now());

    _orders.insert(0, order);
    
    notifyListeners();

  }

}