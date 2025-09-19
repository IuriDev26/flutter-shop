import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/model/orders_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final OrdersList orders = Provider.of<OrdersList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (ctx, index) {
            return OrderWidget(order: orders.orders[index]);
          }),
      ),
    );
  }
}