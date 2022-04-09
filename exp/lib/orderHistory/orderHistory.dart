import 'package:flutter/material.dart';
import 'package:lucky/checkOutScreen/orderModel.dart';
import 'package:lucky/checkOutScreen/orderService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucky/constants/constants.dart';
import 'package:lucky/orderHistory/orderDetails.dart';
import 'package:lucky/products/productModel.dart';
import '../constants/Utilities.dart';
import 'package:date_time_format/date_time_format.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  OrderService orderService = OrderService();

  List<OrderModel> orders = [];
  List<Product> orderProducts = [];

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  getOrders() async {
    var orderHistory = await orderService.getMyOrders();
    setState(() {
      orders = orderHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Order History"),
            ),
            body: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderHistoryItem(
                    orderModel: orders[index],
                  );
                })));
  }
}

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({Key key, this.orderModel}) : super(key: key);

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetails(
                      orderModel: orderModel,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(clipBehavior: Clip.hardEdge, children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Order No : " + orderModel.orderNumber),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(orderModel.cartList.length.toString() + " items"),
                  Divider(),
                  Row(
                    children: [
                      Text("Order placed on  "),
                      Text(
                        getFormattedDateYearOrNot(orderModel.createDate, "d M"),
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
                            "${orderModel.finalPayment.truncate() == orderModel.finalPayment ? orderModel.finalPayment.truncate() : orderModel.finalPayment}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(15)),
                child: Text(getOrderStatus(orderModel.orderStatus),
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          ),
        ]),
      ),
    );
  }
}
