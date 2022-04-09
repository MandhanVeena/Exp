import 'package:flutter/material.dart';
import '../products/productModel.dart';
import 'package:lucky/categories/catServices.dart';
import '../detailsScreen/detailsScreen.dart';
import '../products/productServices.dart';
import '../products/productCard.dart';

class TrendingScrollView extends StatefulWidget {
  TrendingScrollView({Key key}) : super(key: key);

  @override
  _TrendingScrollViewState createState() => _TrendingScrollViewState();
}

class _TrendingScrollViewState extends State<TrendingScrollView> {
  List productList = [];
  List trendingList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await ProductServices().getProducts();
    if (resultant == null) {
      print("unable to retrieve");
    } else {
      setState(() {
        productList = resultant;
        for (var item in productList) {
          if (item['trending'] == true) {
            trendingList.add(item);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      margin: EdgeInsets.only(bottom: 30),
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: trendingList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 0),
          itemBuilder: (context, index) {
            var quantityPriceMap = Map<String, List<double>>();
            if (trendingList[index]['quantityPriceMap'] != null) {
              quantityPriceMap = {for (var e in trendingList[index]['quantityPriceMap'].entries) e.key as String: List<double>.from(e.value)};
            }
            return ProductCard(
              product: Product(
                  trendingList[index]['productId'],
                  trendingList[index]['name'],
                  trendingList[index]['images'],
                  trendingList[index]['brand'],
                  trendingList[index]['category'],
                  trendingList[index]['description'],
                  quantityPriceMap,
                  trendingList[index]['stock'],
                  trendingList[index]['trending'],
                  trendingList[index]['priority']),
            );
          }),
    );
  }
}
