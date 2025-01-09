import 'package:flutter/material.dart';
import 'package:flutter_application/bottom_appbar.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      bottomNavigationBar: MyBottomAppbar(),
      body: Container(
        color: Colors.pink,
      ),
    );
  }
}