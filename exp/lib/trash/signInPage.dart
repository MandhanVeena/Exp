// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:lucky/screens/signUpPage.dart';
// import 'package:provider/provider.dart';
// import '../auth_service.dart';

// class SignInPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

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
//                 "Login",
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
//               RaisedButton(
//                 onPressed: () async{
//                   if (emailController.text.isEmpty ||
//                       passwordController.text.isEmpty) {
//                     print("Email and password cannot be empty");
//                     return;
//                   }
//                   final msg = await context.read<AuthenticationService>().signIn(
//                       email: emailController.text.trim(),
//                       password: passwordController.text.trim());
//                   if (msg == "success") {
//                     Fluttertoast.showToast(msg: "Login Successful");
//                   } else {
//                     Fluttertoast.showToast(msg: msg);
//                   }
//                 },
//                 child: Text("Login"),
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
//                   }),
//               SizedBox(height: 40,),
//               RaisedButton(
//                   child: Text("Create Account"),
//                   onPressed: () async {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
