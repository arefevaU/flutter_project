import 'package:flutter/material.dart';
import 'package:flutter_application/bottom_appbar.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  SendToDB(userId, prodId) async {
    var url = Uri.http(apiIP!, 'addBasket',
        {'user_id': userId.toString(), 'prod_id': prodId.toString()});
    final response = await http.get(url);
  }

  final List<Map<String, dynamic>> product = [
    {
      'prodName': 'Бургер с говядиной',
      'price': 250,
      'photoPath': 'https://i.pinimg.com/originals/73/55/14/735514152cbde3ecb42933a64ba54ad7.png',
    },
    {
      'prodName': 'Пицца Маргарита',
      'price': 450,
      'photoPath': 'https://i.pinimg.com/originals/73/55/14/735514152cbde3ecb42933a64ba54ad7.png',
    },
    {
      'prodName': 'Суши ролл Филадельфия',
      'price': 300,
      'photoPath': 'https://i.pinimg.com/originals/73/55/14/735514152cbde3ecb42933a64ba54ad7.png',
    },
    {
      'prodName': 'Куриные наггетсы',
      'price': 150,
      'photoPath': 'https://i.pinimg.com/originals/73/55/14/735514152cbde3ecb42933a64ba54ad7.png',
    },
    {
      'prodName': 'Шаурма с курицей',
      'price': 200,
      'photoPath': 'https://i.pinimg.com/originals/73/55/14/735514152cbde3ecb42933a64ba54ad7.png',
    },
  ];

  // Локальное состояние для хранения количества
  final Map<int, int> quantities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      bottomNavigationBar: MyBottomAppbar(),
      body: Container(
        color: Colors.deepPurple,
        child: ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, index) {
            final item = product[index];
            final quantity = quantities[index] ?? 1;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Чекбокс
                      Checkbox(
                        value: false, 
                        onChanged: (value) {
                          //
                        },
                      ),
                      
                      // Картинка товара
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          item['photoPath'],
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      // Отступ между изображением и названием
                      SizedBox(width: 8.0),
                      
                      // Название товара
                      Expanded(
                        child: Text(
                           item['prodName'],
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis, // Ограничиваем длину названия
                        ),
                      ),
                      
                      // // Количество
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Text(
                      //     '1',
                      //     style: TextStyle(
                      //       fontSize: 16.0,
                      //     ),
                      //   ),
                      // ),

                       Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantities[index] = quantity - 1;
                                } else {
                                  product.removeAt(index);
                                  quantities.remove(index);
                                }
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantities[index] = quantity + 1;
                              });
                            },
                          ),
                        ],
                      ),
                      
                      // Цена товара
                      Text(
                        '${item['price'] * quantity} руб.',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}