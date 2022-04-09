import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List usersList = [];
  List displayedUsers = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    List users = [];
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .get()
          .then((value) => value.docs.forEach((element) {
                users.add(element.data());
              }));
      setState(() {
        usersList = users;
        displayedUsers = users;
      });
    } catch (e) {
      print(e.toString());
    }
  }

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
            "Users List",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.builder(
      itemBuilder: (context, index) {
        return index == 0 ? _searchBar() : _listItem(index - 1);
      },
      itemCount: displayedUsers.length + 1,
    )
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
            displayedUsers = usersList.where((user) {
              var name = user["email"].toString().toLowerCase();
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
                displayedUsers[index]["email"],
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
