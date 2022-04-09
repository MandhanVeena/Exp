import 'package:flutter/material.dart';
import 'package:luckyadmi/db/product.dart';
//import 'package:luckyadmi/db/product.dart';
import 'package:luckyadmi/model/productModel.dart';
import 'package:luckyadmi/model/productStore.dart';
//import 'package:luckyadmi/model/productStore.dart';
import 'package:luckyadmi/screens/manage/product/add.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close),
            color: Colors.black,
          ),
          title: Text(
            "Product List",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListPage());
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Product> productList = [];
  List<Product> displayedProducts = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    productList = await fetchDatabaseList();
    setState(() {
      displayedProducts = productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return index == 0 ? _searchBar() : _listItem(index - 1);
      },
      itemCount: displayedProducts.length + 1,
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            displayedProducts = productList.where((product) {
              var name = product.name.toString().toLowerCase();
              return name.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return GestureDetector(
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                displayedProducts[index].name,
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
      onDoubleTap: () {
        Product product = displayedProducts[index];
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddProduct(productSelected: product, refresh: refresh);
        }));
      },
    );
  }

  refresh() {
    fetchData();
  }
}
