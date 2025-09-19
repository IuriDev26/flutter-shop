import 'package:flutter/material.dart';
import 'package:shop/model/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: height * 0.4,
              child: Image.network(product.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.title, style: Theme.of(context).textTheme.headlineSmall,),
                  Text('R\$ ${product.price}', style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(product.description, style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
