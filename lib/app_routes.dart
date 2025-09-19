import 'package:flutter/widgets.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_overview_page.dart';

class AppRoutes {
  static const productDetail = "/product-detail";
  static const cart = "/cart";
  static const home = "/";
  static const orders = "/orders";


  static Map<String, WidgetBuilder> getRoutes() => {
    productDetail: (ctx) => ProductDetailPage(),
    cart: (ctx) => CartPage(),
    orders: (ctx) => OrdersPage(),
    home: (ctx) => ProductOverviewPage()
  };

}