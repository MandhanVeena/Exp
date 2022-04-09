import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lucky/cartScreen/cartStore.dart';
import 'package:lucky/checkOutScreen/addressModel.dart';
import 'package:lucky/checkOutScreen/addressService.dart';
import 'package:lucky/constants/Utilities.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/products/productModel.dart';
import 'package:lucky/users/userModel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'orderModel.dart';
import 'orderService.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key, this.userModel, this.addressModel}) : super(key: key);

  final UserModel userModel;
  final AddressModel addressModel;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isUrgent = false;

  List<String> paymentOptions = ["Cash on Delivery"];
  String selectedPaymentOption = "";

  TextEditingController contactNumberController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedPaymentOption = paymentOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Confirm Details",
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
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    createOrder(store, widget.userModel);
                  }
                },
                child: Text(
                  "Place Order",
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
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
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
                                                      cart
                                                          .product
                                                          .quantityPriceMap[
                                                              cart.qty]
                                                          .last
                                                          .toString(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: themeColor,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    ? Text(' ')
                                                    : Text(
                                                        "\u{20B9} " +
                                                            cart
                                                                .product
                                                                .quantityPriceMap[
                                                                    cart.qty]
                                                                .first
                                                                .toString(),
                                                        textAlign:
                                                            TextAlign.left,
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
                                              child: Text(cart.qty)),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 10, right: 20),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 2),
                                            child: Text(
                                                "x " + cart.number.toString()),
                                          )
                                        ],
                                      ),
                                    ]));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: themeColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(flex: 2, child: Text("Name :")),
                    //     Expanded(
                    //       flex: 5,
                    //       child: Container(
                    //         child: Text(
                    //           "Veena mANDHAN is my name aND I am a uhu uhuVeena mANDHAN is my name aND I am a uhu uhuVeena mANDHAN is my name aND I am a uhu uhuVeena mANDHAN is my name aND I am a uhu uhuVeena mANDHAN is my name aND I am a uhu uhu",
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20,),
                    // Row(
                    //   children: [
                    //     Expanded(flex: 2, child: Text("Address :")),
                    //     Expanded(
                    //       flex: 5,
                    //       child: Container(
                    //         child: Text(
                    //           "Veena mANDHAN is my name aND I am a uhu uhuVeena mANDHAN is my name aND I am a uhu uhuVeena mANDHAN is my name aND I am a uhu uhuVeena mANDHAN is my name aND I am a uhu uhuVeena mANDHAN is my name aND I am a uhu uhu",
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20,),
                    // Row(
                    //   children: [
                    //     Expanded(flex: 2, child: Text("Phone Number :")),
                    //     Expanded(
                    //       flex: 5,
                    //       child: Container(
                    //         child: TextField()
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20,),
                    // Row(
                    //   children: [
                    //     Expanded(flex: 2, child: Text("Comment :")),
                    //     Expanded(
                    //       flex: 5,
                    //       child: Container(
                    //         child: TextField()
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //SizedBox(height: 50,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Delivery Info",
                              style:
                                  TextStyle(fontSize: 17, color: themeColor)),
                        ),
                      ],
                    ),
                    Text(
                      "Name :",
                      style: TextStyle(fontSize: 14, color: themeColor),
                    ),

                    Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        width: double.infinity,
                        child: Text(
                          widget.userModel.username,
                          style: TextStyle(fontSize: 16),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Address :",
                      style: TextStyle(fontSize: 14, color: themeColor),
                    ),

                    Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        width: double.infinity,
                        child: Text(
                            "${widget.addressModel.fullAddress}, near ${widget.addressModel.landmark}, ${widget.addressModel.city}",
                            style:
                                TextStyle(fontSize: 15, letterSpacing: -0.2))),

                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                        ),
                        keyboardType: TextInputType.number,
                        controller: contactNumberController,
                        validator: (value) {
                          if (value == "") {
                            return "Phone number is required";
                          } else if (value.length != 10) {
                            return "Invalid Phone Number";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Comment",
                        hintText: "Wrap the product and write Veena on it",
                      ),
                      controller: commentController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text("Mark Urgent   "),
                        Checkbox(
                            activeColor: themeColor,
                            value: isUrgent,
                            onChanged: (bool value) {
                              setState(() {
                                isUrgent = value;
                              });
                            }),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Payment Options",
                              style:
                                  TextStyle(fontSize: 17, color: themeColor)),
                        ),
                      ],
                    ),

                    Container(
                      height: 50,
                      child: ListView.builder(
                          itemCount: paymentOptions.length,
                          itemBuilder: (context, index) => ListTile(
                                title: Text(
                                  paymentOptions[index],
                                  style: TextStyle(fontSize: 15),
                                ),
                                trailing: Radio(
                                  activeColor: themeColor,
                                  value: paymentOptions[index],
                                  groupValue: selectedPaymentOption,
                                  onChanged: (value) {
                                    selectedPaymentOption = value;
                                  },
                                ),
                              )),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  createOrder(MyStore store, UserModel user) async {
    isLoading = true;

    var id = Uuid();
    String orderId = id.v1();

    List<FinalCart> finalCartList = [];

    store.carts.forEach((element) {
      finalCartList.add(
          FinalCart(element.product.productId, element.number, element.qty));
    });

    OrderService orderService = OrderService();

    String orderResult = await orderService.createOrder(OrderModel(
        orderId,
        user.userId,
        widget.addressModel.addressId,
        contactNumberController.text,
        commentController.text,
        DateTime.now().millisecondsSinceEpoch.toString(),
        store.getBasketTotal(),
        store.getBasketTotal(),
        0,
        0,
        selectedPaymentOption,
        isUrgent,
        finalCartList,
        0,
        DateTime.now().millisecondsSinceEpoch));

    setState(() {
      isLoading = false;

      if (orderResult == "Order Successful") {
        formKey.currentState.reset();
        store.carts = [];
        Navigator.pop(context);
      }
    });
    print("successful");
    Fluttertoast.showToast(msg: orderResult);
  }
}
