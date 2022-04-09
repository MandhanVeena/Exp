import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../products/productModel.dart';

class ProductServices {
  CollectionReference productList =
      FirebaseFirestore.instance.collection('products');

  Future getProducts() async {
    List products = [];
    try {
      await productList.get().then((value) => value.docs.forEach((element) {
            products.add(element.data());
          }));
      return products;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getProductById(String productId) async {
    Product product;
    try {
      await productList.doc(productId).get().then((item) {
        var quantityPriceMap = Map<String, List<double>>();

        if (item['quantityPriceMap'] != null) {
          quantityPriceMap = {
            for (var e in item['quantityPriceMap'].entries)
              e.key as String: List<double>.from(e.value)
          };
        }
        product = Product(
            item['productId'],
            item['name'],
            item['images'],
            item['brand'],
            item['category'],
            item['description'],
            quantityPriceMap,
            item['stock'],
            item['trending'],
            item['priority']);
      });
      return product;
    } catch (error) {
      print(error.localizedDescription);
    }
  }
}
