import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app_routes.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/orders_list.dart';
import 'package:shop/model/product_list.dart';

void main() => runApp(const Shop());

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrdersList()),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.deepOrange,
            primarySwatch: Colors.deepPurple,
          ),
          useMaterial3: false,
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
