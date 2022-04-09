import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:luckyadmi/db/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:luckyadmi/model/productModel.dart';
import 'package:path_provider/path_provider.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key, this.productSelected, this.refresh}) : super(key: key);

  final Product productSelected;
  final Function refresh;
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductService _productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fadepriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  bool stock = true;
  bool trending = false;
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  // String _currentCategory = '';
  // String _currentBrand = '';
  var _selectedCategory;
  var _selectedBrand;
  // var image1;
  // var image2;
  // var image3;
  // var image;
  var productId = '';
  bool isLoading = false;
  List images = [];
  List imageList = [];
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    setProduct();
  }

  setProduct() async {
    if (widget.productSelected != null) {
      productId = widget.productSelected.productId ?? '';
      productNameController.text = widget.productSelected.name;
      quantityController.text =
          widget.productSelected.quantityPriceMap.keys.join(",");
      String prices = "";
      String fadePrices = "";
      widget.productSelected.quantityPriceMap.values.forEach((element) {
        prices = prices + "," + element[1].toString();
        fadePrices = fadePrices + "," + element[0].toString();
      });
      priceController.text = prices.substring(1);
      fadepriceController.text = fadePrices.substring(1);
      descriptionController.text = widget.productSelected.description;
      if (widget.productSelected.priority.toString() != "null") {
        priorityController.text = widget.productSelected.priority.toString();
      }
      _selectedCategory = widget.productSelected.category;
      _selectedBrand = widget.productSelected.brand;
      var count = 1;
      var externalDirectory = await getExternalStorageDirectory();
      externalDirectory.deleteSync(recursive: true);
      imageList = widget.productSelected.images;
      if (imageList != null) {
        imageList.forEach((element) async {
          var imagePath = await downloadFile(element, "${count++}");
          setState(() {
            images.add(File(imagePath));
          });
        });
      }
    }
  }

  Future<String> downloadFile(String url, String fileName) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      var externalDirectory = await getExternalStorageDirectory();
      myUrl = url + '/' + fileName;
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

  Future _selectedImage1() async {
    final pickedFile = await FilePicker.platform.pickFiles(allowMultiple: true);
    setState(() {
      if (pickedFile != null) {
        pickedFile.files.forEach((element) async {
          File compressedImage =
              await FlutterNativeImage.compressImage(element.path, quality: 50);
          images.add(compressedImage);
        });
      } else {
        print('No file selected');
      }
    });
  }

  // Future<File> compressFile(String fileUrl, String fileName) async {

  //   final outPath = fileUrl + "/" + fileName + ".jpg";

  //   var result = await FlutterImageCompress.compressAndGetFile(
  //       fileUrl, outPath,
  //       quality: 50);

  //   return result;
  // }

  // Future _selectedImage1() async {
  //   final pickedFile = await picker.pickMultiImage(imageQuality: 25);
  //   setState(() {
  //     if (pickedFile != null) {
  //       for(XFile file in pickedFile) {
  //         images.add(File(file.path));
  //         print(file.path);
  //       }
  //     } else {
  //       print('No file selected');
  //     }
  //   });
  // }

  // Widget _displayChild() {
  //   if (images.length == 0) {
  //     return Padding(
  //       padding: const EdgeInsets.fromLTRB(14, 30, 14, 30),
  //       child: Icon(
  //         Icons.add,
  //         color: Colors.grey,
  //       ),
  //     );
  //   } else {
  //     return addDisplayImage();
  //   }
  // }

  // Widget addDisplayImage() {
  //   return GridView.builder(
  //       gridDelegate:
  //           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
  //       itemCount: images.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Card(
  //             child: GridTile(
  //           child: Image.file(
  //             images[index],
  //             fit: BoxFit.cover,
  //             //filterQuality: FilterQuality.low,
  //           ),
  //         ));
  //       });
  // }

  Widget addDisplayImage() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return index == 0
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: OutlineButton(
                    onPressed: () => _selectedImage1(),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 2.5,
                    ),
                    child: Padding(
                      padding: images.length == 0
                          ? const EdgeInsets.fromLTRB(50, 14, 50, 14)
                          : const EdgeInsets.fromLTRB(14, 14, 14, 14),
                      child: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                    )),
              )
            : GestureDetector(
                onTap: () {
                  imageDialog(context, index - 1).then((value) => {
                        if (value == 1)
                          {
                            setState(() {
                              images.removeAt(index - 1);
                            })
                          }
                      });
                },
                child: Card(
                    child: GridTile(
                  child: Image.file(
                    images[index - 1],
                    fit: BoxFit.cover,
                    //filterQuality: FilterQuality.low,
                  ),
                )),
              );
      },
      itemCount: images.length + 1,
    );
  }

  Future<int> imageDialog(BuildContext context, int i) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context, 0);
                        }),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          Navigator.pop(context, 1);
                        })
                  ],
                ),
                Image.file(images[i]),
              ],
            ),
          );
        });
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
          productId == '' ? 'Add Product' : 'Update Product',
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
                  Container(
                    height: 150,
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: addDisplayImage()),
                  ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: OutlineButton(
                  //             onPressed: () => _selectedImage(1),
                  //             borderSide: BorderSide(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               width: 2.5,
                  //             ),
                  //             child: _displayChild1()),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: OutlineButton(
                  //           onPressed: () => _selectedImage(2),
                  //           borderSide: BorderSide(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             width: 2.5,
                  //           ),
                  //           child: Padding(
                  //               padding:
                  //                   const EdgeInsets.fromLTRB(14, 30, 14, 30),
                  //               child: _displayChild2()),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: OutlineButton(
                  //             onPressed: () => _selectedImage(3),
                  //             borderSide: BorderSide(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               width: 2.5,
                  //             ),
                  //             child: _displayChild3()),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 18, 25, 8),
                    child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(
                          hintText: 'Product Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Product Name cannot be empty';
                          } else
                            return '';
                        }),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false) {
                          return Text("Loading");
                        } else {
                          List<DropdownMenuItem<String>> categoryItems = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data.docs[i];
                            categoryItems.add(DropdownMenuItem(
                              child: Text(
                                snap.get('catName'),
                                style: TextStyle(color: Colors.red),
                              ),
                              value: "${snap.get('catName')}",
                            ));
                          }
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                            child: DropdownButton(
                              items: categoryItems,
                              onChanged: (categoryItem) {
                                setState(() {
                                  _selectedCategory = categoryItem;
                                });
                              },
                              value: _selectedCategory,
                              isExpanded: true,
                              hint: Text('Choose category'),
                            ),
                          );
                        }
                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('brands')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false) {
                          return Text("Loading");
                        } else {
                          List<DropdownMenuItem<String>> brandItems = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data.docs[i];
                            brandItems.add(DropdownMenuItem(
                              child: Text(
                                snap.get('brandName'),
                                style: TextStyle(color: Colors.red),
                              ),
                              value: "${snap.get('brandName')}",
                            ));
                          }
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                            child: DropdownButton(
                              items: brandItems,
                              onChanged: (brandItem) {
                                setState(() {
                                  _selectedBrand = brandItem;
                                });
                              },
                              value: _selectedBrand,
                              isExpanded: true,
                              hint: Text('Choose brand '),
                            ),
                          );
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: TextFormField(
                        controller: quantityController,
                        decoration: InputDecoration(
                          hintText: 'Quantity',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter quantity';
                          }
                          return "";
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Price',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter price';
                          }
                          return "";
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: TextFormField(
                      controller: fadepriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Faded Price',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(50, 18, 50, 8),
                      child: Row(
                        children: [
                          Text("Stock"),
                          Checkbox(
                              value: stock,
                              onChanged: (bool value) {
                                setState(() {
                                  stock = value;
                                });
                              }),
                          Spacer(),
                          Text("Trending"),
                          Checkbox(
                              value: trending,
                              onChanged: (bool value) {
                                setState(() {
                                  trending = value;
                                });
                              }),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: TextFormField(
                      controller: priorityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Priority',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 30, 25, 8),
                    child: Row(
                      children: [
                        FlatButton(
                          onPressed: () {
                            validateAndUpload();
                          },
                          child: Text(productId == ''
                              ? 'Add Product'
                              : 'Update Product'),
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                        Spacer(),
                        Container(
                          child: deleteWidget(),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  deleteProductWithImages() {
    for (var image in widget.productSelected.images) {
      _productService.deleteImage(image);
    }
    _productService.deleteProduct(widget.productSelected.productId);
  }

  deleteWidget() {
    if (productId != "") {
      return FlatButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          deleteProductWithImages();
          Fluttertoast.showToast(msg: 'Product deleted');
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

  // Future _selectedImage(int imageNumber) async {
  //   PickedFile pickedFile =
  //       (await picker.getImage(source: ImageSource.gallery));
  //   setState(() {
  //     if (pickedFile != null) {
  //       image = File(pickedFile.path);
  //     } else {
  //       print('');
  //     }
  //   });

  //   switch (imageNumber) {
  //     case 1:
  //       image1 = image;
  //       break;

  //     case 2:
  //       image2 = image;
  //       break;

  //     case 3:
  //       image3 = image;
  //       break;
  //   }
  // }

  // Widget _displayChild1() {
  //   if (image1 == null) {
  //     return Padding(
  //       padding: const EdgeInsets.fromLTRB(14, 30, 14, 30),
  //       child: Icon(
  //         Icons.add,
  //         color: Colors.grey,
  //       ),
  //     );
  //   } else {
  //     return Image.file(
  //       image1,
  //       fit: BoxFit.cover,
  //       width: double.infinity,
  //     );
  //   }
  // }

  // Widget _displayChild2() {
  //   if (image2 == null) {
  //     return Padding(
  //       padding: const EdgeInsets.fromLTRB(14, 30, 14, 30),
  //       child: Icon(
  //         Icons.add,
  //         color: Colors.grey,
  //       ),
  //     );
  //   } else {
  //     return Image.file(
  //       image2,
  //       fit: BoxFit.cover,
  //       width: double.infinity,
  //     );
  //   }
  // }

  // Widget _displayChild3() {
  //   if (image3 == null) {
  //     return Padding(
  //       padding: const EdgeInsets.fromLTRB(14, 30, 14, 30),
  //       child: Icon(
  //         Icons.add,
  //         color: Colors.grey,
  //       ),
  //     );
  //   } else {
  //     return Image.file(
  //       image3,
  //       fit: BoxFit.fill,
  //       width: double.infinity,
  //     );
  //   }
  // }

  void validateAndUpload() async {
    setState(() {
      isLoading = true;
    });
    // if (image1 != null && image2 != null && image3 != null) {
    //   String imageUrl1;
    //   String imageUrl2;
    //   String imageUrl3;

    //   final String picture1 =
    //       "1${productNameController.text}${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    //   UploadTask task1 = storage.ref().child(picture1).putFile(image1);

    //   final String picture2 =
    //       "2${productNameController.text}${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    //   UploadTask task2 = storage.ref().child(picture2).putFile(image2);

    //   final String picture3 =
    //       "3${productNameController.text}${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    //   UploadTask task3 = storage.ref().child(picture3).putFile(image3);

    //   TaskSnapshot snapshot1 = await task1.whenComplete(() {});
    //   TaskSnapshot snapshot2 = await task2.whenComplete(() {});

    //   TaskSnapshot snapshot3 = await task3.whenComplete(() {});
    //   imageUrl1 = await snapshot1.ref.getDownloadURL();
    //   imageUrl2 = await snapshot2.ref.getDownloadURL();
    //   imageUrl3 = await snapshot3.ref.getDownloadURL();
    //   List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];

    //   _productService.createProduct(
    //       _selectedBrand,
    //       _selectedCategory,
    //       productNameController.text,
    //       imageList,
    //       quantityController.text,
    //       priceController.text,
    //       descriptionController.text,
    //       stock,
    //       trending,
    //       fadepriceController.text,
    //       double.parse(priorityController.text));
    //   _formKey.currentState.reset();
    //   setState(() {
    //     isLoading = false;
    //     Navigator.pop(context);
    //   });
    //   Fluttertoast.showToast(msg: 'Product added');
    // }
    //

    if (images.length != 0) {
      print("entered");

      //print("Product " + widget.productSelected['productId']);
      if (productId != "") {
        deleteProductWithImages();
      }
      //else {
      print('after delete');
      String imageUrl;
      List<String> imageList = [];

      for (var i = 0; i < images.length; i++) {
        final String picture =
            "$i+${productNameController.text}${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        UploadTask task = storage.ref().child(picture).putFile(images[i]);
        TaskSnapshot snapshot = await task.whenComplete(() {});
        imageUrl = await snapshot.ref.getDownloadURL();
        imageList.add(imageUrl);
      }

      List<String> qtyArray = quantityController.text.split(",");
      List fadePriceArray = fadepriceController.text == "" ? List.filled(qtyArray.length, "0") : fadepriceController.text.split(",");
      List priceArray = priceController.text.split(",");
      Map<String, List<double>> qtyPriceMap = new Map<String, List<double>>();
      print(fadepriceController.text == "");
      // if (fadePriceArray == null) {
      //   fadePriceArray.fillRange(0, qtyArray.length - 1, "0");
      // }

      qtyArray.asMap().forEach((index, value) {
        qtyPriceMap[value] = [
          double.parse(fadePriceArray[index]),
          double.parse(priceArray[index])
        ];
      });

      _productService.createProduct(
          _selectedBrand,
          _selectedCategory,
          productNameController.text,
          imageList,
          descriptionController.text,
          stock,
          trending,
          qtyPriceMap,
          double.parse(priorityController.text));

      _formKey.currentState.reset();
      setState(() {
        isLoading = false;
        if (productId != "") {
          widget.refresh();
        }
        Navigator.pop(context);
      });
      Fluttertoast.showToast(
          msg: productId == '' ? 'Product added' : 'Product updated');
      //}
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Add atleast 1 image");
    }
  }
}
