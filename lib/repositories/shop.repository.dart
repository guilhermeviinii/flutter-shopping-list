import 'package:shoppinglist/models/shop.model.dart';

class ShopRepo {
  // ignore: deprecated_member_use
  static List<Shop> shops = List<Shop>();

  ShopRepo() {
    if (shops.isEmpty) {
      shops.add(Shop(
          id: '1', texto: "Nova compra 1", quantidade: 1, finalizada: false));
      shops.add(Shop(
          id: '2', texto: "Nova compra 2", quantidade: 2, finalizada: true));
      shops.add(Shop(
          id: '3', texto: "Nova compra 3", quantidade: 3, finalizada: true));
    }
  }

  void create(Shop shop) {
    shops.add(shop);
  }

  List<Shop> read() {
    return shops;
  }

  void delete(String id) {
    final shop = shops.singleWhere((t) => t.texto == id);
    shops.remove(shop);
  }

  void update(Shop newShop, Shop oldShop) {
    final shop = shops.singleWhere((t) => t.texto == oldShop.texto);
    shop.texto = newShop.texto;
    shop.quantidade = newShop.quantidade;
  }
}
