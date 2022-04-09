import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:luckyadmi/db/brand.dart';
import 'package:luckyadmi/db/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddBrand extends StatefulWidget {
  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
 
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentBrand = '';

  var image;
  bool isLoading = false;

  ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

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
          "Add Brand",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                        onPressed: () => _selectedImage(),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 2.5,
                        ),
                        child: _displayChild()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextFormField(
                        controller: brandNameController,
                        decoration: InputDecoration(
                          hintText: 'Brand Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Brand Name cannot be empty';
                          } else if (value.length > 10) {
                            return 'Too long Brand name';
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextFormField(
                        controller: priorityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Priority',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter priority';
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20, 150, 8),
                    child: FlatButton(
                      onPressed: () {
                        validateAndUpload();
                      },
                      child: Text('Add Brand'),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate() && image != null) {
      setState(() {
        isLoading = true;
      });

      String imageUrl;

      final String picture =
          "${brandNameController.text}${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";

      UploadTask task = storage.ref().child(picture).putFile(image);

      if (task != null) {
        final snapshot = await task.whenComplete(() {});
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      _brandService.createBrand(brandNameController.text, imageUrl,
          double.parse(priorityController.text));
      _formKey.currentState.reset();
      setState(() {
        isLoading = false;
        Navigator.pop(context);
      });
      Fluttertoast.showToast(msg: 'Brand added');
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _selectedImage() async {
    final pickedFile =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.files.single.path);
      } else {
        print('');
      }
    });
  }

  Widget _displayChild() {
    if (image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 30, 14, 30),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
  }
}
