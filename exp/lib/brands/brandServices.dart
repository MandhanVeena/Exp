import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lucky/categories/caregoryModel.dart';
import '../products/productModel.dart';

class BrandServices {
  CollectionReference brandList =
      FirebaseFirestore.instance.collection('brands');

  Future getBrands() async {
    List brands = [];
    try {
      await brandList.get().then((value) => value.docs.forEach((element) {
            brands.add(element.data());
          }));
      return brands;
    } catch (e) {
      print(e.toString());
    }
  }

  /*Future<List<CategoryModel>> getBrands() async =>
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
  BrandServices _brandServices = BrandServices();
  List<CategoryModel> categories = [];
  //List<ProductModel> productsSearched = [];

  CategoryProvider.initialize() {
    loadCategories();
  }

  loadCategories() async {
    categories = await _brandServices.getBrands();
    notifyListeners();
  }*/

  /*Future search({String productName}) async {
    productsSearched =
        await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }*/
}
