import 'package:flutter/material.dart';
import 'package:mobile/add_product.dart';
import 'admin_login.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Shop',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/admin_login': (context) => AdminLoginPage(),
        '/add_new_product': (context) => AddNewProductPage(),
      },
    );
  }
}

class Product {
  final String title;
  final String category;
  final double price;
  final String image;

  Product({
    required this.title,
    required this.category,
    required this.price,
    required this.image,
  });
}
