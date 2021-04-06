import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppinglist/models/shop.model.dart';
import 'package:shoppinglist/repositories/shop.repository.dart';

class NewShop extends StatefulWidget {
  @override
  _NewShopState createState() => _NewShopState();
}

class _NewShopState extends State<NewShop> {
  final _formKey = GlobalKey<FormState>();

  final _shop = Shop();
  final _repository = ShopRepo();

  void submitForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_shop);
      Navigator.of(context).pop(true);
    }
  }
  

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Buy'),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              submitForm(context);
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _shop.texto = value,
                    validator: (value) =>
                        value.isEmpty ? "Campo obrigatório" : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Quantidade",
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onSaved: (quantidade) => _shop.quantidade = int.parse(quantidade),
                    validator: (quantidade) =>
                        quantidade.isEmpty ? "Campo obrigatório" : null,
                  ),
                ),
                // Add TextFormFields and ElevatedButton here.
                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
