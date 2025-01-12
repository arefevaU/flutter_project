import 'package:flutter/material.dart';
import 'package:flutter_application/api_request.dart';
import 'package:flutter_application/registration.dart';
import 'package:http/http.dart' as http;
import 'category_buttons.dart';
import 'main.dart';

List category = List.empty();
List products = List.empty();
void filterProducts() {
  product = products.where((prd) => prd.catId == selectedFilter).toList();
}

List favourite = List.empty();

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final authKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? formCheck;

  Future<void> formValidate(email, password) async {
    final check = await authorize(email, password);
    if (check[0] == 200) {
      setState(() {
        id = check[1] as int;
        formCheck = true;
      });
    } else if (check[0] != 200) {
      setState(() {
        formCheck = false;
      });
    }
  }

  authorize(email, password) async {
    var url = Uri.http(apiIP!, 'authorization', {
      'email': email,
      'password': password,
    });
    final response = await http.get(url);
    //var confirmation = response.body;
    if (response.statusCode.toInt() == 200) {
      return [response.statusCode, int.tryParse(response.body)];
    } else {
      return response.statusCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 3,
                width: MediaQuery.sizeOf(context).width * 0.75,
                child: Form(
                  key: authKey,
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Авторизация',
                              style: TextStyle(fontSize: 28))),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'email'),
                        onSaved: (newValue) => email = newValue!,
                        onChanged: (value) => email = value,
                        validator: (value) {
                          if (formCheck != true) {
                            return 'Неверные данные';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Пароль'),
                        onSaved: (newValue) => password = newValue!,
                        onChanged: (value) => password = value,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  //print('nazali');
                                  var form = authKey.currentState;
                                  form?.validate;
                                  await formValidate(email, password);
                                  if (form!.validate()) {
                                    form.save();
                                    print('id: $id');
                                    final categories =
                                        await obtainJsonCategories();
                                    final product = await obtainJsonProducts();
                                    final favourites =
                                        await obtainJsonFavourites();
                                    setState(() {
                                      category = categories;
                                      products = product;
                                      favourite = favourites;
                                    });
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()));
                                  }
                                },
                                child: Text('Войти')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                                child: Text('Зарегистироваться')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
