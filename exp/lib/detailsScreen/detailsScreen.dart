import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lucky/components/appBar.dart';
import 'package:lucky/components/search.dart';
import 'package:lucky/constants/constants.dart';
import '../products/productModel.dart';
import '../cartScreen/cartScreen.dart';
import '../cartScreen/cartStore.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../constants/Utilities.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key key,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // String qty;
  // String pr;
  // String fp;
  int current = 0;

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    Size size = MediaQuery.of(context).size;
    
    // List<String> quantities = [];

    // var qtyresult = store.activeProduct.product.quantity.split(",");
    // for (var p in qtyresult) {
    //   quantities.add(p.trim());
    // }

    // List<int> prices = [];
    // var priceresult = store.activeProduct.product.price.split(",");
    // for (var p in priceresult) {
    //   prices.add(int.parse(p.trim()));
    // }

    // List<String> fadeprices = [];

    // var faderesult = store.activeProduct.product.fadeprice.split(",");
    // for (var p in faderesult) {
    //   fadeprices.add(p.trim());
    // }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 1,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: FloatingActionButton(
              child: Container(
                margin: const EdgeInsets.all(.0),
                child: Icon(
                  Icons.favorite_border,
                  color: themeColor,
                ),
              ),
              backgroundColor: Colors.white,
              onPressed: () {}),
          body: ListView(children: [
            Container(
              height: size.height * 0.45,
              width: size.width,
              child: GridTile(
                child: Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: size.height * 0.45,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              current = index;
                            });
                          }),
                      items: store.activeProduct.product.images.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.network(
                              i,
                              fit: BoxFit.contain,
                            );
                          },
                        );
                      }).toList(),
                    )),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: store.activeProduct.product.images.map((e) {
                  int index = store.activeProduct.product.images.indexOf(e);
                  return Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: current == index
                            ? Colors.grey.shade800
                            : Colors.grey),
                  );
                }).toList()),
            Container(
                height: size.height * 0.55,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.18),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(-5, -10),
                          blurRadius: 5,
                          color: Colors.grey.withOpacity(0.1))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.activeProduct.product.name,
                        style: TextStyle(fontSize: 23, letterSpacing: -0.2),
                      ),
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 15, 30, 10),
                              child: Text(
                                "\u{20B9} " +
                                    getQuantityPrice(
                                        store.activeProduct.qty,
                                        store.activeProduct.product
                                            .quantityPriceMap,
                                        QuantityPriceType.price),
                                // (store.activeProduct.qty != ""
                                //     ? store
                                //         .activeProduct
                                //         .product
                                //         .quantityPriceMap[
                                //             store.activeProduct.qty]
                                //         .last
                                //         .toString()
                                //     : store.activeProduct.product
                                //         .quantityPriceMap.values.first.last
                                //         .toString()),
                                style: TextStyle(
                                    color: themeColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 15, 20, 10),
                              child: isFadePriceEmpty(store.activeProduct
                                      .product.quantityPriceMap.values.first)
                                  // store
                                  //             .activeProduct
                                  //             .product
                                  //             .quantityPriceMap
                                  //             .values
                                  //             .first
                                  //             .first == store
                                  //             .activeProduct
                                  //             .product
                                  //             .quantityPriceMap
                                  //             .values
                                  //             .first.last
                                  ? Text('')
                                  : Text(
                                      "\u{20B9} " +
                                          getQuantityPrice(
                                              store.activeProduct.qty,
                                              store.activeProduct.product
                                                  .quantityPriceMap,
                                              QuantityPriceType.fadeprice),
                                      // (store.activeProduct.qty !=
                                      //         ""
                                      //     ? store
                                      //         .activeProduct
                                      //         .product
                                      //         .quantityPriceMap[
                                      //             store.activeProduct.qty]
                                      //         .first
                                      //         .toString()
                                      //     : store
                                      //         .activeProduct
                                      //         .product
                                      //         .quantityPriceMap
                                      //         .values
                                      //         .first
                                      //         .first
                                      //         .toString()),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 22),
                                    )),
                          Spacer(),
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 10, top: 15, right: 15),
                            height: 28,
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: themeColor, width: 1),
                                borderRadius: BorderRadius.circular(50)),
                            child: DropdownButton<String>(
                                underline: SizedBox(),
                                hint: Text(
                                  //getQuantityPrice(store.activeProduct.qty, store.activeProduct.product.quantityPriceMap, QuantityPriceType.quantity),
                                  store.activeProduct.product.quantityPriceMap
                                      .keys.first,
                                  style: TextStyle(fontSize: 15),
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    //store.activeProduct.qty = newValue;
                                    store.setActive(
                                                      store.activeProduct.product, newValue);
                                  });
                                },
                                value: getQuantityPrice(
                                    store.activeProduct.qty,
                                    store
                                        .activeProduct.product.quantityPriceMap,
                                    QuantityPriceType.quantity),
                                // store.activeProduct.qty != ""
                                //     ? store.activeProduct.qty
                                //     : store.activeProduct.product
                                //         .quantityPriceMap.keys.first,
                                items: store
                                    .activeProduct.product.quantityPriceMap.keys
                                    .map((e) => DropdownMenuItem<String>(
                                          child: Text(
                                            e,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          value: e,
                                        ))
                                    .toList()),
                          ),
                        ],
                      ),
                      Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, left: 10),
                                child: Text(
                                    store.activeProduct.product.brand +
                                        "\n" +
                                        store.activeProduct.product.category,
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  store.activeProduct.product.description,
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          store.activeProduct.number == 0
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      store.activeProduct.qty =
                                          getQuantityPrice(
                                              store.activeProduct.qty,
                                              store.activeProduct.product
                                                  .quantityPriceMap,
                                              QuantityPriceType.quantity);
                                      store.addToBasket(store.activeProduct);
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.4,
                                    height: 50,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 30),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: themeColor, width: 1),
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 10),
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 5)
                                        ]),
                                    child: Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade600),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: size.width * 0.4,
                                  height: 50,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(bottom: 30),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: themeColor, width: 1),
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 5)
                                      ]),
                                  child: Row(children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          store.removeFromBasket(
                                              store.activeProduct);
                                        });
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        size: 25,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      store.activeProduct.number.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade600),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          store
                                              .addToBasket(store.activeProduct);
                                        });
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 25,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ]),
                                ),
                          InkWell(
                            onTap: () {
                              store.addToBasket(store.activeProduct);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => (CartScreen())));
                            },
                            child: Container(
                                width: size.width * 0.4,
                                height: 50,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 30),
                                decoration: BoxDecoration(
                                    color: themeColor,
                                    border:
                                        Border.all(color: themeColor, width: 1),
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 10),
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 4)
                                    ]),
                                child: Text(
                                  'Buy now',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ]))
          ])),
    );
  }
}
