/*import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/models/productModel.dart';
import 'package:lucky/screens/cartScreen/cartStore.dart';
import 'package:provider/provider.dart';

class Single_cart_product extends StatefulWidget {
  final Cart product;

  Single_cart_product({this.product});

  @override
  _Single_cart_productState createState() => _Single_cart_productState();
}

class _Single_cart_productState extends State<Single_cart_product> {
  String qty;
  String pr;
  String fp;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var store = Provider.of<MyStore>(context);

    Product product = widget.product.product;
    

    List<String> quantities = [];

    var qtyresult = product.quantity.split(",");
    for (var p in qtyresult) {
      quantities.add(p.trim());
    }

    List<int> prices = [];
    var priceresult = product.price.split(",");
    for (var p in priceresult) {
      prices.add(int.parse(p.trim()));
    }

    List<String> fadeprices = [];

    var faderesult = product.fadeprice.split(",");
    for (var p in faderesult) {
      fadeprices.add(p.trim());
    }

    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            (8),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 10,
                color: Colors.grey.withOpacity(0.23))
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.network(
              product.images[0],
              fit: BoxFit.contain,
              width: size.height * 0.12,
              height: size.height * 0.15,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.35,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 15, 0, 0),
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 17.5,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      "\u{20B9} " + (pr == null ? prices[0].toString() : pr),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: product.fadeprice == ''
                        ? Text(' ')
                        : Text(
                            "\u{20B9} " + (fp == null ? fadeprices[0] : fp),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 16),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                height: 25,
                padding: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: themeColor, width: 1),
                    borderRadius: BorderRadius.circular(50)),
                child: DropdownButton<String>(
                    underline: SizedBox(),
                    hint: Text(quantities[0]),
                    onChanged: (newValue) {
                      qty = newValue;
                      setState(() {
                        qty = newValue;
                        for (int i = 0; i < quantities.length; i++) {
                          if (newValue == quantities[i]) {
                            pr = prices[i].toString();
                            if (product.fadeprice != '') fp = fadeprices[i];
                          }
                        }
                      });
                    },
                    value: qty,
                    items: quantities
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(
                                e,
                                style: TextStyle(fontSize: 12),
                              ),
                              value: e,
                            ))
                        .toList()),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: size.height * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10, right: 20),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: themeColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          store.setActive(product);
                          store.removeFromBasket(store.activeProduct);
                        });
                      },
                      child: Icon(
                        Icons.remove,
                        size: 30,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.product.number.toString(),
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          store.setActive(product);
                          store.addToBasket(store.activeProduct);
                        });
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/