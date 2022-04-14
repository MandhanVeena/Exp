import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luckyadmi/model/userModel.dart';
import 'package:device_info/device_info.dart';
import 'package:uuid/uuid.dart';

class UserHelper {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static saveUser(UserModel userModel) async {
    // Map<String, dynamic> userData = {
    //   "userId": userModel.user.uid,
    //   "name": userModel.username,
    //   "phone": userModel.user.phoneNumber,
    //   "lastSignInTime":
    //       userModel.user.metadata.lastSignInTime.millisecondsSinceEpoch,
    //   "creationTime":
    //       userModel.user.metadata.creationTime.millisecondsSinceEpoch,
    //   "role": "user",
    //   "buildNumber": buildNumber,
    //   "addressList": userModel.addressIdsList
    // };

    final userRef = db.collection("users").doc(userModel.userId);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "lastSignInTime": userModel.lastSignInTime,
        "buildNumber": userModel.buildNumber,
        "username": userModel.username,
        "addressIdsList": userModel.addressIdsList
      });
    } else {
      await userRef.set(userModel.toJson());
    }
    await saveDevice(userModel);
  }

  static saveDevice(UserModel userModel) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceId;
    Map<String, dynamic> deviceData;
    if (Platform.isAndroid) {
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = {
        "OSversion": deviceInfo.version.sdkInt.toString(),
        "platform": "android",
        "model": deviceInfo.model,
        "device": deviceInfo.device
      };
    } else if (Platform.isIOS) {
      final deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        "OSversion": deviceInfo.systemVersion,
        "platform": "iOS",
        "model": deviceInfo.model,
        "device": deviceInfo.name
      };
    }

    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final deviceRef = db
        .collection("users")
        .doc(userModel.userId)
        .collection("devices")
        .doc(deviceId);

    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        "updatedAt": nowMs,
        "uninstalled": false,
      });
    } else {
      await deviceRef.set({
        "createdAt": nowMs,
        "updatedAt": nowMs,
        "uninstalled": false,
        "id": deviceId,
        "deviceInfo": deviceData
      });
    }
  }

  static Future<UserModel> getUserById(String userId) async {
    UserModel userModel;
    try {
      await db.collection("users").doc(userId).get().then((value) {
        List<String> addressIdsList = [];
        value["addressIdsList"].forEach((element) {
          addressIdsList.add(element);
        });
        print(addressIdsList);
        userModel = UserModel(
            value["userId"],
            value["username"],
            value["phone"],
            value["role"],
            addressIdsList,
            value["lastSignInTime"],
            value["creationTime"],
            value["buildNumber"]);
      });
    } catch (e) {
      print(e.toString());
    }
    print("UserModel");
    print(userModel.toString());
    return userModel;
  }

  static Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .get()
          .then((value) => value.docs.forEach((element) {
                List<String> addressIdsList = [];
                element["addressIdsList"].forEach((element) {
                  addressIdsList.add(element);
                });
                print(addressIdsList);

                users.add(UserModel(
                    element["userId"],
                    element["username"],
                    element["phone"],
                    element["role"],
                    addressIdsList,
                    element["lastSignInTime"],
                    element["creationTime"],
                    element["buildNumber"]));
              }));
    } catch (e) {
      print(e.toString());
    }
    return users;
  }
}
