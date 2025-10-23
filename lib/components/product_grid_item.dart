import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app_routes.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/product.dart';
import 'package:http/http.dart' as http;

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});
  final _baseUrl = 'https://shop-iuri-default-rtdb.firebaseio.com';

  _addItemToCart({
    required Cart cart,
    required Product product,
    required BuildContext context,
  }) {
    cart.add(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Produto Adicionado ao Carrinho',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () => cart.subtractById(product.id),
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(BuildContext context, Product product) async {
    product.toggleFavorite();
    var response = await http.patch(
      Uri.parse('$_baseUrl/products/${product.id}.json'),
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode >= 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao marcar produto como favorito')),
      );
      product.toggleFavorite();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    final Cart cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () => _toggleFavorite(context, product),
            color: Theme.of(context).colorScheme.secondary,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () =>
                _addItemToCart(cart: cart, product: product, context: context),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          backgroundColor: Colors.black87,
        ),
        child: GestureDetector(
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(AppRoutes.productDetail, arguments: product);
          },
        ),
      ),
    );
  }
}
