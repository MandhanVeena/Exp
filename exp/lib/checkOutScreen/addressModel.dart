
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String addressId, fullAddress, landmark, city;

  AddressModel(
      this.addressId, this.fullAddress, this.landmark, this.city);

  AddressModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    addressId = json['addressId'];
    fullAddress = json['fullAddress'];
    landmark = json['landmark'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['addressId'] = this.addressId;
    data['fullAddress'] = this.fullAddress;
    data['landmark'] = this.landmark;
    data['city'] = this.city;

    return data;
  }
}
