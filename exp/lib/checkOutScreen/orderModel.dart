class OrderModel {
  String userId = "",
      comment = "",
      orderNumber = "",
      orderId = "",
      addressId = "",
      contactNumber = "",
      paymentOption = "";
  double totalPayment = 0, finalPayment = 0, shippingCost = 0, discount = 0;
  bool isUrgent = false;
  List<FinalCart> cartList = List<FinalCart>.empty(growable: true);
  int orderStatus = 0, createDate = 0;

  OrderModel(
      this.orderId,
      this.userId,
      this.addressId,
      this.contactNumber,
      this.comment,
      this.orderNumber,
      this.totalPayment,
      this.finalPayment,
      this.shippingCost,
      this.discount,
      this.paymentOption,
      this.isUrgent,
      this.cartList,
      this.orderStatus,
      this.createDate);

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    userId = json['userId'];
    addressId = json['addressId'];
    contactNumber = json['contactNumber'];
    comment = json['comment'];
    orderNumber = json['orderNumber'];
    totalPayment = double.parse(json['totalPayment'].toString());
    finalPayment = double.parse(json['finalPayment'].toString());
    shippingCost = double.parse(json['shippingCost'].toString());
    discount = double.parse(json['discount'].toString());
    paymentOption = json['paymentOption'];
    isUrgent = json['isUrgent'] as bool;
    orderStatus = int.parse(json['orderStatus'].toString());
    createDate = int.parse(json['createDate'].toString());

    if (json['cartList'] != null) {
      json['cartList'].forEach((v) {
        cartList.add(FinalCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    data['addressId'] = this.addressId;
    data['contactNumber'] = this.contactNumber;
    data['comment'] = this.comment;
    data['orderNumber'] = this.orderNumber;
    data['totalPayment'] = this.totalPayment;
    data['finalPayment'] = this.finalPayment;
    data['shippingCost'] = this.shippingCost;
    data['discount'] = this.discount;
    data['paymentOption'] = this.paymentOption;
    data['isUrgent'] = this.isUrgent;
    data['orderStatus'] = this.orderStatus;
    data['createDate'] = this.createDate;
    data['cartList'] = this.cartList.map((e) => e.toJson()).toList();
    return data;
  }
}

class FinalCart {
  String productId = "", qty = "";
  int number = 0;

  FinalCart(
    this.productId,
    this.number,
    this.qty,
  );

  FinalCart.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    number = int.parse(json['number'].toString());
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['productId'] = this.productId;
    data['number'] = this.number;
    data['qty'] = this.qty;

    return data;
  }
}
