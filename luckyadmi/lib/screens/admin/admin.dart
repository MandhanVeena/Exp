import 'package:flutter/material.dart';
import 'package:luckyadmi/db/brand.dart';
import 'package:luckyadmi/db/category.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dashboard.dart';
import 'manage.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.orange;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: FlatButton.icon(
              onPressed: () {
                setState(() {
                  _selectedPage = Page.dashboard;
                });
              },
              icon: Icon(
                Icons.dashboard,
                color: _selectedPage == Page.dashboard ? active : notActive,
              ),
              label: Text('Dashboard'),
            )),
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedPage = Page.manage;
                      });
                    },
                    icon: Icon(Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive),
                    label: Text('Manage')))
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: _loadScreen(),
    );
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Dashboard(active: active);
        break;
      case Page.manage:
        return Manage();
        break;

      default:
        return Container();
    }
  }

  

  /*void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Brand cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: "Add Brand"),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
        FlatButton(
            onPressed: () {
              if (brandController.text != null) {
                _brandService.createBrand();
              }
              Fluttertoast.showToast(msg: "Brand Added");
              Navigator.pop(context);
            },
            child: Text('ADD')),
      ],
    );
    showDialog(
      context: context,
      builder: (_) => alert,
    );
  }*/
}
