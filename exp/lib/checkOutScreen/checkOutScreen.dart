import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lucky/checkOutScreen/addressModel.dart';
import 'package:lucky/checkOutScreen/addressService.dart';
import 'package:lucky/checkOutScreen/orderScreen.dart';
import 'package:lucky/users/auth_service.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/users/userModel.dart';
import 'package:lucky/users/userService.dart';
import 'package:package_info/package_info.dart';
import '../products/productModel.dart';
import '../trash/addressScreen.dart';
import '../cartScreen/cartStore.dart';
import 'orderService.dart';
import '../checkOutScreen/orderModel.dart';
import '../users/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../constants/Utilities.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key key, this.firebaseUser}) : super(key: key);

  final User firebaseUser;

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  AddressService addressService = AddressService();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final List<AddressModel> addressList = [];

  String addressId = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setDetails();
  }

  setDetails() async {
    if (widget.firebaseUser != null) {
      UserModel userModel =
          await UserHelper.getUserById(widget.firebaseUser.uid);

      if (userModel != null) {
        nameController.text = userModel.username;

        print("Addressidslist" + userModel.addressIdsList.toString());
        if (userModel.addressIdsList != null) {
          userModel.addressIdsList.forEach((element) async {
            AddressModel addressModel =
                await addressService.getAddressById(element);
            setState(() {
              addressList.add(addressModel);
            });
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Check Out",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
                child: ListTile(
              title: Text("Total  "),
              subtitle: Text(
                "\u{20B9}" +
                    (store.carts != [] ? store.getBasketTotal().toString() : 0),
                style:
                    TextStyle(color: themeColor, fontWeight: FontWeight.bold),
              ),
            )),
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.only(right: 10),
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    createAddress();
                    await createUser(widget.firebaseUser).then((value) async {
                      UserModel userModel =
                          await UserHelper.getUserById(widget.firebaseUser.uid);
                      AddressModel addressModel = await addressService.getAddressById(addressId);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                    userModel: userModel,
                                    addressModel: addressModel,
                                  )));
                    });
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
                color: themeColor,
              ),
            )
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(accentColor: themeColor),
                    child: ExpansionTile(
                      title: Text(
                        "Order summary",
                        style: TextStyle(color: themeColor),
                      ),
                      children: [
                        Container(
                          height: size.height / 2.5,
                          child: ListView.builder(
                            itemCount: store.carts.length,
                            itemBuilder: (context, index) {
                              Cart cart = store.carts[index];

                              return Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        (8),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 10,
                                            color:
                                                Colors.grey.withOpacity(0.23))
                                      ]),
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Image.network(
                                        cart.product.images[0],
                                        fit: BoxFit.contain,
                                        width: size.height * 0.12,
                                        height: size.height * 0.15,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width * 0.35,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                7, 15, 0, 0),
                                            child: Text(
                                              cart.product.name,
                                              style: TextStyle(
                                                fontSize: 17.5,
                                                letterSpacing: -0.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      12, 0, 0, 0),
                                              child: Text(
                                                "\u{20B9} " +
                                                    //getQuantityPrice(cart.qty, cart.product.quantityPriceMap, QuantityPriceType.price),
                                                    cart
                                                        .product
                                                        .quantityPriceMap[
                                                            cart.qty]
                                                        .last
                                                        .toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: themeColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 0, 0),
                                              child: isFadePriceEmpty(cart
                                                          .product
                                                          .quantityPriceMap[
                                                      cart.qty])
                                                  // cart.product.quantityPriceMap[cart.qty].last ==
                                                  //         0
                                                  ? Text(' ')
                                                  : Text(
                                                      "\u{20B9} " +
                                                          //getQuantityPrice(cart.qty, cart.product.quantityPriceMap, QuantityPriceType.fadeprice),
                                                          cart
                                                              .product
                                                              .quantityPriceMap[
                                                                  cart.qty]
                                                              .first
                                                              .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 16),
                                                    ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 10),
                                            height: 25,
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(cart.qty)
                                            // DropdownButton<String>(
                                            //     underline: SizedBox(),
                                            //     hint: Text(cart.qty),
                                            //     onChanged: (newValue) {
                                            //       //cart.qty = newValue;
                                            //       setState(() {
                                            //         cart.qty = newValue;
                                            //         // store.setActive(
                                            //         //       cart.product, cart.qty);
                                            //       });
                                            //     },
                                            //     value: cart.qty,
                                            //     items: cart.product.quantityPriceMap.keys
                                            //         .map((e) =>
                                            //             DropdownMenuItem<String>(
                                            //               child: Text(
                                            //                 e,
                                            //                 style: TextStyle(
                                            //                     fontSize: 12),
                                            //               ),
                                            //               value: e,
                                            //             ))
                                            //         .toList()),
                                            ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          //height: size.height * 0.15,

                                          margin: EdgeInsets.only(
                                              bottom: 10, right: 20),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 2),
                                          // decoration: BoxDecoration(
                                          //     border: Border.all(
                                          //         color: themeColor, width: 1),
                                          //     borderRadius:
                                          //         BorderRadius.circular(10)),
                                          child: Text(
                                              "x " + cart.number.toString()),
                                        )
                                        // Container(
                                        //   height: size.height * 0.15,
                                        //   child:
                                        //   Column(
                                        //     mainAxisAlignment: MainAxisAlignment.end,
                                        //     children: [
                                        //       Container(
                                        //         margin: EdgeInsets.only(
                                        //             bottom: 10, right: 20),
                                        //         padding: EdgeInsets.symmetric(
                                        //             vertical: 2, horizontal: 2),
                                        //         decoration: BoxDecoration(
                                        //             border: Border.all(
                                        //                 color: themeColor, width: 1),
                                        //             borderRadius:
                                        //                 BorderRadius.circular(10)),
                                        //         child: Row(children: [
                                        //           InkWell(
                                        //             onTap: () {
                                        //               setState(() {
                                        //                 store.setActive(
                                        //                     cart.product, cart.qty);
                                        //                 store.removeFromBasket(
                                        //                     store.activeProduct);
                                        //               });
                                        //             },
                                        //             child: Icon(
                                        //               Icons.remove,
                                        //               size: 30,
                                        //               color: Colors.grey.shade600,
                                        //             ),
                                        //           ),
                                        //           Padding(
                                        //             padding:
                                        //                 const EdgeInsets.symmetric(
                                        //                     horizontal: 8),
                                        //             child: Text(
                                        //               cart.number.toString(),
                                        //               style: TextStyle(fontSize: 13),
                                        //             ),
                                        //           ),
                                        //           InkWell(
                                        //             onTap: () {
                                        //               setState(() {
                                        //                 store.setActive(
                                        //                     cart.product, cart.qty);
                                        //                 store.addToBasket(
                                        //                     store.activeProduct);
                                        //               });
                                        //             },
                                        //             child: Icon(
                                        //               Icons.add,
                                        //               size: 30,
                                        //               color: Colors.grey.shade600,
                                        //             ),
                                        //           ),
                                        //         ]),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ]));
                            },
                          ),
                          // Spacer(),
                          // Container(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     style: ButtonStyle(
                          //         backgroundColor:
                          //             MaterialStateProperty.all(themeColor)),
                          //     onPressed: () {
                          //       if (formKey.currentState.validate()) {
                          //         createOrder();
                          //       }
                          //     },
                          //     child: Text("Place Order"),
                          //   ),
                          // ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      Divider(
                        color: themeColor,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "Name",
                          ),
                          controller: nameController,
                          validator: (value) {
                            if (nameController.text == "") {
                              return "Name is required";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 8,
                      ),
                      TypeAheadFormField(
                        suggestionsCallback: (pattern) => addressList.where(
                            (element) => element.fullAddress
                                .toLowerCase()
                                .contains(pattern.toLowerCase())),
                        itemBuilder: (_, AddressModel item) => ListTile(
                          title: Text(item.fullAddress),
                        ),
                        onSuggestionSelected: (AddressModel val) {
                          addressId = val.addressId;
                          addressController.text = val.fullAddress;
                          landmarkController.text = val.landmark;
                          cityController.text = val.city;
                        },
                        getImmediateSuggestions: true,
                        hideSuggestionsOnKeyboardHide: false,
                        hideOnEmpty: true,
                        textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(labelText: "Address"),
                            controller: addressController),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Landmark",
                        ),
                        controller: landmarkController,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "City",
                          ),
                          controller: cityController,
                          validator: (value) {
                            if (cityController.text == "") {
                              return "City is required";
                            }
                            return null;
                          }),
                    ]),
                  )
                ],
              ),
      ),
    );
  }

  createAddress() {
    if (addressId == "") {
      var id = Uuid();
      addressId = id.v1();
    }
    addressService.createAddress(AddressModel(addressId, addressController.text,
        landmarkController.text, cityController.text));
  }

  Future createUser(User firebaseUser) async {
    isLoading = true;
    List<String> addressIdsList = [];

    for (AddressModel address in addressList) {
      addressIdsList.add(address.addressId);
    }

    if (!addressIdsList.contains(addressId)) {
      addressIdsList.add(addressId);
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    UserHelper.saveUser(UserModel(
        firebaseUser.uid,
        nameController.text,
        firebaseUser.phoneNumber,
        "user",
        addressIdsList,
        firebaseUser.metadata.lastSignInTime.microsecondsSinceEpoch,
        firebaseUser.metadata.creationTime.millisecondsSinceEpoch,
        buildNumber));
    formKey.currentState.reset();
    setState(() {
      isLoading = false;
    });
  }

}

class AuthenticationWrapper extends StatelessWidget {
  //final List<Cart> cartList;

  //const AuthenticationWrapper({Key key, this.cartList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<User>(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData && snapshot.data != null) {
    //         return CheckOutScreen();
    //       } else {
    //         return SignInPage();
    //       }
    //     });

    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      //UserHelper.saveUser(firebaseUser);
      return CheckOutScreen(
        firebaseUser: firebaseUser,
      );
    } else {
      return LoginScreen();
    }
  }
}
