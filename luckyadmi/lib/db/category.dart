import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'categories';

  void createCategory(String name, String image, double priority) {
    var id = Uuid();
    String categoryId = id.v1();

    _firestore
        .collection(ref)
        .doc(categoryId)
        .set({'catId': categoryId,'catName': name, 'image': image, 'priority': priority});
  }

  Future<List<DocumentSnapshot>> getCategories() =>
      _firestore.collection(ref).get().then((snaps) {
        return snaps.docs;
      });

  Future getCategories1() async {
    List categories = [];
    try {
      await _firestore
          .collection(ref)
          .get()
          .then((value) => value.docs.forEach((element) {
                categories.add(element.data());
              }));
      return categories;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(ref)
          .where('category', isEqualTo: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });

  deleteImage(String url) async {
    Reference reference = FirebaseStorage.instance.refFromURL(url);
    await reference.delete().then((value) => {
      print("Deleted")
    });
  }

  deleteCategory(String categoryId) async {
    await _firestore.collection(ref).doc(categoryId).delete();
  }
}
