import 'package:flutter/material.dart';
import 'package:flutter_application/api_request.dart';
import 'authorization.dart';
// import 'category_buttons.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class ProductCards extends StatefulWidget {
  //const ProductCards({super.key});

  final VoidCallback function;
  List product;
  ProductCards({Key? key, required this.function, required this.product})
      : super(key: key);

  @override
  State<ProductCards> createState() => ProdCardsState();
}

class ProdCardsState extends State<ProductCards> {
  Widget Loading(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  SendToDB(userId, prodId) async {
    var url = Uri.http(apiIP!, 'addFavourite',
        {'user_id': userId.toString(), 'prod_id': prodId.toString()});
    final response = await http.get(url);
  }

  DeleteFav(userId, prodId) async {
    var url = Uri.http(apiIP!, 'deleteFavourite',
        {'user_id': userId.toString(), 'prod_id': prodId.toString()});
    final response = await http.get(url);
  }

  isFavourite(prodId) {
    bool isFavourite = false;
    if (favourite.isNotEmpty) {
      for (int i = 0; i < favourite.length; i++) {
        if (favourite[i].prodId == prodId) {
          isFavourite = true;
          return isFavourite;
        }
      }
      return isFavourite;
    } else {
      return isFavourite;
    }
  }

  Refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      //padding: EdgeInsets.all(8.0),
      itemCount: widget.product.length,
      itemBuilder: (context, index) {
        //final prod = product[index];
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: GestureDetector(
              onTap: () {
                print('tapka');
                BuildContext dialog = context;
                var prodCard = showDialog(
                  context: dialog,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.product[index].photoPath!,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(widget.product[index].prodName!),
                                    Text(widget.product[index].description!),
                                    Text(
                                        '${widget.product[index].gram!.toString()} г.'),
                                    Text(
                                        '$widget.{product[index].price!.toString()} руб.')
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
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
                                  Image.network(
                                      widget.product[index].photoPath!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 150, frameBuilder: (context,
                                          child,
                                          frame,
                                          wasSynchronouslyLoaded) {
                                    return child;
                                  }, loadingBuilder:
                                          (context, child, loadingProgress) {
                                    //print(loadingProgress);
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
                                icon: Icon(
                                    isFavourite(widget.product[index].prodId) ==
                                            true
                                        ? Icons.favorite
                                        : Icons.favorite_border),
                                //color: const Color.fromARGB(255, 158, 52, 52),
                                onPressed: () async {
                                  if (isFavourite(
                                          widget.product[index].prodId) ==
                                      false) {
                                    await SendToDB(
                                        id, widget.product[index].prodId);
                                  } else {
                                    await DeleteFav(
                                        id, widget.product[index].prodId);
                                  }
                                  final favourites =
                                      await obtainJsonFavourites();
                                  setState(() {
                                    favourite = favourites;
                                  });
                                  widget.function();
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
                              widget.product[index].prodName!,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.product[index].price!.toString()} руб.',
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
                                  print(
                                      'korzina'); // Логика добавления в корзину
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
            ));
      },
    ));
  }
}
