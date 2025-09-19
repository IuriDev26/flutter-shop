import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/model/product.dart';
import 'package:shop/model/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoritesOnly;
  const ProductGrid({super.key, required this.showFavoritesOnly});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> products = showFavoritesOnly ? provider.getFavorites : provider.getProducts;

    
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
      itemCount: products.length,
    );
  }
}
