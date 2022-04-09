import 'package:flutter/material.dart';
import 'package:lucky/constants/Utilities.dart';
import 'package:lucky/constants/constants.dart';
import '../products/productModel.dart';
import '../cartScreen/cartStore.dart';
import '../detailsScreen/detailsScreen.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);

    // List<double> prices = [];
    // var result = product.price.split(",");
    // for (var p in result) {
    //   prices.add(double.parse(p));
    // }

    return GestureDetector(
      onTap: () {
        var qty = store.getProductQty(product);
        store.setActive(product, qty);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailsScreen()));
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, top: 5, bottom: 8),
        padding: EdgeInsets.fromLTRB(2, 3, 0, 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.23))
            ]),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.only(left: 3, right: 2, top: 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style:
                                    Theme.of(context).textTheme.button.copyWith(
                                          color: themeColor,
                                        ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "\u{20B9} " +
                                    //getQuantityPrice(qty, product.quantityPriceMap, QuantityPriceType.price),
                                    product.quantityPriceMap.values.first.last
                                        .toString(),
                                style:
                                    Theme.of(context).textTheme.button.copyWith(
                                          color: Colors.black,
                                        ),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.favorite_outline_rounded,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
