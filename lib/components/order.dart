import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/model/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              ('R\$ ${widget.order.amount.toStringAsFixed(2)}'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh:mm").format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () => setState( () => _expanded = !_expanded ),
            ),
          ),
          if (_expanded)
            SizedBox(
              height: (widget.order.items.length * 105) + 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: widget.order.items.length,
                  itemBuilder: (ctx, index) {
                    return OrderItemWidget(product: widget.order.items[index]);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
