import 'package:flutter/material.dart';
import 'package:shoppinglist/views/edit.page.dart';
import 'package:shoppinglist/views/list.page.dart';
import 'package:shoppinglist/views/newshop.page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp um unico só - Método para desenhar a tela do aplicativo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ListPage(),
        '/new': (context) => NewShop(),
        '/edit': (context) => EditPage(),
      },
      initialRoute: '/',
    );
  }
}
