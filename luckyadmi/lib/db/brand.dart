import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'brands';

  void createBrand(String name, String image, double priority) {
    var id = Uuid();
    String brandId = id.v1();

    _firestore
        .collection(ref)
        .doc(brandId)
        .set({'brandId': brandId,'brandName': name, 'image': image, 'priority': priority});
  }

  Future<List<DocumentSnapshot>> getBrands() =>
      _firestore.collection(ref).get().then((snaps) {
        return snaps.docs;
      });

  Future getBrands1() async {
    List brands = [];
    try {
      await _firestore
          .collection(ref)
          .get()
          .then((value) => value.docs.forEach((element) {
                brands.add(element.data());
              }));
      print(brands);
      return brands;
    } catch (e) {
      print(e.toString());
    }
  }

  deleteImage(String url) async {
    Reference reference = FirebaseStorage.instance.refFromURL(url);
    await reference.delete().then((value) => {print("Deleted")});
  }

  deleteBrand(String brandId) async {
    await _firestore.collection(ref).doc(brandId).delete();
  }

  /*Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(ref)
          .where('brand', isEqualTo: suggestion)
          .get()
          .then((snap) {

        return snap.docs;
      });*/
}
