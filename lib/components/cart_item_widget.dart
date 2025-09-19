import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/cart_item.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  const CartItemWidget({super.key, required this.item});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  _add(Cart cart) {
    setState(() => cart.addById(widget.item.productId));
  }

  _subtract(Cart cart) {
    setState(() => cart.subtractById(widget.item.productId));
  }

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 60,
            child: Image.network(widget.item.imageUrl, fit: BoxFit.cover)),
        ),
        title: Text(widget.item.title),
        subtitle: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vlr. Unitário: R\$${widget.item.unitPrice.toStringAsFixed(2)}'),
              Text('Total: R\$${widget.item.totalPrice.toStringAsFixed(2)}'),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _subtract(cart),
              icon: Icon(Icons.remove),
            ),
            Text(widget.item.quantity.toString()),
            IconButton(
              onPressed: () => _add(cart),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
