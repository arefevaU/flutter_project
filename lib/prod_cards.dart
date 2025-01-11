import 'package:flutter/material.dart';
import 'category_buttons.dart';

class ProductCards extends StatefulWidget {
  const ProductCards({super.key});

  @override
  State<ProductCards> createState() => _ProdCardsState();
}

class _ProdCardsState extends State<ProductCards> {
  Widget Loading(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      //padding: EdgeInsets.all(8.0),
      itemCount: product.length,
      itemBuilder: (context, index) {
        //final prod = product[index];
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
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                          top: MediaQuery.sizeOf(context)
                                              .height) *
                                      0.05,
                                  child: Loading(context)),
                              Image.network(product[index].photoPath!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150, frameBuilder: (context, child,
                                      frame, wasSynchronouslyLoaded) {
                                return child;
                              }, loadingBuilder:
                                      (context, child, loadingProgress) {
                                print(loadingProgress);
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                // Future.delayed(Duration(seconds: 1), () {
                                //   return;
                                // });
                                // return Center(child: CircularProgressIndicator());
                              }),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            //color: const Color.fromARGB(255, 158, 52, 52),
                            onPressed: () {
                              // Логика добавления в избранное
                            },
                          ),
                        ],
                      )),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product[index].prodName!,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${product[index].price!.toString()} руб.',
                        style: TextStyle(
                          fontSize: 16.0,
                          //color: Colors.green,
                        ),
                      ),
                      Row(
                        children: [
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
    ));
  }
}
