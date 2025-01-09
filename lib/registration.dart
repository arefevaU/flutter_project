import 'package:flutter/material.dart';
import 'package:flutter_application/authorization.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final regKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  String? passwordRep;
  bool? emailCheck = false;

  submit(name, email, password) async {
    //print('submit');
    var url = Uri.http(apiIP!, 'registration', {
      'name': name,
      'email': email,
      'password': password,
    });
    final response = await http.get(url);
    var confirmation = response.body;
    if (confirmation == 'Ok') {
      return;
    } else {
      return false;
    }
  }

  Future<void> emailValidate(String value) async {
    //print('ABOBA');
    final check = await checkUser(value);
    //print('email validate: $check');
    if (check != 200) {
      setState(() {
        emailCheck = false;
      });
    }
    if (check == 200) {
      setState(() {
        emailCheck = true;
      });
    }
  }

  checkUser(value) async {
    //print('ASAS');
    var url = Uri.http(apiIP!, 'CheckUserEmail', {
      'email': value,
    });
    final response = await http.get(url);
    //print('RESPONSE ${response.body}');
    final statusCode = response.statusCode;
    return statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 3,
          width: MediaQuery.sizeOf(context).width * 0.75,
          child: Form(
            key: regKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Имя'),
                  onSaved: (newValue) => name = newValue!,
                  onChanged: (value) => name = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите имя';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  onSaved: (newValue) => email = newValue!,
                  onChanged: (value) => email = value,
                  validator: (value) {
                    if (emailCheck != true) {
                      return 'Данный email уже используется';
                    }
                    if (value!.isEmpty) {
                      return 'Введите email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Пароль'),
                  onSaved: (newValue) => password = newValue!,
                  onChanged: (value) => password = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите пароль';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Повтор пароля'),
                  onSaved: (newValue) => passwordRep = newValue!,
                  onChanged: (value) => passwordRep = value,
                  validator: (value) => value != password
                    ? 'Пароли не совпадают'
                    : null,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
                          var form = regKey.currentState;
                          form?.validate();
                          print('Name: $name, Email: $email, password: $password');
                          await emailValidate(email!);
                          print(emailCheck);
                          if (form!.validate()) {
                            form.save();
                            if (password == passwordRep && emailCheck == true) {
                              submit(name, email, password);
                            }
                          }
                        },
                        child: Text('Зарегистироваться'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationScreen()));
                        },
                        child: Text('Авторизация'),
                      ),
                    ],
                  ),
                  )
              ],
            ),
          ),
        )
      ),
    );
  }
}