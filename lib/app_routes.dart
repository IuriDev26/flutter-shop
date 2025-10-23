import 'package:flutter/widgets.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/product_overview_page.dart';
import 'package:shop/pages/products_page.dart';

class AppRoutes {
  static const productDetail = "/product-detail";
  static const cart = "/cart";
  static const home = "/home";
  static const orders = "/orders";
  static const products = "/products";
  static const productForm = "/product-form";
  static const auth = "/";

  static Map<String, WidgetBuilder> getRoutes() => {
    productDetail: (ctx) => ProductDetailPage(),
    cart: (ctx) => CartPage(),
    orders: (ctx) => OrdersPage(),
    home: (ctx) => ProductOverviewPage(),
    products: (ctx) => ProductsPage(),
    productForm: (ctx) => ProductFormPage(),
    auth: (ctx) => AuthPage()
  };

}