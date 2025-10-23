import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app_routes.dart';
import 'package:shop/exceptions/http_exceptions.dart';
import 'package:shop/model/product.dart';
import 'package:shop/model/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  _removeProduct(BuildContext context, String productId) {
    var products = Provider.of<ProductList>(context, listen: false);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Atenção'),
        content: Text('Deseja realmente excluir o produto?'),
        actions: [
          TextButton(
            onPressed: () async {

              try {
                await products.removeProduct(productId);
              } on HttpExceptions catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message)));
              }
              finally{
                Navigator.of(context).pop();
              }

              
            },
            child: Text('Sim'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Não'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          title: Text(product.title),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.productForm, arguments: product),
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: () => _removeProduct(context, product.id),
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
