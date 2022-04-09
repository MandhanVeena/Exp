import 'package:cloud_firestore/cloud_firestore.dart';
import 'addressModel.dart';

class AddressService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'address';

  void createAddress(AddressModel addressModel) async {

    final addRef = _firestore.collection(ref).doc(addressModel.addressId);
    final address = await addRef.get();
    if (address.exists) {
      await addRef.update({
        'fullAddress': addressModel.fullAddress,
        'landmark': addressModel.landmark,
        'city': addressModel.city
      });
    } else {
      await addRef.set(addressModel.toJson());
    }
  }

  Future getAddressById(String addressId) async {
    AddressModel address;
    try {
      await _firestore.collection(ref).doc(addressId).get().then((value) {
        address = AddressModel(
            addressId, value["fullAddress"], value["landmark"], value["city"]);
      });
      return address;
    } catch (e) {
      print(e.toString());
    }
  }
}
