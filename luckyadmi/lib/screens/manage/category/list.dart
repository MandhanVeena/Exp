import 'package:flutter/material.dart';
import 'package:luckyadmi/model/categoryModel.dart';
import 'package:luckyadmi/screens/manage/category/add.dart';

class CategoryList extends StatefulWidget {
  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
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
            "Category List",
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
  List<CategoryModel> categoryList = [];
  List<CategoryModel> displayedCategories = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    categoryList = await fetchCategoryList();
    setState(() {
      displayedCategories = categoryList;
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
            displayedCategories = categoryList.where((category) {
              var name = category.catName.toString().toLowerCase();
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
        CategoryModel category = displayedCategories[index];
        print(category);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddCategory(categorySelected: category, refresh: refresh);
        }));
      },
    );
  }

  refresh() {
    fetchData();
  }
}
