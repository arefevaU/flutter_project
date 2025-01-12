import 'package:flutter/material.dart';
import 'package:flutter_application/authorization.dart';
import 'package:flutter_application/bottom_appbar.dart';
import 'package:flutter_application/category_buttons.dart';
import 'package:flutter_application/prod_cards.dart';

import 'authorization.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

ListFavourites() {
  List userFavourites = [];
  if (favourite.isNotEmpty) {
    for (int i = 0; i < products.length; i++) {
      for (int j = 0; j < favourite.length; j++) {
        if (products[i].prodId == favourite[j].prodId) {
          userFavourites.add(products[i]);
        }
      }
    }
    return userFavourites;
  } else {
    return userFavourites;
  }
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ProdCardsState> key = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      bottomNavigationBar: MyBottomAppbar(),
      body: Expanded(
        //color: Colors.pink,
        child: ProductCards(
            key: key,
            function: () {
              setState(() {});
            },
            product: ListFavourites()),
      ),
    );
  }
}
