import 'package:shop/model/cart_item.dart';

class Order {
  String id;
  final double amount;
  final List<CartItem> items;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.items,
    required this.dateTime,
    });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "items": items.map( (item) => item.toJson() ).toList(),
    "dateTime": dateTime.toIso8601String()
  };

}