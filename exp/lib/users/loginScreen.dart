import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lucky/constants/constants.dart';
import '../checkOutScreen/checkOutScreen.dart';
import 'package:lucky/services/phoneAuthService.dart';

import 'auth_service.dart';
import 'package:provider/provider.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<PhoneAuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
        backgroundColor: themeColor,
      ),
      body: loginProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : loginProvider.otpSent
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          "Verify +91-${phoneController.text}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Enter OTP",
                        ),
                        //  onEditingComplete: () async{
                        //    if(otpController.text == verificationCode){
                        //      final verificationCode =
                        //           context.read<AuthenticationService>().verificationCode;
                        //       final msg = await context
                        //           .read<AuthenticationService>()
                        //           .loginWithPhone(verificationCode, otpController.text);
                        //       Navigator.pop(context);
                        //       Fluttertoast.showToast(msg: msg);
                        //    }
                        //  },
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        controller: otpController,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      child: FlatButton(
                          onPressed: () async {
                            setState(() {
                              loginProvider.isLoading = true;
                              loginProvider.verifyOtp(otpController.text);
                            });
                          },
                          color: themeColor,
                          child: Text(
                            "Verify",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Phone number",
                            prefix: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text("+91"),
                            )),
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      child: FlatButton(
                          onPressed: () async {
                            setState(() {
                              loginProvider.isLoading = true;
                              loginProvider.verifyPhone(phoneController.text);
                            });
                          },
                          color: themeColor,
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
    );
  }
}

// class OTPScreen extends StatefulWidget {
//   final String phone;
//   OTPScreen({Key key, this.phone}) : super(key: key);

//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   String verificationCode;
//   int start = 90;
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController otpController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     //verifyPhone();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //context.read<AuthenticationService>().autoVerifyPhone(widget.phone);

//     // final BoxDecoration pinPutDecoration = BoxDecoration(
//     //   color: const Color.fromRGBO(43, 46, 66, 1),
//     //   borderRadius: BorderRadius.circular(10.0),
//     //   border: Border.all(
//     //     color: const Color.fromRGBO(126, 203, 224, 1),
//     //   ),
//     // );

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: themeColor,
//         title: Text("OTP verification"),
//       ),
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 40),
//             child: Center(
//               child: Text(
//                 "Verify +91-${widget.phone}",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding: EdgeInsets.all(30),
//           //   child: OTPTextField(
//           //     length: 6,
//           //     width: MediaQuery.of(context).size.width - 20,
//           //     fieldWidth: 30,
//           //     style: TextStyle(fontSize: 17),
//           //     textFieldAlignment: MainAxisAlignment.spaceAround,
//           //     fieldStyle: FieldStyle.underline,
//           //     onCompleted: (pin) async {
//           //       print(pin+verificationCode);
//           //       try {
//           //         await FirebaseAuth.instance
//           //             .signInWithCredential(PhoneAuthProvider.credential(
//           //                 verificationId: verificationCode, smsCode: pin))
//           //             .then((value) {
//           //           if (value.user != null) {
//           //             Navigator.pushAndRemoveUntil(
//           //                 context,
//           //                 MaterialPageRoute(
//           //                     builder: (context) => CheckOutScreen()),
//           //                 (route) => false);
//           //           }
//           //           print("Pin"+pin+verificationCode);
//           //         });
//           //       } catch (e) {
//           //         print(e.toString());
//           //         Fluttertoast.showToast(msg: "Invalid OTP");
//           //       }
//           //     },
//           //   ),
//           // )
//           Container(
//             margin: EdgeInsets.only(top: 40, right: 10, left: 10),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: "Enter OTP",
//               ),
//              onEditingComplete: () async{
//                if(otpController.text == verificationCode){
//                  final verificationCode =
//                       context.read<AuthenticationService>().verificationCode;
//                   final msg = await context
//                       .read<AuthenticationService>()
//                       .loginWithPhone(verificationCode, otpController.text);
//                   Navigator.pop(context);
//                   Fluttertoast.showToast(msg: msg);
//                }
//              },
//               maxLength: 6,
//               keyboardType: TextInputType.number,
//               controller: otpController,
//             ),
//           ),
//           Spacer(),
//           Container(
//             margin: EdgeInsets.all(10),
//             width: double.infinity,
//             child: FlatButton(

//                 onPressed: () async {
//                   // try {
//                   //   await FirebaseAuth.instance.signInWithCredential(
//                   //       PhoneAuthProvider.credential(
//                   //           verificationId: verificationCode,
//                   //           smsCode: otpController.text));
//                   //   //     .then((value) {
//                   //   //   if (value.user != null) {
//                   //   //     Navigator.pushAndRemoveUntil(
//                   //   //         context,
//                   //   //         MaterialPageRoute(
//                   //   //             builder: (context) => CheckOutScreen()),
//                   //   //         (route) => false);
//                   //   //   }
//                   //   //   print("Pin"+otpController.text+verificationCode);
//                   //   // });
//                   // } catch (e) {
//                   //   print(e.toString());
//                   //   Fluttertoast.showToast(msg: e.toString());
//                   // }

//                   final verificationCode =
//                       context.read<AuthenticationService>().verificationCode;
//                   final msg = await context
//                       .read<AuthenticationService>()
//                       .loginWithPhone(verificationCode, otpController.text);
//                   Navigator.pop(context);
//                   Fluttertoast.showToast(msg: msg);
//                 },
//                 color: themeColor,
//                 child: Text(
//                   "Verify",
//                   style: TextStyle(color: Colors.white),
//                 )),
//           )
//         ],
//       ),
//     );
//   }

//   verifyPhone() async {

//     var store = Provider.of<AuthenticationService>(context, listen: false);
//     verificationCode = await store.autoVerifyPhone(widget.phone);
//     // Navigator.pop(context);
//     // String msg = await context
//     //     .read<AuthenticationService>()
//     //     .autoVerifyPhone(widget.phone);
//     //Navigator.pop(context);
    
//     //startTimer();
//     // await FirebaseAuth.instance.verifyPhoneNumber(
//     //   phoneNumber: "+91${widget.phone}",
//     //   verificationCompleted: (PhoneAuthCredential credential) async {
//     //     await FirebaseAuth.instance
//     //         .signInWithCredential(credential)
//     //         .then((value) async {
//     //       if (value.user != null) {
//     //         Navigator.pushReplacement(
//     //           context,
//     //           MaterialPageRoute(builder: (context) => CheckOutScreen()),
//     //         );
//     //       }
//     //     });
//     //   },
//     //   verificationFailed: (FirebaseAuthException e) {
//     //     Fluttertoast.showToast(msg: e.message);
//     //   },
//     //   codeSent: (String verificationId, int resendToken) {
//     //     setState(() {
//     //       verificationCode = verificationId;
//     //     });
//     //   },
//     //   codeAutoRetrievalTimeout: (String verificationId) {
//     //     // setState(() {
//     //     //   verificationCode = verificationId;
//     //     // });
//     //   },
//     //   // timeout: Duration(seconds: 90)
//     // );
//   }

//   void startTimer() {
//     var onsec = Duration(seconds: 1);
//     Timer.periodic(onsec, (timer) {
//       if (start == 0) {
//         setState(() {
//           timer.cancel();
//         });
//       } else {
//         setState(() {
//           start--;
//         });
//       }
//     });
//   }
// }
