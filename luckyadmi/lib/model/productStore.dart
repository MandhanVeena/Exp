import 'package:flutter/material.dart';
import 'productModel.dart';
import '../db/product.dart';

class MyStore extends ChangeNotifier {
  List<Product> products = [];
  List<Product> thisCat;
  List pro = [];


  List<Product> get _products => products;

  fetchDatabaseList() async {
    dynamic resultant = await ProductService().getProducts1();
    if (resultant == null) {
      print("unable to retrieve");
    } else {
      pro = resultant;
      products = convertMapToProduct(resultant);
      print("ProdLength" + "${products.length}");
    }
    return products;
  }

  MyStore() {
    fetchDatabaseList();
    notifyListeners();
  }

  fetchByCategory(category) {
    thisCat = [];
    for (Product item in products) {
      if (item.brand == category || item.category == category) {
        thisCat.add(item);
      }
    }
  }

  getProducts() {
    return products;
  }
}
