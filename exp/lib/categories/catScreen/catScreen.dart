import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/components/appBar.dart';
import 'package:lucky/components/drawer.dart';
import 'package:lucky/components/search.dart';
import '../../detailsScreen/detailsScreen.dart';
import 'prodInCat/prodInCat.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../components/smallCard.dart';
import '../../categories/catServices.dart';

class CatScreen extends StatefulWidget {
  
  const CatScreen({
    Key key,
  }) : super(key: key);

  @override
  _CatScreenState createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  List categoryList = [];
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await CategoryServices().getCategories();
    if (resultant == null) {
      print("unable to retrieve");
    } else {
      setState(() {
        categoryList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomScrollView(slivers: [
          MyAppBar(
            name: "Categories",
          ),
          SliverPinnedHeader(
            child: SearchWidget(),
          ),
          SliverToBoxAdapter(
              child: Container(
                  height: size.height * 0.8,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: categoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.75),
                    itemBuilder: (context, index) => SmallCard(
                        name: categoryList[index]['catName'],
                        image: categoryList[index]['image'],
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProdInCat(
                                    category: categoryList[index]
                                        ['catName'],)))),
                  )))
        ]));
  }
}
