import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import '../cartScreen/cartStore.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var store = Provider.of<MyStore>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 0),
      height: size.height * 0.072,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.072 - 30,
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 8,
                          color: themeColor.withOpacity(0.23),
                        )
                      ]),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        String str = searchController.text;
                        for (var product in store.products) {
                          if (product.name == str) print("");
                        }
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Icon(Icons.search_rounded,
                            color: themeColor.withOpacity(0.5))),
                  ))),
        ],
      ),
    );
  }
}
