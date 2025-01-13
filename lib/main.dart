import 'package:flutter/material.dart';
import 'package:flutter_application/authorization.dart';
import 'package:flutter_application/bottom_appbar.dart';
import 'package:flutter_application/category_buttons.dart';
import 'package:flutter_application/prod_cards.dart';

int? id;
String? apiIP = '127.0.0.1:5000';
int selectedFilter = 1;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthorizationScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //final GlobalKey<CategoryButtonsState> _key = GlobalKey();
  //const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CategoryButtonsState> key = GlobalKey();
    final GlobalKey<ProdCardsState> key2 = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
        actions: [
          IconButton(
              onPressed: () {
                id = 0;
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthorizationScreen()));
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      bottomNavigationBar: MyBottomAppbar(),
      body: Container(
        color: Colors.tealAccent,
        child: Column(
          children: [
            CategoryButtons(key: key, function: refresh),
            ProductCards(key: key2, function: refresh, product: product),
          ],
        ),
      ),
    );
  }
}
