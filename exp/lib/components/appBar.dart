import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import '../cartScreen/cartScreen.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      floating: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              //Navigator.of(context).push(
              //MaterialPageRoute(builder: (context) => new Favorites()));
            }),
        IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => new CartScreen()));
            })
      ],
      elevation: 0,
    );
  }
}
