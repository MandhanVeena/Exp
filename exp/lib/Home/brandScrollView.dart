import 'package:flutter/material.dart';
import 'package:lucky/categories/caregoryModel.dart';
import 'package:lucky/brands/brandServices.dart';
import '../cartScreen/cartStore.dart';
import 'package:lucky/categories/catServices.dart';
import 'package:lucky/components/smallCard.dart';
import '../categories/catScreen/prodInCat/prodInCat.dart';
import 'package:provider/provider.dart';


class BrandScrollView extends StatefulWidget {
  BrandScrollView({Key key}) : super(key: key);

  @override
  _BrandScrollViewState createState() => _BrandScrollViewState();
}

class _BrandScrollViewState extends State<BrandScrollView> {
  List brandList = [];
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await BrandServices().getBrands();
    if (resultant == null) {
      print("unable to retrieve");
    } else {
      setState(() {
        brandList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var store = Provider.of<MyStore>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      height: size.height * 0.4,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brandList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 0),
          itemBuilder: (context, index) {
            return SmallCard(
              image: brandList[index]['image'],
              press: (){ 
                store.fetchByCategory(brandList[index]['brandName']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProdInCat(category: brandList[index]['brandName'], )));},
              name: brandList[index]['brandName'],
            );
          }),
    );
  }
}
