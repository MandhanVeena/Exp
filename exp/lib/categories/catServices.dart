import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lucky/categories/caregoryModel.dart';
import '../products/productModel.dart';

class CategoryServices {
  CollectionReference catList =
      FirebaseFirestore.instance.collection('categories');

  Future getCategories() async {
    List cat = [];
    try {
      await catList.get().then((value) => value.docs.forEach((element) {
            cat.add(element.data());
          }));
      return cat;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getName(String id) async {
    try {
      await catList.doc(id).get().then((value) => value.get('catName'));
    } catch (e) {
      print(e.toString());
    }
  }

  /*Future<List<CategoryModel>> getCategories() async =>
      _firestore.collection(collection).get().then((result) {
        List<CategoryModel> categories = [];
        for (DocumentSnapshot category in result.docs) {
          categories.add(CategoryModel.fromSnapshot(category));
        }
        return categories;
      });

  /*Future<List<ProductModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.docs) {
            products.add(ProductModel.fromSnapshot(product));
          }
          return products;
        });
  }*/
}

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];
  //List<ProductModel> productsSearched = [];

  CategoryProvider.initialize() {
    loadCategories();
  }

  loadCategories() async {
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }*/

  /*Future search({String productName}) async {
    productsSearched =
        await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }*/
}
