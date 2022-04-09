import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lucky/constants/Utilities.dart';
import 'package:lucky/components/appBar.dart';
import 'package:lucky/constants/constants.dart';
import '../products/productModel.dart';
import '../checkOutScreen/checkOutScreen.dart';
//import 'package:lucky/screens/loginScreen.dart';
import 'package:provider/provider.dart';

import 'cartStore.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // String qty;
  // String pr;
  // String fp;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var store = Provider.of<MyStore>(context);

    return Scaffold(
        /*appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: themeColor,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: Consumer(builder: (context, watch, _){
        return Badge(position: BadgePosition(top: 0, end: 1),
        animationDuration: Duration(milliseconds: 500),
        animationType: BadgeAnimationType.scale,
        showBadge: true,
        badgeColor: Colors.red,
        badgeContent: Text('${watch(cartListProvider.state).length}'),
        child: FloatingActionButton(
          ,),)
      }),*/
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: ListTile(
                title: Text("Total  "),
                subtitle: Text(
                  "\u{20B9}" +
                      (store.carts != []
                          ? store.getBasketTotal().toString()
                          : 0),
                  style:
                      TextStyle(color: themeColor, fontWeight: FontWeight.bold),
                ),
              )),
              Expanded(
                child: MaterialButton(
                  padding: EdgeInsets.only(right: 10),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthenticationWrapper()
                            ));
                  },
                  child: Text(
                    "Check out",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: themeColor,
                ),
              )
            ],
          ),
        ),
        body: CustomScrollView(slivers: [
          MyAppBar(name: "Cart"),
          SliverToBoxAdapter(
              child: Container(
                  height: size.height * 0.8,
                  child: ListView.builder(
                    itemCount: store.carts.length,
                    itemBuilder: (context, index) {
                      Cart cart = store.carts[index];
                      // List<String> quantities = [];

                      // var qtyresult = cart.product.quantity.split(",");
                      // for (var p in qtyresult) {
                      //   quantities.add(p.trim());
                      // }

                      // List<int> prices = [];
                      // var priceresult = cart.product.price.split(",");
                      // for (var p in priceresult) {
                      //   prices.add(int.parse(p.trim()));
                      // }

                      // List<String> fadeprices = [];

                      // var faderesult = cart.product.fadeprice.split(",");
                      // for (var p in faderesult) {
                      //   fadeprices.add(p.trim());
                      // }

                      return cart.number == 0
                          ? Container()
                          : Container(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Image.network(
                                      cart.product.images[0],
                                      fit: BoxFit.contain,
                                      width: size.height * 0.12,
                                      height: size.height * 0.15,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 0.35,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              7, 15, 0, 0),
                                          child: Text(
                                            cart.product.name,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 0, 0, 0),
                                            child: Text(
                                              "\u{20B9} " +
                                                //getQuantityPrice(cart.qty, cart.product.quantityPriceMap, QuantityPriceType.price),
                                                   cart.product.quantityPriceMap[cart.qty].last.toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: themeColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: isFadePriceEmpty(cart.product.quantityPriceMap[cart.qty])
                                            // cart.product.quantityPriceMap[cart.qty].last ==
                                            //         0
                                                ? Text(' ')
                                                : Text(
                                                    "\u{20B9} " + 
                                                    //getQuantityPrice(cart.qty, cart.product.quantityPriceMap, QuantityPriceType.fadeprice),
                                                        cart.product.quantityPriceMap[cart.qty].first.toString(),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 16),
                                                  ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 10),
                                        height: 25,
                                        padding: EdgeInsets.only(left: 8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: themeColor, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: DropdownButton<String>(
                                            underline: SizedBox(),
                                            hint: Text(cart.qty),
                                            onChanged: (newValue) {
                                              //cart.qty = newValue;
                                              setState(() {
                                                cart.qty = newValue;
                                                // store.setActive(
                                                //       cart.product, cart.qty);
                                              });
                                            },
                                            value: cart.qty,
                                            items: cart.product.quantityPriceMap.keys
                                                .map((e) =>
                                                    DropdownMenuItem<String>(
                                                      child: Text(
                                                        e,
                                                        style: TextStyle(
                                                            fontSize: 12),
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
                                          margin: EdgeInsets.only(
                                              bottom: 10, right: 20),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: themeColor, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  store.setActive(
                                                      cart.product, cart.qty);
                                                  store.removeFromBasket(
                                                      store.activeProduct);
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 30,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                cart.number.toString(),
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  store.setActive(
                                                      cart.product, cart.qty);
                                                  store.addToBasket(
                                                      store.activeProduct);
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
                    },
                  )
                  ))
        ]));
  }
}
