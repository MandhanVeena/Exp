import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';

class PhoneAuthService {
  final FirebaseAuth firebaseAuth;

  PhoneAuthService(this.firebaseAuth);

  Stream<User> get authStateChanges => firebaseAuth.authStateChanges();
  String verificationCode;
  bool isLoading = false;
  bool otpSent = false;

  Future<void> signOut() async {
    firebaseAuth.signOut();
    GoogleSignIn().signOut();
    otpSent = false;
  }

  // Future<String> loginWithPhone(String verificationCode, String otp) async {
  //   try {
  //     await firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
  //         verificationId: verificationCode, smsCode: otp));
  //     //     .then((value) {
  //     //   if (value.user != null) {
  //     //     Navigator.pushAndRemoveUntil(
  //     //         context,
  //     //         MaterialPageRoute(
  //     //             builder: (context) => CheckOutScreen()),
  //     //         (route) => false);
  //     //   }
  //     //   print("Pin"+otpController.text+verificationCode);
  //     // });
  //     return "Login successful";
  //   } on FirebaseAuthException catch (e) {
  //     return e.toString();
  //   }
  // }

  Future verifyPhone(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      // timeout: Duration(seconds: 90)
    );
    otpSent = true;
    isLoading = false;
    //otpSent = false;
    //return "";
  }

  codeAutoRetrievalTimeout(String verificationId) {
    verificationCode = verificationId;
    otpSent = true;
  }

  codeSent(String verificationId, int resendToken) {
    verificationCode = verificationId;
    otpSent = true;
  }

  verificationFailed(FirebaseAuthException e) {
    Fluttertoast.showToast(msg: e.message);
    isLoading = false;
    otpSent = false;
  }

  verificationCompleted(PhoneAuthCredential credential) async {
    otpSent = true;
    await firebaseAuth.signInWithCredential(credential);
    if (firebaseAuth.currentUser != null) {
      //isLoading = true;
    } else {
      Fluttertoast.showToast(msg: "Failed to sign in");
    }
    otpSent = false;
  }

  Future verifyOtp(String otp) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationCode, smsCode: otp);
    otpSent = true;
    try {
      await firebaseAuth.signInWithCredential(credential);
      if (firebaseAuth.currentUser != null) {
        //isLoading = true;
      }
    } catch (e) {
      print(e.toString());
    }
    otpSent = false;
  }
}
