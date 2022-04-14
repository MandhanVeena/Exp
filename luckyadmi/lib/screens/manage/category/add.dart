import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:luckyadmi/db/category.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:luckyadmi/model/categoryModel.dart';
import 'package:path_provider/path_provider.dart';

class AddCategory extends StatefulWidget {
  final CategoryModel categorySelected;
  final Function refresh;

  const AddCategory({Key key, this.categorySelected, this.refresh})
      : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  CategoryService _categoryService = CategoryService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  // List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  // List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  // List<DropdownMenuItem<String>> categoriesDropDown =
  //     <DropdownMenuItem<String>>[];
  // List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  // String _currentCategory = '';
  // String _currentBrand = '';
  var categoryId = "";
  File image;
  bool isLoading = false;

  ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    setCategory();
  }

  setCategory() async {
    if (widget.categorySelected != null) {
      categoryId = widget.categorySelected.catId ?? '';
      categoryNameController.text = widget.categorySelected.catName;

      if (widget.categorySelected.priority.toString() != "null") {
        priorityController.text = widget.categorySelected.priority.toString();
      }
      var externalDirectory = await getExternalStorageDirectory();
      externalDirectory.deleteSync(recursive: true);
      print(widget.categorySelected.image);
      var imagePath = await downloadFile(widget.categorySelected.image);
      setState(() {
        image = File(imagePath);
      });
    }
  }

  Future<String> downloadFile(String url) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';

    try {
      var externalDirectory = await getExternalStorageDirectory();
      var myUrl = url + "/category";
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = externalDirectory.path +
            '/${url.substring(url.lastIndexOf("=") + 1)}';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url' + ex;
    }
    print(filePath);

    return filePath;
  }

  Future _selectedImage() async {
    final pickedFile =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (pickedFile != null) {
      File compressedImage = await FlutterNativeImage.compressImage(
          pickedFile.files.single.path,
          quality: 50);

      setState(() {
        image = compressedImage;
      });
    } else {
      print("");
    }
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
          categoryId == '' ? 'Add Category' : 'Update Category',
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
                        controller: categoryNameController,
                        decoration: InputDecoration(
                          hintText: 'Category Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Category Name cannot be empty';
                          } else if (value.length > 10) {
                            return 'Too long Category name';
                          } else
                            return null;
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
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20, 150, 8),
                    child: FlatButton(
                      onPressed: () {
                        validateAndUpload();
                      },
                      child: Text('Add Category'),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  deleteCategoryWithImage() {
    _categoryService.deleteImage(widget.categorySelected.image);
    _categoryService.deleteCategory(widget.categorySelected.catId);
  }

  deleteWidget() {
    if (categoryId != "") {
      return FlatButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          deleteCategoryWithImage();
          Fluttertoast.showToast(msg: 'Category deleted');
          _formKey.currentState.reset();
          setState(() {
            isLoading = false;
            widget.refresh();
            Navigator.pop(context);
          });
        },
        child: Text('Delete'),
        color: Colors.grey.withOpacity(0.3),
        textColor: Colors.black,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate() && image != null) {
      setState(() {
        isLoading = true;
      });

      if (image != null) {
        if (categoryId != "") {
          deleteCategoryWithImage();
        }

        String imageUrl;
        final String picture =
            "${categoryNameController.text}${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        UploadTask task = storage.ref().child(picture).putFile(image);

        if (task != null) {
          final snapshot = await task.whenComplete(() {});
          imageUrl = await snapshot.ref.getDownloadURL();
        }

        _categoryService.createCategory(categoryNameController.text, imageUrl,
            double.parse(priorityController.text));

        _formKey.currentState.reset();
        setState(() {
          isLoading = false;
          //widget.refresh();

          if (categoryId != "") {
            widget.refresh();
          }
          Navigator.pop(context);
        });
        Fluttertoast.showToast(
            msg: categoryId == '' ? 'Category added' : 'Category updated');
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Add atleast 1 image");
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
