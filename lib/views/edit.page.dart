import 'package:flutter/material.dart';
import 'package:shoppinglist/models/shop.model.dart';
import 'package:shoppinglist/repositories/shop.repository.dart';

class EditPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _shop = Shop();
  final _repository = ShopRepo();

  void submitForm(BuildContext context, Shop shop) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.update(_shop, shop);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Shop shop = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Buy'),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              submitForm(context, shop);
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: shop.texto,
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
                  initialValue: shop.quantidade.toString(),
                  decoration: InputDecoration(
                    labelText: "Quantidade",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (quantidade) =>
                      _shop.quantidade = int.parse(quantidade),
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
    );
  }
}
