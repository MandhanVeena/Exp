// class ProductModel {
//   static const String BRAND = 'brand';
//   static const String CATEGORY = 'category';
//   static const String ID = 'id';
//   static const String NAME = 'name';
//   static const String PICTURE = 'picture';
//   static const String QUANTITY = 'quantity';
//   static const String PRICE = 'price';
//   static const String DESCRIPTION = 'description';
//   static const String OUTSTOCK = 'outstock';
//   static const String TRENDING = 'trending';
//   static const String FADEPRICE = 'fadeprice';
//   static const String PRIORITY = 'priority';

//   String _brand;
//   String _category;
//   String _id;
//   String _name;
//   String _picture;
//   String _quantity;
//   String _price;
//   String _description;
//   bool _outstock;
//   bool _trending;
//   String _fadeprice;
//   double _priority;

//   String get brand => _brand;
//   String get category => _category;
//   String get id => _id;
//   String get name => _name;
//   String get picture => _picture;
//   String get quantity => _quantity;
//   String get price => _price;
//   String get description => _description;
//   bool get outstock => _outstock;
//   bool get trending => _trending;
//   String get fadeprice => _fadeprice;
//   double get priority => _priority;

//   ProductModel.fromSnapshot(DocumentSnapshot snapshot)
//       : _brand = snapshot[BRAND],
//         _category = snapshot[CATEGORY],
//         _description = snapshot[DESCRIPTION],
//         _id = snapshot[ID],
//         _name = snapshot[NAME],
//         _outstock = snapshot[OUTSTOCK],
//         _picture = snapshot[PICTURE],
//         _price = snapshot[PRICE],
//         _quantity = snapshot[QUANTITY],
//         _trending = snapshot[TRENDING],
//         _fadeprice = snapshot[FADEPRICE],
//         _priority = snapshot[PRIORITY];
// }

import 'package:luckyadmi/db/product.dart';

class Product {
  String brand;
  String category;
  String productId;
  String name;
  List images;
  // String quantity;
  // String price;
  // String fadeprice;
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

List<Product> convertMapToProduct(List products) {
  List<Product> finalProducts = [];
  for (var item in products) {
    
    var quantityPriceMap = Map<String, List<double>>();

    if (item['quantityPriceMap'] != null) {
      quantityPriceMap = {for (var e in item['quantityPriceMap'].entries) e.key as String: List<double>.from(e.value)};
    }

    finalProducts.add(
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
  
  return finalProducts;
}

Future<List<Product>> fetchDatabaseList() async {
  List resultant = await ProductService().getProducts1();
  if (resultant == null) {
    print("unable to retrieve");
    return [];
  } else {
    return convertMapToProduct(resultant);
  }
}

Map<String, List<double>> quantityPriceToJson(Map<String, List<double>> data) {
  print(data);
  return data;
}
