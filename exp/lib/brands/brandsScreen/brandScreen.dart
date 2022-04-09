import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/components/appBar.dart';
import 'package:lucky/components/drawer.dart';
import 'package:lucky/components/search.dart';
import 'package:lucky/brands/brandServices.dart';
import 'package:lucky/components/smallCard.dart';
import '../../detailsScreen/detailsScreen.dart';
import '../../categories/catScreen/prodInCat/prodInCat.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({
    Key key,
  }) : super(key: key);

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
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
    return Scaffold(
        drawer: buildDrawer(context),
        body: CustomScrollView(slivers: [
          MyAppBar(
            name: "Brands",
          ),
          SliverPinnedHeader(
            child: SearchWidget(),
          ),
          SliverToBoxAdapter(
              child: Container(
                  height: size.height * 0.8,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: brandList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.75),
                    itemBuilder: (context, index) => SmallCard(
                        name: brandList[index]['brandName'],
                        image: brandList[index]['image'],
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProdInCat(
                                      category: brandList[index]['brandName'],
                                    )))),
                  )))
        ]));
  }
}
