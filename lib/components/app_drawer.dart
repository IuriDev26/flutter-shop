import 'package:flutter/material.dart';
import 'package:shop/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Icon(Icons.shopping_bag_rounded),
                SizedBox(width: 10,),
                Text('Loja')
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home Page'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Meus Pedidos'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.orders ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.products ),
          )
        ],
      ),
    );
  }
}