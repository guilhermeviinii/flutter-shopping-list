import 'package:flutter/material.dart';
import 'package:shoppinglist/models/shop.model.dart';
import 'package:shoppinglist/repositories/shop.repository.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final repo = ShopRepo();
  List<Shop> shops;
  @override
  initState() {
    super.initState();

    this.shops = repo.read();
  }

  Future handleAddTask(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/new');
    if (result == true) {
      setState(() => {this.shops = repo.read()});
    }
  }

  Future<bool> confirmarExclusao(BuildContext context, texto) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            title: Text("Você tem certeza que deseja exlcuir?"),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("NÃO")),
              FlatButton(
                  onPressed: () => {
                        Navigator.of(context).pop(true),
                        repo.delete(texto),
                        setState(() => this.shops = repo.read())
                      },
                  child: Text("SIM")),
            ],
          );
        });
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {

        this.shops.sort((a, b) => b.finalizada ? 1 : -1);
      } else {
        this.shops.sort((a, b) => b.finalizada ? -1 : 1);
      }
    }
    if (columnIndex == 1) {
      if (ascending) {
        this.shops.sort((a, b) => a.quantidade.compareTo(b.quantidade));

        print(this.shops.map((shop) => shop.quantidade));
      } else {
        this.shops.sort((a, b) => b.quantidade.compareTo(a.quantidade));
      }
    }
  }

  bool sort = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              children: [Icon(Icons.shop)],
            ),
            Column(
              children: [Text('Shop List')],
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: DataTable(
            showCheckboxColumn: true,
            sortColumnIndex: 1,
            sortAscending: true,
            columns: <DataColumn>[
              DataColumn(
                label: Text("Nome"),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    this.sort = !sort;
                  });
                  onSortColum(columnIndex, sort);
                },
              ),
              DataColumn(
                label: Text("Quantidade"),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    this.sort = !sort;
                  });
                  onSortColum(columnIndex, sort);
                },
              ),
              DataColumn(
                label: Text("Ações"),
                onSort: (_, __) {
                  setState(() {});
                },
              ),
            ],
            rows: shops
                .map(
                  (shop) => DataRow(
                    selected: shop.finalizada,
                    onSelectChanged: (b) {
                      setState(() => shop.finalizada = b);
                    },
                    cells: [
                      DataCell(
                        Text('${shop.texto ?? ""}'),
                      ),
                      DataCell(
                        shop.quantidade >= 1
                            ? Text('${shop.quantidade}')
                            : Text('SEM ESTOQUE',
                                style: TextStyle(color: Colors.red)),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  var result = await Navigator.of(context)
                                      .pushNamed('/edit', arguments: shop);
                                  if (result) {
                                    setState(() => this.shops = repo.read());
                                  }
                                }),
                            IconButton(
                                icon: Icon(Icons.close),
                                color: Colors.red,
                                onPressed: () =>
                                    confirmarExclusao(context, shop.texto)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => handleAddTask(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
