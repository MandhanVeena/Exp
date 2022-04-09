// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import '../auth_service.dart';

// class SignUpPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 100,
//               ),
//               Text(
//                 "Sign Up",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//               ),
//               TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: "Password"),
//               ),
//               TextField(
//                 controller: confirmPasswordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: "Confirm Password"),
//               ),
//               RaisedButton(
//                 onPressed: () async {
//                   if (emailController.text.isEmpty ||
//                       passwordController.text.isEmpty) {
//                     Fluttertoast.showToast(
//                         msg: "Email and password cannot be empty");
//                     return;
//                   }
//                   if (confirmPasswordController.text.isEmpty ||
//                       confirmPasswordController.text !=
//                           passwordController.text) {
//                     Fluttertoast.showToast(msg: "Password doesn't match");
//                     return;
//                   }
//                   final msg = await context
//                       .read<AuthenticationService>()
//                       .signUp(
//                           email: emailController.text.trim(),
//                           password: passwordController.text.trim());
//                   if (msg == "success") {
//                     Fluttertoast.showToast(msg: "Signed Up Successfully");
//                     Navigator.pop(context);
//                   } else {
//                     Fluttertoast.showToast(msg: msg);
//                   }
//                 },
//                 child: Text("Sign Up"),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               RaisedButton(
//                   child: Text("Login with Google"),
//                   onPressed: () async {
//                     try {
//                       await context
//                           .read<AuthenticationService>()
//                           .signInWithGoogle();
//                     } catch (e) {
//                       print(e);
//                     }
//                   })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
