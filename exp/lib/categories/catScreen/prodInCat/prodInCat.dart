import 'package:flutter/material.dart';
import 'package:lucky/components/appBar.dart';
import 'package:lucky/components/search.dart';
import '../../../products/productModel.dart';
import '../../../cartScreen/cartStore.dart';
import 'prodTile.dart';
import '../../../products/productServices.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProdInCat extends StatefulWidget {
  ProdInCat({Key key, this.category}) : super(key: key);

  final String category;

  @override
  _ProdInCatState createState() => _ProdInCatState();
}

class _ProdInCatState extends State<ProdInCat> {
  //List<Product> productList = [];
  //List<Product> thisCat = [];

  /*fetchDatabaseList() async {
    dynamic resultant = await ProductServices().getProducts();
    if (resultant == null) {
      print("unable to retrieve");
    } else {
      setState(() {
        productList = resultant;
        for (var item in productList) {
          if (item['brand'] == widget.category ||
              item['category'] == widget.category) {
            thisCat.add(item);
          }
        }
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var store = Provider.of<MyStore>(context);
    

    return Scaffold(
        body: CustomScrollView(slivers: [
      MyAppBar(name: widget.category),
      SliverPinnedHeader(
        child: SearchWidget(),
      ),
      SliverToBoxAdapter(
          child: Container(
        height: size.height * 0.8,
        child: ListView.builder(
            itemCount: store.thisCat.length,
            itemBuilder: (context, index) => ProdTile(
                  product: Product(
                      store.thisCat[index].productId,
                      store.thisCat[index].name,
                      store.thisCat[index].images,
                      store.thisCat[index].brand,
                      store.thisCat[index].category,
                      store.thisCat[index].description,
                      store.thisCat[index].quantityPriceMap,
                      store.thisCat[index].stock,
                      store.thisCat[index].trending,
                      store.thisCat[index].priority),
                )),
      ))
    ]));
  }
}
