import 'package:flutter/material.dart';
import '../products/productModel.dart';
import '../products/productServices.dart';
import 'package:uuid/uuid.dart';

import 'cartHelper.dart';

class MyStore extends ChangeNotifier {
  List<Product> products = [];
  List<Cart> carts = [];
  List<Product> thisCat;
  Cart activeProduct;
  List pro = [];

  //List<Product> get _products => products;
  //List<Cart> get _carts => carts;
  //Product get _activeProduct => activeProduct;

  fetchDatabaseList() async {
    dynamic resultant = await ProductServices().getProducts();
    if (resultant == null) {
      print("unable to retrieve");
    } else {
      pro = resultant;
      for (var item in resultant) {
        var quantityPriceMap = Map<String, List<double>>();

        if (item['quantityPriceMap'] != null) {
          quantityPriceMap = {
            for (var e in item['quantityPriceMap'].entries)
              e.key as String: List<double>.from(e.value)
          };
        }

        products.add(
          Product(
              item['productId'],
              item['name'],
              item['images'],
              item['brand'],
              item['category'],
              item['description'],
              quantityPriceMap,
              item['stock'],
              item['trending'],
              item['priority']),
        );
      }
    }
  }

  MyStore() {
    fetchDatabaseList();
    callCart();
    notifyListeners();
  }

  callCart() async {
    List<Map<String, dynamic>> rows = await DatabaseHelper.instance.queryAll();
    print("data $rows");
    for (var i in rows) {
      // List img = [];
      // img.add(i['images']);

      // Map<String, List<double>> quantityPriceMap = Map<String, List<double>>();
      // if (i['quantityPriceMap'] != null) {
      //   quantityPriceMap = {
      //     for (var e in i['quantityPriceMap'].entries)
      //       e.key as String: List<double>.from(e.value)
      //   };
      // }

      Product thisProduct =
          await ProductServices().getProductById(i['productId']);

      carts.add(Cart(i['cartId'], thisProduct, i['number'], i['qty']));
    }
  }

  setActive(Product p, String qty) {
    Cart found;
    if (carts != [])
      found = carts.firstWhere(
          (element) =>
              element.product.productId == p.productId &&
              element.qty == qty,
          orElse: () => null);
    if (found != null) {
      activeProduct =
          Cart(found.cartId, found.product, found.number, found.qty);
      print("if Called $qty");
    } else {
      var uuid = Uuid();
      String cartId = uuid.v1();
      activeProduct = Cart(cartId, p, 0, qty);
      print("Else called");
    }
  }

  fetchByCategory(category) {
    thisCat = [];
    for (Product item in products) {
      if (item.brand == category || item.category == category) {
        thisCat.add(item);
      }
    }
  }

  /*getQty(Cart p) async {
    Cart found = carts.firstWhere(
        (element) => element.product.name == p.product.name,
        orElse: () => null);

    for (var c in carts) {
      print(c.product.name);
    }
    print(found.number);
    print(p.number);
    if (found != null)
      return p.number;
    else
      return 0;
  }*/

  addToBasket(Cart p) async {
    Cart found = carts.firstWhere((element) => element.cartId == p.cartId,
        orElse: () => null);
    if (found != null) {
      found.number++;
      p.number = found.number;
      int gt = await DatabaseHelper.instance.update({
        DatabaseHelper.cartId: p.cartId,
        DatabaseHelper.number: found.number
      });
      print(gt);
    } else {
      p.number = 1;
      carts.add(p);
      await DatabaseHelper.instance.insert({
        DatabaseHelper.cartId: p.cartId,
        DatabaseHelper.number: p.number,
        DatabaseHelper.qty: p.qty,
        DatabaseHelper.productId: p.product.productId,
      });
    }

    notifyListeners();
  }

  removeFromBasket(Cart p) async {
    Cart found = carts.firstWhere((element) => element.cartId == p.cartId,
        orElse: () => null);
    if (found != null && found.number == 1) {
      p.number = 0;
      carts.remove(found);
      await DatabaseHelper.instance.delete(p.cartId);
    } else if (found.number != 1) {
      found.number--;
      p.number = found.number;
      await DatabaseHelper.instance.update({
        DatabaseHelper.cartId: p.cartId,
        DatabaseHelper.number: p.number,
      });
    } else {
      print("found null");
    }

    for (var c in carts) {
      print(c.product.productId);
      print(c.number);
    }

    notifyListeners();
  }

  getProductQty(Product product) {
    Cart found = carts.firstWhere(
        (element) => element.product.productId == product.productId,
        orElse: () => null);
    if (found != null) {
      return found.qty;
    } else {
      return "";
    }
  }

  getBasketQty() {
    int total = 0;
    for (int i = 0; i < carts.length; i++) {
      total += carts[i].number;
    }

    return total;
  }

  getBasketTotal() {
    double total = 0;
    for (int i = 0; i < carts.length; i++) {
      total += ((carts[i].product.quantityPriceMap[carts[i].qty].last) * carts[i].number);
    }

    return total;
  }

}