import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/categories/caregoryModel.dart';
import '../products/productModel.dart';
import '../Home/brandScrollView.dart';
import 'package:lucky/components/search.dart';
import '../Home/trendingScrollView.dart';
import '../Home/categoryScrollView.dart';
import '../brands/brandsScreen/brandScreen.dart';
import '../categories/catScreen/catScreen.dart';
import 'package:lucky/categories/catServices.dart';
import '../products/trendingScreen.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../components/appBar.dart';
import 'titleMore.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(slivers: [
      MyAppBar(
        name: appName,
      ),
      SliverPinnedHeader(
        child: SearchWidget(),
      ),
      SliverToBoxAdapter(
        child: Column(
          children: [
            TitleMoreWidget(
                title: "Categories",
                press: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CatScreen()));
                }),
            CategoryScrollView(),
            TitleMoreWidget(
                title: 'Trending',
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TrendingScreen()));
                }),
            TrendingScrollView(),
            TitleMoreWidget(
                title: 'Brands',
                press: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BrandScreen()));
                }),
            BrandScrollView(),
          ],
        ),
      ),
    ]);
  }
}
