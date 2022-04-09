import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'products';

  void createProduct(
      String brand,
      String category,
      String name,
      List images,
      String description,
      bool stock,
      bool trending,
      Map<String, List<double>> quantityPriceMap,
      double priority) {
    var id = Uuid();
    String productId = id.v1();

    _firestore.collection(ref).doc(productId).set({
      'productId': productId,
      'category': category,
      'images': images,
      'priority': priority,
      'brand': brand,
      'name': name,
      'description': description,
      'stock': stock,
      'trending': trending,
      'quantityPriceMap': quantityPriceMap,
    });
  }

  Future getProducts() async {
    QuerySnapshot qn = await _firestore.collection(ref).get();
    return qn.docs;
  }

  deleteImage(String url) async {
    Reference reference = FirebaseStorage.instance.refFromURL(url);
    await reference.delete().then((value) => {
      print("Deleted")
    });
  }

  deleteProduct(String productId) async {
    await _firestore.collection(ref).doc(productId).delete();
  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(ref)
          .where('product', isEqualTo: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });

  Future getProducts1() async {
    List products = [];
    try {
      await _firestore
          .collection(ref)
          .get()
          .then((value) => value.docs.forEach((element) {
                products.add(element.data());
              }));
      return products;
    } catch (e) {
      print(e.toString());
    }
  }
}

// class FirebaseFile {
//   final Reference ref;
//   final String name;
//   final String url;

//   const FirebaseFile({this.ref, this.name, this.url});
// }
