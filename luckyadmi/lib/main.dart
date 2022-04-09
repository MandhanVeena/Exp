//import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luckyadmi/auth_service.dart';
import 'package:luckyadmi/model/productStore.dart';
import 'package:luckyadmi/screens/signInPage.dart';
import 'package:provider/provider.dart';
import 'screens/admin/admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance)),
      StreamProvider(
        create: (context) =>
            context.read<AuthenticationService>().authStateChanges, initialData: null,
      ),
      // ChangeNotifierProvider(
      //   create: (context) => MyStore(),)
    ],
    child: MaterialApp(home: AuthenticationWrapper()),
  ));
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return Admin();
    } else {
      return SignInPage();
    }
  }
}
