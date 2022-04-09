// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:lucky/checkOutScreen/addressModel.dart';
// import 'package:package_info/package_info.dart';
// import 'package:device_info/device_info.dart';
// import 'package:uuid/uuid.dart';

// class AuthenticationService {
//   final FirebaseAuth firebaseAuth;

//   AuthenticationService(this.firebaseAuth);

//   Stream<User> get authStateChanges => firebaseAuth.authStateChanges();
//   String verificationCode;

//   Future<void> signOut() async {
//     firebaseAuth.signOut();
//     GoogleSignIn().signOut();
//   }

//   signInWithGoogle() async {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     GoogleSignInAccount acc = await googleSignIn.signIn();
//     GoogleSignInAuthentication auth = await acc.authentication;
//     final credential = GoogleAuthProvider.credential(
//         accessToken: auth.accessToken, idToken: auth.idToken);
//     final res = await firebaseAuth.signInWithCredential(credential);
//     return res.user;
//   }

//   Future<String> signIn({String email, String password}) async {
//     try {
//       await firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return "success";
//       //return res.user;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//       //print(e.message);
//     }
//   }

//   Future<String> signUp({String email, String password}) async {
//     try {
//       await firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return "success";
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//       return e.message;
//     }
//   }

//   Future<String> loginWithPhone(String verificationCode, String otp) async {
//     try {
//       await firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
//           verificationId: verificationCode, smsCode: otp));
//       //     .then((value) {
//       //   if (value.user != null) {
//       //     Navigator.pushAndRemoveUntil(
//       //         context,
//       //         MaterialPageRoute(
//       //             builder: (context) => CheckOutScreen()),
//       //         (route) => false);
//       //   }
//       //   print("Pin"+otpController.text+verificationCode);
//       // });
//       return "Login successful";
//     } on FirebaseAuthException catch (e) {
//       return e.toString();
//     }
//   }

//   Future autoVerifyPhone(String phoneNumber) async{
//       await firebaseAuth.verifyPhoneNumber(
//         phoneNumber: "+91$phoneNumber",
//         verificationCompleted: (PhoneAuthCredential credential) async{
//          await FirebaseAuth.instance.signInWithCredential(credential);
//           //     .then((value) async {
//           //   if (value.user != null) {
//           //     Navigator.pushReplacement(
//           //       context,
//           //       MaterialPageRoute(builder: (context) => CheckOutScreen()),
//           //     );
//           //   }
//           // });
//           Fluttertoast.showToast(msg: "Login Successful");
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           Fluttertoast.showToast(msg: e.toString());
//         },
//         codeSent: (String verificationId, int resendToken) {
//           print("sent");
//           // verificationCode = verificationId;
//           return verificationId;
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // setState(() {
//           //   verificationCode = verificationId;
//           // });
//         },
//         // timeout: Duration(seconds: 90)
//       );
//     //return "";
//   }
// }