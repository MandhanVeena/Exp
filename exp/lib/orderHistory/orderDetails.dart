import 'package:flutter/material.dart';
import 'package:lucky/checkOutScreen/addressModel.dart';
import 'package:lucky/checkOutScreen/addressService.dart';
import 'package:lucky/checkOutScreen/orderModel.dart';
import 'package:lucky/constants/Utilities.dart';
import 'package:lucky/products/productModel.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key key, this.orderModel}) : super(key: key);

  final OrderModel orderModel;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  AddressModel addressModel;
  List<Cart> cartList = [];

  @override
  void initState() {
    super.initState();
    getAddress();
    getCart();
  }

  getAddress() async {
    AddressService addressService = AddressService();
    var address =
        await addressService.getAddressById(widget.orderModel.addressId);
    setState(() {
      addressModel = address;
    });
  }

  getCart() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Order No : " + widget.orderModel.orderNumber),
                      Spacer(),
                      Text(getOrderStatus(widget.orderModel.orderStatus))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.orderModel.cartList.length.toString() + " items"),
                  Divider(),
                  Row(
                    children: [
                      Text("Order placed on "),
                      Text(
                        getFormattedDateYearOrNot(
                            widget.orderModel.createDate, "d M"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("for "),
                      Text(
                        "\u{20B9}" +
                            "${widget.orderModel.finalPayment.truncate() == widget.orderModel.finalPayment ? widget.orderModel.finalPayment.truncate() : widget.orderModel.finalPayment}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Delivery Address :", style: TextStyle(fontSize: 12),),
                  Text(
                      "near ${addressModel.landmark}, ${addressModel.fullAddress}, ${addressModel.city}"),
                  
                  SizedBox(height: 20,),
                  Text("Contact Number :", style: TextStyle(fontSize: 12),),
                  Text(widget.orderModel.contactNumber)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
