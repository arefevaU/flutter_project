import 'package:flutter/material.dart';
import 'package:flutter_application/basket.dart';
import 'package:flutter_application/favourite.dart';
import 'package:flutter_application/main.dart';

class MyBottomAppbar extends StatefulWidget {
  const MyBottomAppbar({super.key});

  @override
  State<MyBottomAppbar> createState() => _MyBottomAppbarState();
}

class _MyBottomAppbarState extends State<MyBottomAppbar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child:  Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
            }, icon: Icon(Icons.home)),
            IconButton(onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => BasketScreen()));
            }, icon: Icon(Icons.local_grocery_store)),
            IconButton(onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()));
            }, icon: Icon(Icons.favorite)),
          ],
        ),
      ),
    );
  }
}