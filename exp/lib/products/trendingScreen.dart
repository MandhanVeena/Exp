import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/components/appBar.dart';
import 'package:lucky/components/drawer.dart';
import 'package:lucky/components/search.dart';
import '../products/productModel.dart';
import 'package:lucky/brands/brandServices.dart';
import '../detailsScreen/detailsScreen.dart';
import 'productCard.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'productServices.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({
    Key key,
  }) : super(key: key);

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  List productList = [];
  List trendingList = [];

  @override
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
    return Scaffold(
        drawer: buildDrawer(context),
        body: CustomScrollView(slivers: [
          MyAppBar(name: "Trending"),
          SliverPinnedHeader(
            child: SearchWidget(),
          ),
          SliverToBoxAdapter(
              child: Container(
                  height: size.height * 0.8,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: trendingList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.75),
                    itemBuilder: (context, index) {
                      var quantityPriceMap = Map<String, List<double>>();
                      if (trendingList[index]['quantityPriceMap'] != null) {
                        quantityPriceMap = {
                          for (var e in trendingList[index]['quantityPriceMap']
                              .entries)
                            e.key as String: List<double>.from(e.value)
                        };
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
                    },
                  )))
        ]));
  }
}
