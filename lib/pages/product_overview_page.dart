import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app_routes.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/model/cart.dart';

enum Options { favoritesOnly, all }

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({super.key});

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: Options.favoritesOnly,
                child: Text('Somente Favoritos'),
              ),
              PopupMenuItem(value: Options.all, child: Text('Todos')),
            ],
            onSelected: (Options option) {
              setState(() {
                showFavoritesOnly = option == Options.favoritesOnly;
              });
            },
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cart),
            icon: Consumer<Cart>(
              builder: (context, cart, child) => Badge(
                label: Text(cart.itemCount.toString()),
                isLabelVisible: cart.itemCount > 0,
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(showFavoritesOnly: showFavoritesOnly),
    );
  }
}
