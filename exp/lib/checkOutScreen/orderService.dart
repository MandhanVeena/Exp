import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'orderModel.dart';

class OrderService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'orders';

  Future<String> createOrder(OrderModel orderModel) async {
    await _firestore
        .collection(ref)
        .doc(orderModel.orderId)
        .set(orderModel.toJson())
        .catchError((e) {
      print(e.toString());
      return e.toString();
    });

    print("Order Successful");
    return "Order Successful";

    // _firestore.collection(ref).doc(orderModel.orderId).set({
    //   'orderId': orderModel.orderId,
    //   'addressId': orderModel.addressId,
    //   'contactNumber': orderModel.contactNumber,
    //   'orderStatus': orderModel.orderStatus,
    //   'createDate': orderModel.createDate,
    //   'comment': orderModel.comment,
    //   'orderNumber': orderModel.orderNumber,
    //   'isCod': orderModel.isCod,
    //   'cartList': orderModel.cartList.map((e) => e.toJson()).toList(),
    //   'totalPayment': orderModel.totalPayment,
    //   'finalPayment': orderModel.finalPayment,
    //   'discount': orderModel.discount,
    //   'shippingCost': orderModel.shippingCost,
    //   'userId': orderModel.userId,
    //   'isUrgent': orderModel.isUrgent,
    // });
  }

//   Future getOrders() async {
//     List orders = [];
//     try {
//       await _firestore
//           .collection(ref)
//           .get()
//           .then((value) => value.docs.forEach((element) {
//                 orders.add(element.data());
//               }));
//       return orders;
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }

  Future<List<OrderModel>> getMyOrders() async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    List<OrderModel> orders = List.empty(growable: true);
    print(userId);
    try {
      var source = _firestore.collection(ref).where('userId', isEqualTo: userId);

      await source.orderBy("createDate", descending: true)
          .get()
          .then((value) => value.docs.forEach((element) {
                orders.add(OrderModel.fromJson(element.data()));
              }));
      // await _firestore
      //     .collection(ref)
      //     .doc(userId)
      //     .get()
      //     .then((value) => value.docs.forEach((element) {
      //           orders.add(element.data());
      //         }));

    } catch (e) {
      print(e.toString());
    }
    return orders;
  }
}

//orderModel.cartList.map((e) => e.toJson()).toList()