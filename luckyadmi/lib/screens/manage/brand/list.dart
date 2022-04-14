import 'package:flutter/material.dart';
import 'package:luckyadmi/model/brandModel.dart';
import 'package:luckyadmi/screens/manage/brand/add.dart';

class BrandList extends StatefulWidget {
  @override
  BrandListState createState() => BrandListState();
}

class BrandListState extends State<BrandList> {
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
            "Brand List",
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
  List<BrandModel> brandList = [];
  List<BrandModel> displayedCategories = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    brandList = await fetchBrandList();
    setState(() {
      displayedCategories = brandList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return index == 0 ? _searchBar() : _listItem(index - 1);
      },
      itemCount: displayedCategories.length + 1,
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
            displayedCategories = brandList.where((brand) {
              var name = brand.catName.toString().toLowerCase();
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
                displayedCategories[index].catName,
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
      onDoubleTap: () {
        BrandModel brand = displayedCategories[index];
        print(brand);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddBrand(brandSelected: brand, refresh: refresh);
        }));
      },
    );
  }

  refresh() {
    fetchData();
  }
}
