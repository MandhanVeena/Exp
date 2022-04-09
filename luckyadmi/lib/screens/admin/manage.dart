import 'package:flutter/material.dart';
import 'package:luckyadmi/model/productModel.dart';
import 'package:luckyadmi/model/productStore.dart';
import 'package:luckyadmi/screens/manage/brand/add.dart';
import 'package:luckyadmi/screens/manage/category/add.dart';
import 'package:luckyadmi/screens/manage/category/list.dart';
import 'package:luckyadmi/screens/manage/product/add.dart';
import 'package:luckyadmi/screens/manage/product/list.dart';
import 'package:luckyadmi/screens/manage/users/usersList.dart';
import 'package:provider/provider.dart';

class Manage extends StatelessWidget {
  const Manage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ManageTile(
            listname: "Product",
            icon: Icons.change_history,
            widget1: AddProduct(),
            widget2: ProductList()),
        Divider(),
        ManageTile(
            listname: "Category",
            icon: Icons.category,
            widget1: AddCategory(),
            widget2: CategoryList()),
        Divider(),
        ManageTile(
            listname: "Brand",
            icon: Icons.library_books,
            widget1: AddBrand(),
            widget2: AddBrand()),
        Divider(),
        ListTile(
          leading: Icon(Icons.people),
          title: Text("Users List"),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UsersList()),
          ),
        ),
        Divider()
        /*ManageTile(
            listname: "Banner",
            icon: Icons.image,
            widget1: AddProduct(),
            widget2: AddProduct()),
        Divider(),
        ManageTile(
            listname: "Notification",
            icon: Icons.notifications,
            widget1: AddProduct(),
            widget2: AddProduct()),
        Divider(),*/
      ],
    );
  }
}

class ManageTile extends StatelessWidget {
  const ManageTile({
    Key key,
    @required this.listname,
    @required this.widget1,
    @required this.icon,
    @required this.widget2,
  }) : super(key: key);

  final String listname;
  final Widget widget1;
  final Widget widget2;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(listname),
      children: [
        ListTile(
          leading: Icon(Icons.add),
          contentPadding: EdgeInsets.only(left: 50),
          title: Text('Add ' + listname),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => widget1),
          ),
        ),
        ListTile(
          leading: Icon(Icons.list),
          contentPadding: EdgeInsets.only(left: 50),
          title: Text(listname + ' List'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget2),
          ),
        )
      ],
    );
  }
}
