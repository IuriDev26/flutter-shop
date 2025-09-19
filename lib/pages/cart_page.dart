import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/orders_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Carrinho')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Cart>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) => Dismissible(
                key: Key(cart.items[index].id),
                direction: DismissDirection.endToStart,
                background: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                ),
                onDismissed: (_) => cart.remove(cart.items[index].productId),
                child: CartItemWidget(item: cart.items[index]),
              ),
            );
          },
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Total', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (cart.itemCount == 0) return;

                  Provider.of<OrdersList>(
                    context,
                    listen: false,
                  ).addOrder(cart);

                  cart.clear();
                },
                child: Text('Comprar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
