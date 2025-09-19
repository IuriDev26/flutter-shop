import 'package:flutter/material.dart';
import 'package:shop/model/cart_item.dart';

class OrderItemWidget extends StatelessWidget {
  final CartItem product;

  const OrderItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 60,
            child: Image.network(product.imageUrl, fit: BoxFit.cover)),
        ),
        title: Text(product.title),
        subtitle: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quantidade'),
                  Text('Valor Unitário'),
                  Text('Total'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${product.quantity} UN'),
                  Text('R\$ ${product.unitPrice.toStringAsFixed(2)}'),
                  Text('R\$${product.totalPrice.toStringAsFixed(2)}'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}