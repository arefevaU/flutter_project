import 'package:flutter/material.dart';
import 'package:flutter_application/bottom_appbar.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      bottomNavigationBar: MyBottomAppbar(),
      body: Container(
        color: Colors.deepPurple,
      ),
    );
  }
}