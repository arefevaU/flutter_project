import 'package:flutter/material.dart';
import 'package:flutter_application/authorization.dart';
import 'package:flutter_application/bottom_appbar.dart';
import 'package:flutter_application/category_buttons.dart';

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
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  
  final List<Map<String, String>> _products = [
    {
      'name': 'Бургер',
      'price': '200',
      'image': 'https://png.pngtree.com/png-vector/20240710/ourmid/pngtree-burger-with-floating-ingredient-png-image_13054386.png',
    },
    {
      'name': 'Пицца',
      'price': '200',
      'image': 'https://png.pngtree.com/png-vector/20240710/ourmid/pngtree-burger-with-floating-ingredient-png-image_13054386.png',
    },
    {
      'name': 'Суши',
      'price': '200',
      'image': 'https://png.pngtree.com/png-vector/20240710/ourmid/pngtree-burger-with-floating-ingredient-png-image_13054386.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mdskflksf'),
        actions: [
          IconButton(
            onPressed: () {
              id = 0;
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationScreen()));
            }, 
            icon: Icon(Icons.exit_to_app)
          ),
        ],
      ),
      bottomNavigationBar: MyBottomAppbar(),
      body: Container(
        color: Colors.tealAccent,
        child: Column(
          children: [
            CategoryButtons(),
            Expanded(
              child: ListView.builder(
                //padding: EdgeInsets.all(8.0),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                product['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product['name']!,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  product['price']!,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.green,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {
                                        // Логика добавления в избранное
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.shopping_cart),
                                      onPressed: () {
                                        // Логика добавления в корзину
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
