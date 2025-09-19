import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app_routes.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/product.dart';

class ProductItem extends StatelessWidget {

  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    final Cart cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon( product.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => product.toggleFavorite(),
            color: Theme.of(context).colorScheme.secondary,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => cart.add(product),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          backgroundColor: Colors.black87,
        ),
        child: GestureDetector(
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.productDetail, arguments: product);
          },
        ),
      ),
    );
  }
}
