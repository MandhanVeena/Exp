import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/orderHistory/orderHistory.dart';
import 'package:lucky/services/phoneAuthService.dart';
import 'package:provider/provider.dart';
import '../users/auth_service.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
            accountName: Text('Name'),
            accountEmail: Text('Email'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, color: Colors.white)),
            ),
            decoration: BoxDecoration(color: themeColor)),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home, color: themeColor),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('My Account'),
            leading: Icon(Icons.person, color: themeColor),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistory()));
          },
          child: ListTile(
            title: Text('My Orders'),
            leading: Icon(Icons.shopping_basket, color: themeColor),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Categories'),
            leading: Icon(Icons.dashboard, color: themeColor),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Favourites'),
            leading: Icon(Icons.favorite, color: themeColor),
          ),
        ),
        Divider(),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('About'),
            leading: Icon(
              Icons.help,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            //user.signOut();
            //Navigator.pop(context);
            //Navigator.pushReplacement(context,
            //MaterialPageRoute(builder: (context) => new Login()));
            context.read<PhoneAuthService>().signOut();
          },
          child: ListTile(
            title: Text('Log out'),
            leading: Icon(Icons.transit_enterexit),
          ),
        ),
      ],
    ),
  );
}
