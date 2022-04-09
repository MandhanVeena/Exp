import 'package:flutter/material.dart';
import 'package:lucky/categories/caregoryModel.dart';
import '../cartScreen/cartStore.dart';
import 'package:lucky/categories/catServices.dart';
import 'package:lucky/components/smallCard.dart';
import '../categories/catScreen/prodInCat/prodInCat.dart';
import 'package:provider/provider.dart';

class CategoryScrollView extends StatefulWidget {
  CategoryScrollView({Key key}) : super(key: key);

  @override
  _CategoryScrollViewState createState() => _CategoryScrollViewState();
}

class _CategoryScrollViewState extends State<CategoryScrollView> {
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
    var store = Provider.of<MyStore>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      height: size.height * 0.4,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 0),
          itemBuilder: (context, index) {
            return SmallCard(
              image: categoryList[index]['image'],
              press: () {
                store.fetchByCategory(categoryList[index]['catName']);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProdInCat(
                              category: categoryList[index]['catName'],
                            )));
              },
              name: categoryList[index]['catName'],
            );
          }),
    );
  }
}
