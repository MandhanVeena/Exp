class Product {
  String brand;
  String category;
  String productId;
  String name;
  List images;
  Map<String, List<double>> quantityPriceMap;
  String description;
  bool stock;
  bool trending;
  double priority;

  Product(
      this.productId,
      this.name,
      this.images,
      this.brand,
      this.category,
      this.description,
      this.quantityPriceMap,
      this.stock,
      this.trending,
      this.priority);
}

class Cart {
  String cartId;
  Product product;
  int number;
  String qty;

  Cart(this.cartId, this.product, this.number, this.qty);
}


// class Product {
//   String brand;
//   String category;
//   String prodId;
//   String name;
//   List images;
//   String quantity;
//   String price;
//   String fadeprice;
//   String description;
//   bool stock;
//   bool trending;
//   double priority;

//   Product(
//       this.prodId,
//       this.name,
//       this.images,
//       this.price,
//       this.quantity,
//       this.brand,
//       this.category,
//       this.description,
//       this.fadeprice,
//       this.stock,
//       this.trending,
//       this.priority);

//   Product.fromJson(Map<String, dynamic> json) {
//     prodId = json['prodId'];
//     name = json['name'];
//     price = json['price'];
//     quantity = json['quantity'];
//     brand = json['brand'];
//     category = json['category'];
//     description = json['description'];
//     fadeprice = json['fadeprice'];
//     stock = json['stock'] as bool;
//     trending = json['trending'] as bool;
//     priority = double.parse(json['priority']);

//     if (json['images'] != null) {
//       json['images'].forEach((v) {
//         images.add(v);
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final data = Map<String, dynamic>();
//     data['prodId'] = this.prodId;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['quantity'] = this.quantity;
//     data['brand'] = this.brand;
//     data['category'] = this.category;
//     data['fadeprice'] = this.fadeprice;
//     data['stock'] = this.stock;
//     data['trending'] = this.trending;
//     data['priority'] = this.priority;
//     data['images'] = this.images.map((e) => e).toList();

//     return data;
//   }
// }

// class Cart {
//   Product product;
//   int number;

//   Cart(this.product, this.number);

//   Cart.fromJson(Map<String, dynamic> json) {
//     number = json['number'];
//     if (json['product'] != null) {
//       json['product'].forEach((v) {
//         Product.fromJson(v);
//       });
//     }
//   }

//    Map<String, dynamic> toJson() {
//     final data = Map<String, dynamic>();
//     data['number'] = this.number;
//     data['product'] = this.product.toJson();
    
//     return data;
//   }
// }





/*import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const String BRAND = 'brand';
  static const String CATEGORY = 'category';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PICTURE = 'picture';
  static const String QUANTITY = 'quantity';
  static const String NUMBER = 'number';
  static const String PRICE = 'price';
  static const String DESCRIPTION = 'description';
  static const String OUTSTOCK = 'outstock';
  static const String TRENDING = 'trending';

  String _brand;
  String _category;
  String _id;
  String _name;
  String _picture;
  List _quantity;
  int _number;
  double _price;
  String _description;
  bool _outstock;
  bool _trending;

  String get brand => _brand;
  String get category => _category;
  String get id => _id;
  String get name => _name;
  String get picture => _picture;
  List get quantity => _quantity;
  int get number => _number;
  double get price => _price;
  String get description => _description;
  bool get outstock => _outstock;
  bool get trending => _trending;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot)
      : _brand = snapshot[BRAND],
        _category = snapshot[CATEGORY],
        _description = snapshot[DESCRIPTION],
        _id = snapshot[ID],
        _name = snapshot[NAME],
        _number = snapshot[NUMBER],
        _outstock = snapshot[OUTSTOCK],
        _picture = snapshot[PICTURE],
        _price = snapshot[PRICE],
        _quantity = snapshot[QUANTITY],
        _trending = snapshot[TRENDING];
}*/

