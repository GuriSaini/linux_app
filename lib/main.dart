import 'package:firebase_core/firebase_core.dart';
import 'package:linux_app/screens/dashboard.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:linux_app/firebase_options.dart';
import 'package:linux_app/screens/login.dart';

import 'screens/dashboard.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    var response = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print(response);
  } catch (e) {
    print(e);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashBoard("Dashboard"),
    );
  }
}
