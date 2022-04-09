import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lucky/users/auth_service.dart';
import 'package:lucky/constants/constants.dart';
import 'Home/home.dart';
import 'package:lucky/services/phoneAuthService.dart';
import 'package:provider/provider.dart';
import 'cartScreen/cartStore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PhoneAuthService>(
            create: (_) => PhoneAuthService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) =>
              context.read<PhoneAuthService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (context) => MyStore(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Exp',
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            primaryColor: themeColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor),
          ),
        home: HomeScreen()),
    );
  }
}


